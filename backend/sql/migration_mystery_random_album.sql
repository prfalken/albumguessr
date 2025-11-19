-- Migration to add or update mystery_random_album table
-- This table stores random albums selected for mystery cover guess game mode
-- Albums can appear multiple times with different genres

-- Drop the old table if it exists with wrong schema
DROP TABLE IF EXISTS mystery_random_album;

-- Create table with composite primary key
CREATE TABLE mystery_random_album (
  object_id TEXT NOT NULL,
  primary_genre TEXT NOT NULL,
  PRIMARY KEY (object_id, primary_genre)
);

