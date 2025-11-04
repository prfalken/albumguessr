import { neon } from "@neondatabase/serverless";

const { NETLIFY_DATABASE_URL } = process.env;

// Initialize Neon only if configured
const sql = NETLIFY_DATABASE_URL ? neon(NETLIFY_DATABASE_URL) : null;

function corsHeaders(event) {
  const origin = event?.headers?.origin || event?.headers?.Origin || "*";
  return {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
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

    // First, check if there are any cover-guess games at all
    const countCheck = await sql`
      SELECT COUNT(*) as count
      FROM user_album_history
      WHERE game_mode = 'cover-guess'
    `;
    
    console.log(`Cover Guess games found: ${countCheck[0]?.count || 0}`);
    
    // Query to get overall ranking for cover-guess mode
    // Sum points per user and order by total points descending
    // Handle case where points column might not exist yet (returns empty ranking)
    let rankingRows;
    try {
      rankingRows = await sql`
        SELECT 
          h.user_id,
          p.custom_username,
          p.picture,
          SUM(COALESCE(h.points, 0))::INTEGER AS total_points,
          COUNT(*)::INTEGER AS games_won,
          MAX(h.ts) AS last_win
        FROM user_album_history h
        LEFT JOIN user_profiles p ON h.user_id = p.user_id
        WHERE h.game_mode = 'cover-guess'
        GROUP BY h.user_id, p.custom_username, p.picture
        HAVING SUM(COALESCE(h.points, 0)) >= 0
        ORDER BY total_points DESC, last_win ASC
        LIMIT 100
      `;
    } catch (sqlError) {
      // If column doesn't exist, return empty ranking with a helpful error
      if (sqlError.message && sqlError.message.includes('column') && sqlError.message.includes('points')) {
        console.error('Column "points" does not exist. Run migration: sql/migration_cover_guess.sql');
        return {
          statusCode: 500,
          headers: { ...baseHeaders, "Content-Type": "application/json" },
          body: JSON.stringify({ 
            error: 'database_migration_required',
            message: 'La colonne "points" n\'existe pas. Veuillez exécuter la migration SQL: sql/migration_cover_guess.sql'
          })
        };
      }
      throw sqlError;
    }

    const ranking = rankingRows.map((r, index) => ({
      rank: index + 1,
      user_id: r.user_id,
      username: r.custom_username || 'Anonymous',
      avatar: r.picture || null,
      total_points: r.total_points || 0,
      games_won: r.games_won || 0
    }));

    console.log(`Cover Guess Ranking: Found ${ranking.length} players`);

    return {
      statusCode: 200,
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify({ ranking })
    };
  } catch (err) {
    console.error('Error in coverGuessRanking:', err);
    return {
      statusCode: 500,
      headers: baseHeaders,
      body: JSON.stringify({ error: err.message || "internal_server_error" })
    };
  }
}
