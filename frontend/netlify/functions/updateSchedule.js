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
    if (event.httpMethod !== "POST") {
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

    // Parse request body
    const body = JSON.parse(event.body || "{}");
    const { date, objectId } = body;

    // Validate inputs
    if (!date || typeof date !== "string") {
      return { 
        statusCode: 400, 
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ error: "invalid_date" })
      };
    }

    if (!objectId || typeof objectId !== "string") {
      return { 
        statusCode: 400, 
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ error: "invalid_object_id" })
      };
    }

    // Validate date format (YYYY-MM-DD)
    const dateRegex = /^\d{4}-\d{2}-\d{2}$/;
    if (!dateRegex.test(date)) {
      return { 
        statusCode: 400, 
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ error: "invalid_date_format" })
      };
    }

    // Validate date is today or in the future
    // Cast to text to avoid timezone issues and compare strings directly
    const todayRows = await sql`SELECT CURRENT_DATE::text as today`;
    const todayStr = todayRows[0].today;
    
    // Compare dates as strings (YYYY-MM-DD format naturally sorts correctly)
    if (date < todayStr) {
      return { 
        statusCode: 400, 
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ error: "date_must_be_today_or_future" })
      };
    }

    // Insert or update schedule entry
    await sql`
      INSERT INTO mystery_album_schedule (schedule_date, object_id)
      VALUES (${date}, ${objectId})
      ON CONFLICT (schedule_date) 
      DO UPDATE SET object_id = EXCLUDED.object_id
    `;

    return {
      statusCode: 200,
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify({ 
        success: true, 
        date, 
        objectId 
      })
    };
  } catch (err) {
    const code = err?.message || "unknown_error";
    let status = 500;
    
    if (code === "missing_token" || code === "invalid_sub" || code === "unauthorized_not_admin") {
      status = 401;
    }
    
    console.error("updateSchedule error:", err);
    return { 
      statusCode: status, 
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify({ error: code })
    };
  }
}

