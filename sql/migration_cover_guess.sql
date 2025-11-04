-- Migration to add points column and support cover-guess game mode

-- Add points column to user_album_history
ALTER TABLE user_album_history 
ADD COLUMN IF NOT EXISTS points INT;

-- Update the CHECK constraint to include 'cover-guess'
-- First, drop the old constraint
ALTER TABLE user_album_history 
DROP CONSTRAINT IF EXISTS user_album_history_game_mode_check;

-- Add the new constraint with cover-guess support
ALTER TABLE user_album_history 
ADD CONSTRAINT user_album_history_game_mode_check 
CHECK (game_mode IN ('daily', 'random', 'cover-guess'));
