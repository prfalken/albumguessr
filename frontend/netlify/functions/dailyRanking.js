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

    // Query to get all-time ranking for daily mode
    // Aggregate total albums found and average guesses per user
    const rankingRows = await sql`
      SELECT 
        h.user_id,
        p.custom_username,
        p.picture,
        COUNT(DISTINCT h.object_id)::INTEGER AS albums_found,
        ROUND(AVG(h.guesses), 1) AS avg_guesses
      FROM user_album_history h
      LEFT JOIN user_profiles p ON h.user_id = p.user_id
      WHERE h.game_mode = 'daily'
      GROUP BY h.user_id, p.custom_username, p.picture
      ORDER BY albums_found DESC, avg_guesses ASC
      LIMIT 100
    `;

    const ranking = rankingRows.map(r => ({
      user_id: r.user_id,
      username: r.custom_username || generateFunAnonymousUsername(r.user_id),
      picture: r.picture || null,
      albums_found: r.albums_found,
      avg_guesses: Number(r.avg_guesses) || 0
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

