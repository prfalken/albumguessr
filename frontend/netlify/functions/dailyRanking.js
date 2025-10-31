import { neon } from "@neondatabase/serverless";
import { generateFunAnonymousUsername } from "./utils/anonymousNames.js";

const { NETLIFY_DATABASE_URL } = process.env;

// Initialize Neon only if configured
const sql = NETLIFY_DATABASE_URL ? neon(NETLIFY_DATABASE_URL) : null;

function corsHeaders(event) {
  const origin = event?.headers?.origin || "*";
  return {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Headers": "Content-Type",
    "Access-Control-Allow-Methods": "GET,OPTIONS"
  };
}

export async function handler(event) {
  const baseHeaders = corsHeaders(event);
  if (event.httpMethod === "OPTIONS") {
    return { statusCode: 204, headers: baseHeaders };
  }

  try {
    if (event.httpMethod !== "GET") {
      return { statusCode: 405, headers: baseHeaders, body: "method_not_allowed" };
    }

    if (!NETLIFY_DATABASE_URL) {
      return { statusCode: 500, headers: baseHeaders, body: "missing_env:NETLIFY_DATABASE_URL" };
    }
    if (!sql) {
      return { statusCode: 500, headers: baseHeaders, body: "db_not_initialized" };
    }

    // First, get today's album from the schedule
    const scheduleRows = await sql`
      SELECT object_id
      FROM mystery_album_schedule
      WHERE schedule_date = CURRENT_DATE
      LIMIT 1
    `;

    if (!scheduleRows || scheduleRows.length === 0) {
      // No album scheduled for today, return empty ranking
      return {
        statusCode: 200,
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ ranking: [] })
      };
    }

    const todayAlbumId = scheduleRows[0].object_id;

    // Query to get ranking for today's album
    // Join with user_profiles to get custom usernames and avatars
    // Only include wins from the daily game mode, not random games
    const rankingRows = await sql`
      SELECT 
        h.user_id,
        p.custom_username,
        p.picture,
        h.guesses,
        EXTRACT(EPOCH FROM h.ts)*1000 AS timestamp,
        EXTRACT(EPOCH FROM (h.ts - (DATE(CURRENT_DATE)))) AS duration_seconds
      FROM user_album_history h
      LEFT JOIN user_profiles p ON h.user_id = p.user_id
      WHERE h.object_id = ${todayAlbumId}
        AND h.game_mode = 'daily'
        AND DATE(h.ts) = CURRENT_DATE
      ORDER BY h.guesses ASC, h.ts ASC
      LIMIT 100
    `;

    const ranking = rankingRows.map(r => ({
      user_id: r.user_id,
      username: r.custom_username || generateFunAnonymousUsername(r.user_id),
      picture: r.picture || null,
      guesses: r.guesses,
      timestamp: Number(r.timestamp),
      duration_seconds: Math.max(0, Number(r.duration_seconds) || 0)
    }));

    return {
      statusCode: 200,
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify({ ranking })
    };
  } catch (err) {
    console.error('dailyRanking error:', err);
    return { statusCode: 500, headers: baseHeaders, body: "error" };
  }
}

