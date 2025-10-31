import { createRemoteJWKSet, jwtVerify } from "jose";

const { 
  AUTH0_DOMAIN, 
  AUTH0_AUDIENCE, 
  AUTH0_M2M_CLIENT_ID,     // M2M application credentials
  AUTH0_M2M_CLIENT_SECRET  // for backend API access
} = process.env;

function corsHeaders(event) {
  const origin = event?.headers?.origin || "*";
  return {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Allow-Methods": "POST,OPTIONS"
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

async function getManagementToken() {
  const issuer = getIssuer();
  if (!issuer || !AUTH0_M2M_CLIENT_ID || !AUTH0_M2M_CLIENT_SECRET) {
    throw new Error("missing_auth0_credentials");
  }

  const tokenEndpoint = `${issuer}oauth/token`;
  const audience = `${issuer}api/v2/`;
  
  console.log("Requesting management token from:", tokenEndpoint);
  console.log("Audience:", audience);
  console.log("M2M Client ID:", AUTH0_M2M_CLIENT_ID);

  const response = await fetch(tokenEndpoint, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      grant_type: "client_credentials",
      client_id: AUTH0_M2M_CLIENT_ID,
      client_secret: AUTH0_M2M_CLIENT_SECRET,
      audience: audience
    })
  });

  if (!response.ok) {
    const errorText = await response.text();
    console.error("Auth0 token request failed:");
    console.error("Status:", response.status, response.statusText);
    console.error("Response:", errorText);
    try {
      const errorJson = JSON.parse(errorText);
      console.error("Error details:", JSON.stringify(errorJson, null, 2));
    } catch (e) {
      // Response wasn't JSON
    }
    throw new Error(`failed_to_get_management_token: ${response.status} ${errorText}`);
  }

  const data = await response.json();
  return data.access_token;
}

async function updateUserName(userId, name) {
  const managementToken = await getManagementToken();
  const issuer = getIssuer();

  // Store custom username in user_metadata to support social login users
  const response = await fetch(`${issuer}api/v2/users/${encodeURIComponent(userId)}`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      "Authorization": `Bearer ${managementToken}`
    },
    body: JSON.stringify({ 
      user_metadata: {
        custom_username: name
      }
    })
  });

  if (!response.ok) {
    const errorText = await response.text();
    console.error("Auth0 update failed:", errorText);
    try {
      const errorJson = JSON.parse(errorText);
      console.error("Error details:", JSON.stringify(errorJson, null, 2));
    } catch (e) {
      // Response wasn't JSON
    }
    throw new Error("failed_to_update_user");
  }

  return await response.json();
}

export async function handler(event) {
  const baseHeaders = corsHeaders(event);
  if (event.httpMethod === "OPTIONS") {
    return { statusCode: 204, headers: baseHeaders };
  }

  if (event.httpMethod !== "POST") {
    return { statusCode: 405, headers: baseHeaders, body: "method_not_allowed" };
  }

  try {
    // Validate required env vars
    console.log("Checking environment variables...");
    console.log("AUTH0_DOMAIN:", AUTH0_DOMAIN ? "✓ Set" : "✗ Missing");
    console.log("AUTH0_AUDIENCE:", AUTH0_AUDIENCE ? "✓ Set" : "✗ Missing");
    console.log("AUTH0_M2M_CLIENT_ID:", AUTH0_M2M_CLIENT_ID ? "✓ Set" : "✗ Missing");
    console.log("AUTH0_M2M_CLIENT_SECRET:", AUTH0_M2M_CLIENT_SECRET ? "✓ Set" : "✗ Missing");

    if (!AUTH0_DOMAIN) {
      console.error("Missing AUTH0_DOMAIN");
      return { 
        statusCode: 500, 
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ error: "missing_env:AUTH0_DOMAIN" })
      };
    }
    if (!AUTH0_AUDIENCE) {
      console.error("Missing AUTH0_AUDIENCE");
      return { 
        statusCode: 500, 
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ error: "missing_env:AUTH0_AUDIENCE" })
      };
    }
    if (!AUTH0_M2M_CLIENT_ID || !AUTH0_M2M_CLIENT_SECRET) {
      console.error("Missing AUTH0_M2M_CLIENT_ID or AUTH0_M2M_CLIENT_SECRET");
      return { 
        statusCode: 500, 
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ error: "missing_env:AUTH0_M2M_CLIENT_CREDENTIALS" })
      };
    }

    console.log("Verifying user authentication...");
    const userId = await verifyAuth(event);
    console.log("User authenticated:", userId);

    const body = JSON.parse(event.body || "{}");
    const { name } = body;

    if (!name || typeof name !== "string" || name.trim().length < 3) {
      console.error("Invalid name provided:", name);
      return { 
        statusCode: 400, 
        headers: { ...baseHeaders, "Content-Type": "application/json" },
        body: JSON.stringify({ error: "invalid_name" })
      };
    }

    // Sanitize name (trim and limit length)
    const sanitizedName = name.trim().substring(0, 30);
    console.log("Updating username to:", sanitizedName);

    await updateUserName(userId, sanitizedName);
    console.log("Username updated successfully");

    return {
      statusCode: 200,
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify({ success: true, name: sanitizedName })
    };
  } catch (err) {
    const code = err?.code || err?.message;
    const status = code === "missing_token" || code === "invalid_sub" ? 401 : 500;
    console.error("Profile update error:", err);
    console.error("Error code:", code);
    console.error("Error stack:", err.stack);
    return { 
      statusCode: status, 
      headers: { ...baseHeaders, "Content-Type": "application/json" },
      body: JSON.stringify({ error: code || "unknown_error", message: err.message })
    };
  }
}

