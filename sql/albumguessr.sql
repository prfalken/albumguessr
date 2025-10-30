-- User history table for Neon (serverless Postgres)
CREATE TABLE IF NOT EXISTS user_album_history (
  user_id TEXT NOT NULL,
  object_id TEXT NOT NULL,
  title TEXT NOT NULL,
  artists JSONB NOT NULL,
  release_year INT,
  cover_url TEXT,
  guesses INT NOT NULL,
  ts TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, object_id)
);

