import { createRemoteJWKSet, jwtVerify } from "jose";
import { neon } from "@neondatabase/serverless";

const { NETLIFY_DATABASE_URL, AUTH0_DOMAIN, AUTH0_AUDIENCE } = process.env;

// Initialize Neon only if configured
const sql = NETLIFY_DATABASE_URL ? neon(NETLIFY_DATABASE_URL) : null;

function corsHeaders(event) {
  const origin = event?.headers?.origin || "*";
  return {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Allow-Methods": "GET,OPTIONS"
  };
}

function getIssuer() {
  if (!AUTH0_DOMAIN) return null;
  return `https://${AUTH0_DOMAIN}/`;
}

function getJWKS(issuer) {
  return createRemoteJWKSet(new URL(`${issuer}.well-known/jwks.json`));
}

async function verifyAuth(event) {
  const auth = event.headers?.authorization || "";
  const token = auth.startsWith("Bearer ") ? auth.slice(7) : null;
  if (!token) throw new Error("missing_token");
  const issuer = getIssuer();
  if (!issuer) throw new Error("missing_auth0_domain");
  if (!AUTH0_AUDIENCE) throw new Error("missing_auth0_audience");
  const jwks = getJWKS(issuer);
  const { payload } = await jwtVerify(token, jwks, {
    issuer,
    audience: AUTH0_AUDIENCE
  });
  const sub = payload?.sub;
  if (!sub) throw new Error("invalid_sub");
  return sub;
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
      return { 
        statusCode: 500, 
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ error: "database_not_configured" })
      };
    }
    if (!sql) {
      return { 
        statusCode: 500, 
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ error: "db_not_initialized" })
      };
    }

    // Get user ID if authenticated (optional - allow unauthenticated users to see albums but without completion status)
    let userId = null;
    try {
      userId = await verifyAuth(event);
    } catch (err) {
      // User not authenticated - they can still see past albums but won't know which ones they completed
      console.log("User not authenticated, returning albums without completion status");
    }

    // Fetch all past albums and today's album from schedule (up to and including today)
    // Join with user_album_history to check if user completed each album
    // Also join with user_profiles to get album details for completed albums
    const query = userId
      ? sql`
        SELECT 
          s.schedule_date::text as date,
          s.object_id,
          CASE WHEN h.user_id IS NOT NULL THEN true ELSE false END as completed,
          h.title as album_title,
          h.artists as album_artists,
          h.cover_url as cover_url
        FROM mystery_album_schedule s
        LEFT JOIN user_album_history h ON 
          s.object_id = h.object_id 
          AND h.user_id = ${userId}
          AND h.game_mode = 'daily'
        WHERE s.schedule_date <= CURRENT_DATE
        ORDER BY s.schedule_date DESC
      `
      : sql`
        SELECT 
          s.schedule_date::text as date,
          s.object_id,
          false as completed,
          NULL as album_title,
          NULL as album_artists,
          NULL as cover_url
        FROM mystery_album_schedule s
        WHERE s.schedule_date <= CURRENT_DATE
        ORDER BY s.schedule_date DESC
      `;

    const rows = await query;

    const albums = rows.map(r => ({
      date: r.date,
      object_id: r.object_id,
      completed: r.completed || false,
      album_title: r.album_title || null,
      album_artists: Array.isArray(r.album_artists) 
        ? r.album_artists 
        : (r.album_artists?.array || r.album_artists) || null,
      cover_url: r.cover_url || null
    }));

    return {
      statusCode: 200,
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify({ albums })
    };
  } catch (err) {
    const code = err?.message || "unknown_error";
    let status = 500;
    
    if (code === "missing_token" || code === "invalid_sub") {
      status = 401;
    }
    
    console.error("getPastDailies error:", err);
    return { 
      statusCode: status, 
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify({ error: code })
    };
  }
}

