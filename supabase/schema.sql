create extension if not exists pgcrypto;

-- PLAYER PROFILES
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique not null,
  avatar_url text,
  xp integer default 0,
  level integer default 1,
  elo integer default 1000,
  rank_name text default 'Bronze',
  wins integer default 0,
  losses integer default 0,
  games_played integer default 0,
  created_at timestamptz default now()
);

-- FRIENDS
create table if not exists public.friends (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  friend_id uuid references auth.users(id) on delete cascade,
  status text default 'pending',
  created_at timestamptz default now(),
  unique(user_id, friend_id)
);

-- MATCHES
create table if not exists public.matches (
  id uuid primary key default gen_random_uuid(),
  player1 uuid references auth.users(id),
  player2 uuid references auth.users(id),
  winner uuid references auth.users(id),
  status text default 'waiting',
  mode text default 'casual',
  score1 integer default 0,
  score2 integer default 0,
  created_at timestamptz default now()
);

-- MATCH ROUNDS
create table if not exists public.match_rounds (
  id uuid primary key default gen_random_uuid(),
  match_id uuid references public.matches(id) on delete cascade,
  round_number integer default 1,
  meme_id text,
  question text,
  answer text,
  winner uuid references auth.users(id),
  created_at timestamptz default now()
);

-- LEADERBOARD
create table if not exists public.leaderboard (
  user_id uuid primary key references auth.users(id) on delete cascade,
  elo integer default 1000,
  wins integer default 0,
  updated_at timestamptz default now()
);

-- ENABLE RLS
alter table public.profiles enable row level security;
alter table public.friends enable row level security;
alter table public.matches enable row level security;
alter table public.match_rounds enable row level security;
alter table public.leaderboard enable row level security;

-- PROFILE POLICIES
create policy "Profiles visible to authenticated"
on public.profiles
for select to authenticated
using (true);

create policy "Users update own profile"
on public.profiles
for update to authenticated
using (auth.uid() = id)
with check (auth.uid() = id);

-- FRIEND POLICIES
create policy "Users view own friendships"
on public.friends
for select to authenticated
using (auth.uid() = user_id or auth.uid() = friend_id);

create policy "Users create friendship"
on public.friends
for insert to authenticated
with check (auth.uid() = user_id);

-- MATCH POLICIES
create policy "Players view own matches"
on public.matches
for select to authenticated
using (auth.uid() = player1 or auth.uid() = player2);

-- ROUND POLICIES
create policy "Players view rounds"
on public.match_rounds
for select to authenticated
using (
  exists (
    select 1 from public.matches
    where matches.id = match_rounds.match_id
    and (matches.player1 = auth.uid() or matches.player2 = auth.uid())
  )
);

-- LEADERBOARD POLICY
create policy "Leaderboard visible"
on public.leaderboard
for select to authenticated
using (true);

-- AUTO CREATE PROFILE AFTER SIGNUP
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, username)
  values (
    new.id,
    coalesce(
      new.raw_user_meta_data->>'username',
      'player_' || substr(new.id::text, 1, 8)
    )
  );

  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;

create trigger on_auth_user_created
after insert on auth.users
for each row
execute procedure public.handle_new_user();
