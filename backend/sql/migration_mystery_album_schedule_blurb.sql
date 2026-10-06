-- Adds an optional editorial blurb to each scheduled mystery album.
-- Written per-day from the admin panel; shown on the victory screen and
-- surfaced in the archive once a day is completed.

ALTER TABLE mystery_album_schedule
  ADD COLUMN IF NOT EXISTS blurb TEXT;
