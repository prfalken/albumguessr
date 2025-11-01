import { neon } from "@neondatabase/serverless";
import { verifyAdmin, corsHeaders } from "./utils/verifyAdmin.js";

const { NETLIFY_DATABASE_URL } = process.env;

// Initialize Neon only if configured
const sql = NETLIFY_DATABASE_URL ? neon(NETLIFY_DATABASE_URL) : null;

export async function handler(event) {
  const baseHeaders = corsHeaders(event);
  if (event.httpMethod === "OPTIONS") {
    return { statusCode: 204, headers: baseHeaders };
  }

  try {
    if (event.httpMethod !== "GET") {
      return { statusCode: 405, headers: baseHeaders, body: "method_not_allowed" };
    }

    if (!sql) {
      return { 
        statusCode: 500, 
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ error: "database_not_configured" })
      };
    }

    // Verify admin access
    await verifyAdmin(event);

    // Fetch all schedule entries ordered by date
    // Cast date to text to ensure YYYY-MM-DD format without timezone conversion
    const rows = await sql`
      SELECT 
        schedule_date::text as schedule_date, 
        object_id
      FROM mystery_album_schedule
      ORDER BY schedule_date ASC
    `;

    return {
      statusCode: 200,
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify(rows || [])
    };
  } catch (err) {
    const code = err?.message || "unknown_error";
    let status = 500;
    
    if (code === "missing_token" || code === "invalid_sub" || code === "unauthorized_not_admin") {
      status = 401;
    }
    
    console.error("getSchedule error:", err);
    return { 
      statusCode: status, 
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify({ error: code })
    };
  }
}

