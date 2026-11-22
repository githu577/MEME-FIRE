const express = require("express");
const cors = require("cors");
const { createClient } = require("@supabase/supabase-js");

const app = express();

app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3000;
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error("Missing Supabase environment variables");
  process.exit(1);
}

const supabase = createClient(
  SUPABASE_URL,
  SUPABASE_KEY,
  {
    auth: {
      autoRefreshToken: false,
      persistSession: false
    }
  }
);

// HOME
app.get("/", (req, res) => {
  res.json({
    name: "MEME HUNT API",
    status: "online",
    version: "1.0.0"
  });
});

// HEALTH CHECK
app.get("/health", (req, res) => {
  res.json({
    status: "healthy",
    service: "meme-hunt-backend"
  });
});

// AUTH MIDDLEWARE
async function authenticate(req, res, next) {
  try {
    const header = req.headers.authorization || "";
    const token = header.replace(/^Bearer\s+/i, "");

    if (!token) {
      return res.status(401).json({
        error: "Authentication required"
      });
    }

    const { data, error } = await supabase.auth.getUser(token);

    if (error || !data.user) {
      return res.status(401).json({
        error: "Invalid session"
      });
    }

    req.user = data.user;
    next();
  } catch (error) {
    res.status(401).json({
      error: "Authentication failed"
    });
  }
}

// PLAYER PROFILE
app.get("/api/profile", authenticate, async (req, res) => {
  try {
    const { data, error } = await supabase
      .from("profiles")
      .select("*")
      .eq("id", req.user.id)
      .maybeSingle();

    if (error) throw error;

    res.json({ profile: data });
  } catch (error) {
    res.status(500).json({
      error: "Could not load profile"
    });
  }
});

// LEADERBOARD
app.get("/api/leaderboard", authenticate, async (req, res) => {
  try {
    const { data, error } = await supabase
      .from("leaderboard")
      .select("*")
      .order("elo", { ascending: false })
      .limit(50);

    if (error) throw error;

    res.json({ leaderboard: data });
  } catch (error) {
    res.status(500).json({
      error: "Could not load leaderboard"
    });
  }
});

// CREATE MATCH
app.post("/api/matches", authenticate, async (req, res) => {
  try {
    const { mode } = req.body;

    const allowedModes = ["casual", "ranked", "private"];

    if (!allowedModes.includes(mode)) {
      return res.status(400).json({
        error: "Invalid game mode"
      });
    }

    const { data, error } = await supabase
      .from("matches")
      .insert({
        player1: req.user.id,
        mode: mode,
        status: "waiting"
      })
      .select()
      .single();

    if (error) throw error;

    res.status(201).json({
      message: "Match created",
      match: data
    });
  } catch (error) {
    res.status(500).json({
      error: "Could not create match"
    });
  }
});

// GET MY MATCHES
app.get("/api/matches", authenticate, async (req, res) => {
  try {
    const { data, error } = await supabase
      .from("matches")
      .select("*")
      .or(
        `player1.eq.${req.user.id},player2.eq.${req.user.id}`
      )
      .order("created_at", { ascending: false })
      .limit(20);

    if (error) throw error;

    res.json({ matches: data });
  } catch (error) {
    res.status(500).json({
      error: "Could not load matches"
    });
  }
});

// SERVER
app.listen(PORT, "0.0.0.0", () => {
  console.log(`MEME HUNT API running on port ${PORT}`);
});
