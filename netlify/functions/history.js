import { createRemoteJWKSet, jwtVerify } from "jose";
import { neon } from "@neondatabase/serverless";

const { NEON_DATABASE_URL, AUTH0_DOMAIN, AUTH0_AUDIENCE } = process.env;
const issuer = `https://${AUTH0_DOMAIN}/`;
const JWKS = createRemoteJWKSet(new URL(`${issuer}.well-known/jwks.json`));

const sql = neon(NEON_DATABASE_URL);

function corsHeaders(event) {
  const origin = event?.headers?.origin || "*";
  return {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Allow-Methods": "GET,POST,OPTIONS"
  };
}

async function verifyAuth(event) {
  const auth = event.headers?.authorization || "";
  const token = auth.startsWith("Bearer ") ? auth.slice(7) : null;
  if (!token) throw new Error("missing_token");
  const { payload } = await jwtVerify(token, JWKS, {
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
    const userId = await verifyAuth(event);

    if (event.httpMethod === "GET") {
      const rows = await sql`
        SELECT
          object_id,
          title,
          artists,
          release_year,
          cover_url,
          guesses,
          EXTRACT(EPOCH FROM ts)*1000 AS ts
        FROM user_album_history
        WHERE user_id = ${userId}
        ORDER BY ts DESC
        LIMIT 200
      `;
      const data = rows.map(r => ({
        objectID: r.object_id,
        title: r.title,
        artists: Array.isArray(r.artists) ? r.artists : (r.artists?.array || r.artists) || [],
        release_year: r.release_year,
        coverUrl: r.cover_url,
        guesses: r.guesses,
        timestamp: Number(r.ts)
      }));
      return {
        statusCode: 200,
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify(data)
      };
    }

    if (event.httpMethod === "POST") {
      const body = JSON.parse(event.body || "{}");
      const { objectID, title, artists, release_year, coverUrl, guesses } = body;

      if (!objectID || !title || !Array.isArray(artists) || !guesses) {
        return { statusCode: 400, headers: baseHeaders, body: "invalid_body" };
      }

      await sql`
        INSERT INTO user_album_history
          (user_id, object_id, title, artists, release_year, cover_url, guesses)
        VALUES
          (${userId}, ${objectID}, ${title}, ${JSON.stringify(artists)}, ${release_year || null}, ${coverUrl || null}, ${guesses})
        ON CONFLICT (user_id, object_id) DO UPDATE
        SET
          title = EXCLUDED.title,
          artists = EXCLUDED.artists,
          release_year = EXCLUDED.release_year,
          cover_url = EXCLUDED.cover_url,
          guesses = EXCLUDED.guesses,
          ts = now()
      `;

      return { statusCode: 204, headers: baseHeaders };
    }

    return { statusCode: 405, headers: baseHeaders, body: "method_not_allowed" };
  } catch (err) {
    const code = err?.code || err?.message;
    const status = code === "missing_token" || code === "invalid_sub" ? 401 : 500;
    return { statusCode: status, headers: baseHeaders, body: "error" };
  }
}


