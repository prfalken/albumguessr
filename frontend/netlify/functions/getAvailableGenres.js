import { neon } from "@neondatabase/serverless";

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

    // Fetch enabled genres ordered by display_order
    const rows = await sql`
      SELECT id, name, display_name, display_order
      FROM available_genres
      WHERE enabled = true
      ORDER BY display_order ASC, name ASC
    `;

    const genres = rows.map(row => ({
      id: row.id,
      name: row.name,
      displayName: row.display_name,
      displayOrder: row.display_order
    }));

    return {
      statusCode: 200,
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify({ genres })
    };
  } catch (err) {
    console.error("Error fetching genres:", err);
    return { statusCode: 500, headers: baseHeaders, body: "error" };
  }
}

