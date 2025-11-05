import { createRemoteJWKSet, jwtVerify } from "jose";
import { neon } from "@neondatabase/serverless";
import { generateAnonymousUsername } from "./utils/anonymousNames.js";

const { NETLIFY_DATABASE_URL, AUTH0_DOMAIN, AUTH0_AUDIENCE } = process.env;

// Initialize Neon only if configured
const sql = NETLIFY_DATABASE_URL ? neon(NETLIFY_DATABASE_URL) : null;

function corsHeaders(event) {
  const origin = event?.headers?.origin || "*";
  return {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Allow-Methods": "GET,POST,OPTIONS"
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
    // Validate required env vars early
    if (!NETLIFY_DATABASE_URL) {
      return { statusCode: 500, headers: baseHeaders, body: "missing_env:NETLIFY_DATABASE_URL" };
    }
    if (!AUTH0_DOMAIN) {
      return { statusCode: 500, headers: baseHeaders, body: "missing_env:AUTH0_DOMAIN" };
    }
    if (!AUTH0_AUDIENCE) {
      return { statusCode: 500, headers: baseHeaders, body: "missing_env:AUTH0_AUDIENCE" };
    }

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
          game_mode,
          EXTRACT(EPOCH FROM ts)*1000 AS ts
        FROM user_album_history
        WHERE user_id = ${userId}
        ORDER BY ts DESC
        LIMIT 200
      `;
      const data = rows.map(r => {
        // Normalize game_mode: handle null, undefined, and ensure correct format
        let gameMode = r.game_mode;
        if (!gameMode || gameMode === null || gameMode === undefined) {
          gameMode = 'random';
        } else {
          // Ensure it's a string and trim any whitespace
          gameMode = String(gameMode).trim();
        }
        
        return {
          objectID: r.object_id,
          title: r.title,
          artists: Array.isArray(r.artists) ? r.artists : (r.artists?.array || r.artists) || [],
          release_year: r.release_year,
          coverUrl: r.cover_url,
          guesses: r.guesses,
          gameMode: gameMode,
          timestamp: Number(r.ts)
        };
      });
      return {
        statusCode: 200,
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify(data)
      };
    }

    if (event.httpMethod === "POST") {
      const body = JSON.parse(event.body || "{}");
      const { objectID, title, artists, release_year, coverUrl, guesses, gameMode, points, userProfile } = body;

      if (!objectID || !title || !Array.isArray(artists) || !guesses) {
        return { statusCode: 400, headers: baseHeaders, body: "invalid_body" };
      }

      // Validate game_mode
      const validGameMode = (gameMode === 'daily' || gameMode === 'random' || gameMode === 'cover-guess') ? gameMode : 'random';

      await sql`
        INSERT INTO user_album_history
          (user_id, object_id, title, artists, release_year, cover_url, guesses, game_mode, points)
        VALUES
          (${userId}, ${objectID}, ${title}, ${JSON.stringify(artists)}, ${release_year || null}, ${coverUrl || null}, ${guesses}, ${validGameMode}, ${points || null})
        ON CONFLICT (user_id, object_id, game_mode) DO UPDATE
        SET
          title = EXCLUDED.title,
          artists = EXCLUDED.artists,
          release_year = EXCLUDED.release_year,
          cover_url = EXCLUDED.cover_url,
          guesses = EXCLUDED.guesses,
          points = EXCLUDED.points,
          ts = now()
      `;

      // Update user profile cache if provided
      if (userProfile && typeof userProfile === "object") {
        const { custom_username, email, picture } = userProfile;
        
        // Check existing custom_username in database before generating anonymous name
        let displayUsername = custom_username;
        if (!displayUsername) {
          const existingProfile = await sql`
            SELECT custom_username FROM user_profiles WHERE user_id = ${userId} LIMIT 1
          `;
          displayUsername = (existingProfile && existingProfile.length > 0 && existingProfile[0].custom_username)
            ? existingProfile[0].custom_username
            : generateAnonymousUsername(userId);
        }
        
        await sql`
          INSERT INTO user_profiles
            (user_id, custom_username, email, picture, updated_at)
          VALUES
            (${userId}, ${displayUsername}, ${email || null}, ${picture || null}, now())
          ON CONFLICT (user_id) DO UPDATE
          SET
            custom_username = COALESCE(EXCLUDED.custom_username, user_profiles.custom_username),
            email = EXCLUDED.email,
            picture = EXCLUDED.picture,
            updated_at = now()
        `;
      }

      return { statusCode: 204, headers: baseHeaders };
    }

    return { statusCode: 405, headers: baseHeaders, body: "method_not_allowed" };
  } catch (err) {
    const code = err?.code || err?.message;
    const status = code === "missing_token" || code === "invalid_sub" ? 401 : 500;
    return { statusCode: status, headers: baseHeaders, body: "error" };
  }
}


