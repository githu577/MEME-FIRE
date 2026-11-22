# MEME HUNT — Phase 1 + Phase 2 starter

This is a Flutter starter for the MEME HUNT Android game. It includes:
- Dark-purple mobile UI and bottom navigation
- Email/password sign up and login using Supabase Auth
- Auth state routing
- Profile read from Supabase
- Sign out
- Initial `profiles` table + RLS + auth trigger

**Not implemented yet:** multiplayer, matchmaking, game rounds, question engine, actual meme library, rankings, admin panel, or scoring. UI cards currently communicate which phase will implement them. Do not treat this as a finished game.

## Requirements
- Flutter SDK installed
- Android Studio or Android SDK
- A Supabase project

## Setup
1. Create a Supabase project.
2. Open Supabase SQL Editor and run `supabase/schema.sql`.
3. In Supabase Project Settings -> API, copy the Project URL and publishable/anon key.
4. From this project folder run:

```bash
flutter pub get
flutter run --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co --dart-define=SUPABASE_ANON_KEY=YOUR_PUBLIC_ANON_KEY
```

Do not use the `service_role` key in the Flutter app.

## Auth notes
If Supabase email confirmation is enabled, users must confirm email before signing in. Configure your email provider and auth redirect settings in Supabase.

## Build Android
```bash
flutter build apk --release --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co --dart-define=SUPABASE_ANON_KEY=YOUR_PUBLIC_ANON_KEY
flutter build appbundle --release --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co --dart-define=SUPABASE_ANON_KEY=YOUR_PUBLIC_ANON_KEY
```

## Phase roadmap
- Phase 1: UI/navigation — starter screens included
- Phase 2: Supabase Auth/profile — included, requires your project credentials and SQL setup
- Phase 3: Meme database/admin/storage
- Phase 4: Matchmaking and rooms with Realtime
- Phase 5: Server-authoritative rounds, turns and questions
- Phase 6: Scoring and leaderboard
- Phase 7: device testing and release builds
