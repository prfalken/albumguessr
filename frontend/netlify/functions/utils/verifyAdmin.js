import { createRemoteJWKSet, jwtVerify } from "jose";
import { neon } from "@neondatabase/serverless";

const { 
  AUTH0_DOMAIN, 
  AUTH0_AUDIENCE, 
  NETLIFY_DATABASE_URL
} = process.env;

// Initialize Neon only if configured
const sql = NETLIFY_DATABASE_URL ? neon(NETLIFY_DATABASE_URL) : null;

function getIssuer() {
  if (!AUTH0_DOMAIN) return null;
  return `https://${AUTH0_DOMAIN}/`;
}

function getJWKS(issuer) {
  return createRemoteJWKSet(new URL(`${issuer}.well-known/jwks.json`));
}

/**
 * Verify JWT token and extract user ID
 * @param {object} event - Netlify function event
 * @returns {Promise<string>} User ID (sub claim)
 * @throws {Error} If token is missing or invalid
 */
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

/**
 * Verify that user is authenticated and has admin privileges
 * @param {object} event - Netlify function event
 * @returns {Promise<string>} User ID if admin
 * @throws {Error} If user is not authenticated, not admin, or database error
 */
export async function verifyAdmin(event) {
  // Verify JWT and get user ID
  const userId = await verifyAuth(event);
  
  if (!sql) {
    throw new Error("database_not_configured");
  }
  
  // Check admin status in database
  const rows = await sql`
    SELECT admin
    FROM user_profiles
    WHERE user_id = ${userId}
    LIMIT 1
  `;
  
  const profile = rows && rows.length > 0 ? rows[0] : null;
  const isAdmin = profile?.admin === 1;
  
  if (!isAdmin) {
    throw new Error("unauthorized_not_admin");
  }
  
  return userId;
}

/**
 * CORS headers for Netlify function responses
 * @param {object} event - Netlify function event
 * @returns {object} CORS headers
 */
export function corsHeaders(event) {
  const origin = event?.headers?.origin || "*";
  return {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Allow-Methods": "GET,POST,OPTIONS"
  };
}

