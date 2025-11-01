# AlbumGuessr — MusicBrainz → Algolia indexer + daily guessing game

This repository contains:

- A Python CLI that streams MusicBrainz release groups from PostgreSQL, normalizes album fields, and indexes them into Algolia for fast search.
- A small static frontend game in `frontend/` where you guess the “mystery album” of the day using Algolia-powered search and progressive clues.

## What it does

- Connects to a MusicBrainz PostgreSQL database and selects release groups of primary type "Album" with related metadata (artists, countries, tags → genres, secondary types, contributors, ratings, first release date, and a representative cover art).
- Normalizes each record to a compact object suitable for search and faceting.
- Indexes records to Algolia in batches.
- Provides a static web game that:
  - Picks a daily mystery album from `frontend/mistery-albums.jsonl` (MBIDs).
  - Lets you search the Algolia index and submit guesses.
  - Reveals shared attributes (artists, genres, countries, musicians, year hints) until you find the right album.

## Prerequisites

- Python 3.10+
- Algolia account with:
  - Application ID
  - Admin API key (for indexing from the backend)
  - Search-only API key (for the frontend)
- Access to a MusicBrainz PostgreSQL database (host, port, database name, user, password). You can point to your own instance or a replica populated with MusicBrainz and Cover Art Archive tables.

Note: `KAGGLE_USERNAME`/`KAGGLE_KEY` exist in `config.py` and are not used by the current indexing flow, but the runtime validation currently expects them to be present. Set any dummy values for these two variables in your `.env` to pass validation.

## Install

```bash
git clone <repository-url>
cd albumguessr

python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

## Configure

Create a `.env` file at the project root with your settings:

```env
# Algolia (backend indexing)
ALGOLIA_APPLICATION_ID=your_algolia_app_id
ALGOLIA_API_KEY=your_algolia_admin_api_key
ALGOLIA_INDEX_NAME=albumguessr

# MusicBrainz PostgreSQL
DB_HOST=localhost
DB_PORT=5432
DB_NAME=musicbrainz_db
DB_USER=musicbrainz
DB_PASSWORD=musicbrainz

# Required by current validation (not used by indexing)
KAGGLE_USERNAME=dummy
KAGGLE_KEY=dummy
```

## Usage (backend)

Run the DB-driven sync to index albums to Algolia:

```bash
python main.py
```

Useful flags:

```bash
# Clear existing index
python main.py --clear-index

# Show index stats
python main.py --stats

# Configure index settings (prints current configuration routine)
python main.py --configure

# Limit processed records (for testing) and batch size
python main.py --max-records 1000 --batch-size 500

# Quick search test from CLI
python main.py --search "appetite for destruction"
```

### Record shape indexed to Algolia

Each album is normalized roughly like this:

```json
{
  "objectID": "<release-group-gid>",
  "title": "Ride the Lightning",
  "artists": ["Metallica"],
  "countries": ["US"],
  "genres": ["Thrash Metal"],
  "secondary_types": ["Compilation"],
  "first_release_date": "1984-07-27",
  "release_year": 1984,
  "rating_value": 4.6,       // 0..5, mapped from MusicBrainz 0..100
  "rating_count": 1234,
  "main_artist": "Metallica",
  "primary_genre": "Thrash Metal",
  "cover_art_url": "https://coverartarchive.org/release/<gid>/front",
  "cover_art_url_250": "...-250",
  "cover_art_url_500": "...-500",
  "cover_art_url_1200": "...-1200"
}
```

## Frontend game

The static game lives in `frontend/`.

1) Configure Algolia search credentials in `frontend/config.js`:

```js
const ALGOLIA_CONFIG = {
  applicationId: 'YOUR_APP_ID',
  apiKey: 'YOUR_SEARCH_ONLY_API_KEY',
  indexName: 'albumguessr'
};
```

2) Generate or update the mystery album list (MBIDs) using your DB:

```bash
# Writes top release-group IDs ranked by (rating * rating_count)
python top_release_groups.py --limit 1000 > frontend/mistery-albums.jsonl
```

3) Serve the frontend locally (any static server works):

```bash
cd frontend
python -m http.server 8000
# then open http://localhost:8000 in your browser
```

## Local development (frontend + Netlify Functions)

The Album of the Day API (`/.netlify/functions/albumOfTheDay`) and user history API require a Functions runtime. When serving with a plain static server (e.g., `python -m http.server`), requests to `/.netlify/functions/*` will 404. Use Netlify Dev for local emulation.

### Prerequisites

- Node 20 (matches `netlify.toml`)
- Netlify CLI: `npm i -g netlify-cli` (or use `npx netlify`)

### Configure environment (single .env at repo root)

Place all variables in a single `.env` at the repository root. Netlify Dev loads this file and exposes it to both the frontend build step (`frontend/build-config.js`) and the Functions runtime.

```env
# Algolia (backend indexing)
ALGOLIA_APPLICATION_ID=your_algolia_app_id
ALGOLIA_API_KEY=your_algolia_admin_api_key
ALGOLIA_INDEX_NAME=albumguessr

# Algolia (browser/search-only) — used to generate frontend/config.js
ALGOLIA_SEARCH_API_KEY=your_algolia_search_only_key

# Netlify Functions (Postgres via Neon) — required for APIs
# Example (Neon): postgres://user:password@host/db?sslmode=require
NETLIFY_DATABASE_URL=postgres://...

# Optional Auth0 (only if you enable auth + history)
AUTH0_DOMAIN=your-tenant.eu.auth0.com
AUTH0_CLIENT_ID=abc123
AUTH0_AUDIENCE=your-api-audience
```

**Auth0 Application Settings** (configure in your Auth0 dashboard):
- **Allowed Callback URLs**: Add only the base URLs (the app handles page-specific redirects internally):
  - `http://localhost:8888` (for local development)
  - `https://your-production-domain.com` (for production)
- **Allowed Logout URLs**: Add the same base URLs as above
- **Allowed Web Origins**: Add `http://localhost:8888` and your production domain

Then install frontend deps and start Netlify Dev from the repo root (it will use the `frontend/` base from `netlify.toml`):

```bash
cd /Users/julien.dehee/git/albumguessr
npm --prefix frontend install
npx netlify dev
# opens http://localhost:8888 by default
```

Open:

- Site: `http://localhost:8888/album-of-the-day.html`
- Function: `http://localhost:8888/.netlify/functions/albumOfTheDay`

Quick verification:

```bash
curl -i http://localhost:8888/.netlify/functions/albumOfTheDay
```

Notes:

- To use a different port, run `npx netlify dev --port 8000`.
- If `NETLIFY_DATABASE_URL` is missing, the function responds `500 missing_env:NETLIFY_DATABASE_URL`.
- When using a plain static server, `/.netlify/functions/*` will return `404 File not found` — this is expected; switch to Netlify Dev.
- Do not expose the admin `ALGOLIA_API_KEY` in code shipped to the browser. The generated `frontend/config.js` only includes the search-only key.

## Daily Ranking

The game includes a **Daily Ranking** page (`ranking.html`) that displays a leaderboard of players who have completed today's album:

### Features

- **Real-time leaderboard**: Shows all users who completed today's album, sorted by:
  1. Number of guesses (ascending)
  2. Completion time (ascending) — who found it first
- **Medal system**: Top 3 players receive gold 🥇, silver 🥈, and bronze 🥉 medals
- **User profiles**: Displays usernames and avatars from Auth0 user metadata
- **Responsive design**: Adapts to mobile and desktop with a modern purple gradient style

### How it works

1. When a user completes the daily album, their win is saved to `user_album_history` with a timestamp
2. User profile data (custom username, email, picture) is cached in `user_profiles` table for fast access
3. The `dailyRanking` Netlify function queries today's completions and returns ranking data
4. The ranking page fetches and displays this data with proper formatting

### Database tables

The ranking feature uses two tables:

```sql
-- Cache for Auth0 user profile data
CREATE TABLE user_profiles (
  user_id TEXT PRIMARY KEY,
  custom_username TEXT,
  email TEXT,
  picture TEXT,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- User completion history (existing)
CREATE TABLE user_album_history (
  user_id TEXT NOT NULL,
  object_id TEXT NOT NULL,
  -- ... other fields
  ts TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, object_id)
);
```

User profiles are automatically updated when:
- A user completes an album (saves to history)
- A user updates their profile via the profile page

This caching approach ensures the ranking page loads quickly without making Auth0 API calls for every user.

## Project structure

```
albumguessr/
├── main.py                 # CLI entrypoint (DB → Algolia sync, commands)
├── config.py               # Env/config handling (Algolia + DB)
├── data_processor.py       # Normalization + DB streaming and JSONL helpers
├── algolia.py              # Base Algolia app wrapper
├── algolia_indexer.py      # Batched indexing logic
├── algolia_searcher.py     # Simple search helper used by CLI
├── top_release_groups.py   # Utility to produce mystery album candidates
├── frontend/               # Static game (index.html, config.js, game.js, styles.css)
├── data/                   # Sample data files (JSON/JSONL)
├── requirements.txt        # Python dependencies
└── README.md               # This file
```

## Troubleshooting

- DB connection errors: verify `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD` in `.env` and that your MusicBrainz schema is accessible.
- Algolia errors: check `ALGOLIA_APPLICATION_ID`, `ALGOLIA_API_KEY` (Admin key for backend), and `ALGOLIA_INDEX_NAME`. The frontend must use a search-only key.
- Empty search results: ensure you ran the indexer (`python main.py`) and the chosen index name matches both backend and frontend configs.
- Cover art URLs: they rely on Cover Art Archive tables/joins; if missing, those fields will be absent.

## License

MIT
