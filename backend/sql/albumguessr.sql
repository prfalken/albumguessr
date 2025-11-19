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
  object_id TEXT NOT NULL,
  primary_genre TEXT
);

-- User profiles table to cache Auth0 user data
-- Used for displaying usernames and avatars in rankings without querying Auth0 each time
-- admin column: 1 = admin user with access to backoffice features, 0 = regular user
CREATE TABLE IF NOT EXISTS user_profiles (
  user_id TEXT PRIMARY KEY,
  custom_username TEXT,
  email TEXT,
  picture TEXT,
  admin INTEGER DEFAULT 0,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Grant admin access to specific user (run manually as needed):
-- INSERT INTO user_profiles (user_id, admin, updated_at) 
-- VALUES ('google-oauth2|110253643736011489857', 1, now())
-- ON CONFLICT (user_id) DO UPDATE SET admin = 1;

-- Mystery random album table
-- Stores random albums for mystery cover guess game mode
-- Albums can appear multiple times with different genres
CREATE TABLE IF NOT EXISTS mystery_random_album (
  object_id TEXT NOT NULL,
  primary_genre TEXT NOT NULL,
  PRIMARY KEY (object_id, primary_genre)
);

