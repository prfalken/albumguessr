-- User history table for Neon (serverless Postgres)
-- game_mode distinguishes between 'daily' (album of the day) and 'random' (regular game)
CREATE TABLE IF NOT EXISTS user_album_history (
  user_id TEXT NOT NULL,
  object_id TEXT NOT NULL,
  title TEXT NOT NULL,
  artists JSONB NOT NULL,
  release_year INT,
  cover_url TEXT,
  guesses INT NOT NULL,
  game_mode TEXT NOT NULL DEFAULT 'random' CHECK (game_mode IN ('daily', 'random')),
  ts TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, object_id, game_mode)
);


-- Mystery album of the day schedule
-- One row per calendar day with the selected album's Algolia objectID
CREATE TABLE IF NOT EXISTS mystery_album_schedule (
  schedule_date DATE PRIMARY KEY,
  object_id TEXT NOT NULL
);

-- User profiles table to cache Auth0 user data
-- Used for displaying usernames and avatars in rankings without querying Auth0 each time
CREATE TABLE IF NOT EXISTS user_profiles (
  user_id TEXT PRIMARY KEY,
  custom_username TEXT,
  email TEXT,
  picture TEXT,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

