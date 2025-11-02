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

    // Check if date parameter is provided in query string
    const requestedDate = event.queryStringParameters?.date;
    
    let targetDate;
    if (requestedDate) {
      // Validate date format (YYYY-MM-DD)
      const dateRegex = /^\d{4}-\d{2}-\d{2}$/;
      if (!dateRegex.test(requestedDate)) {
        return { 
          statusCode: 400, 
          headers: { ...baseHeaders, "Content-Type": "application/json" },
          body: JSON.stringify({ error: "invalid_date_format" })
        };
      }
      
      // Check if date is in the future
      const todayRows = await sql`SELECT CURRENT_DATE::text as today`;
      const todayStr = todayRows[0].today;
      if (requestedDate > todayStr) {
        return { 
          statusCode: 400, 
          headers: { ...baseHeaders, "Content-Type": "application/json" },
          body: JSON.stringify({ error: "date_must_be_today_or_past" })
        };
      }
      
      targetDate = requestedDate;
    } else {
      // Use current_date from DB to align with server timezone (UTC on Neon)
      targetDate = null; // Will use CURRENT_DATE in SQL
    }

    // Use current_date from DB to align with server timezone (UTC on Neon)
    // Cast date to text to ensure YYYY-MM-DD format without timezone conversion
    const rows = targetDate
      ? await sql`
          SELECT 
            schedule_date::text as schedule_date, 
            object_id
          FROM mystery_album_schedule
          WHERE schedule_date = ${targetDate}::date
          LIMIT 1
        `
      : await sql`
          SELECT 
            schedule_date::text as schedule_date, 
            object_id
          FROM mystery_album_schedule
          WHERE schedule_date = CURRENT_DATE
          LIMIT 1
        `;

    if (!rows || rows.length === 0) {
      return { statusCode: 404, headers: baseHeaders, body: "not_found" };
    }

    const row = rows[0];
    const payload = {
      objectID: row.object_id,
      date: row.schedule_date
    };

    return {
      statusCode: 200,
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify(payload)
    };
  } catch (err) {
    return { statusCode: 500, headers: baseHeaders, body: "error" };
  }
}


