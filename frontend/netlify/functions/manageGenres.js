import { neon } from "@neondatabase/serverless";
import { verifyAdmin } from "./utils/verifyAdmin.js";

const { NETLIFY_DATABASE_URL } = process.env;

// Initialize Neon only if configured
const sql = NETLIFY_DATABASE_URL ? neon(NETLIFY_DATABASE_URL) : null;

function corsHeaders(event) {
  const origin = event?.headers?.origin || "*";
  return {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Allow-Methods": "GET,POST,PUT,DELETE,OPTIONS"
  };
}

export async function handler(event) {
  const baseHeaders = corsHeaders(event);
  if (event.httpMethod === "OPTIONS") {
    return { statusCode: 204, headers: baseHeaders };
  }

  try {
    // Verify admin for all operations
    const adminCheck = await verifyAdmin(event);
    if (adminCheck.statusCode !== 200) {
      return adminCheck;
    }

    if (!NETLIFY_DATABASE_URL) {
      return { statusCode: 500, headers: baseHeaders, body: JSON.stringify({ error: "missing_env" }) };
    }
    if (!sql) {
      return { statusCode: 500, headers: baseHeaders, body: JSON.stringify({ error: "db_not_initialized" }) };
    }

    // GET: Fetch all genres
    if (event.httpMethod === "GET") {
      const rows = await sql`
        SELECT id, name, display_name, display_order, enabled
        FROM available_genres
        ORDER BY display_order ASC, name ASC
      `;

      const genres = rows.map(row => ({
        id: row.id,
        name: row.name,
        displayName: row.display_name,
        displayOrder: row.display_order,
        enabled: row.enabled
      }));

      return {
        statusCode: 200,
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ genres })
      };
    }

    // POST: Create new genre
    if (event.httpMethod === "POST") {
      const body = JSON.parse(event.body);
      const { name, displayName, displayOrder, enabled } = body;

      if (!name || !displayName) {
        return {
          statusCode: 400,
          headers: { ...baseHeaders, "Content-Type": "application/json" },
          body: JSON.stringify({ error: "Missing required fields: name, displayName" })
        };
      }

      const rows = await sql`
        INSERT INTO available_genres (name, display_name, display_order, enabled)
        VALUES (${name.toLowerCase()}, ${displayName}, ${displayOrder || 0}, ${enabled !== false})
        RETURNING id, name, display_name, display_order, enabled
      `;

      const genre = rows[0];
      return {
        statusCode: 201,
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({
          genre: {
            id: genre.id,
            name: genre.name,
            displayName: genre.display_name,
            displayOrder: genre.display_order,
            enabled: genre.enabled
          }
        })
      };
    }

    // PUT: Update existing genre
    if (event.httpMethod === "PUT") {
      const body = JSON.parse(event.body);
      const { id, name, displayName, displayOrder, enabled } = body;

      if (!id || !name || !displayName) {
        return {
          statusCode: 400,
          headers: { ...baseHeaders, "Content-Type": "application/json" },
          body: JSON.stringify({ error: "Missing required fields: id, name, displayName" })
        };
      }

      const rows = await sql`
        UPDATE available_genres
        SET name = ${name.toLowerCase()},
            display_name = ${displayName},
            display_order = ${displayOrder || 0},
            enabled = ${enabled !== false}
        WHERE id = ${id}
        RETURNING id, name, display_name, display_order, enabled
      `;

      if (rows.length === 0) {
        return {
          statusCode: 404,
          headers: { ...baseHeaders, "Content-Type": "application/json" },
          body: JSON.stringify({ error: "Genre not found" })
        };
      }

      const genre = rows[0];
      return {
        statusCode: 200,
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({
          genre: {
            id: genre.id,
            name: genre.name,
            displayName: genre.display_name,
            displayOrder: genre.display_order,
            enabled: genre.enabled
          }
        })
      };
    }

    // DELETE: Delete genre
    if (event.httpMethod === "DELETE") {
      const body = JSON.parse(event.body);
      const { id } = body;

      if (!id) {
        return {
          statusCode: 400,
          headers: { ...baseHeaders, "Content-Type": "application/json" },
          body: JSON.stringify({ error: "Missing required field: id" })
        };
      }

      await sql`DELETE FROM available_genres WHERE id = ${id}`;

      return {
        statusCode: 200,
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ success: true })
      };
    }

    return { statusCode: 405, headers: baseHeaders, body: "method_not_allowed" };
  } catch (err) {
    console.error("Error in manageGenres:", err);
    return {
      statusCode: 500,
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify({ error: err.message || "error" })
    };
  }
}

