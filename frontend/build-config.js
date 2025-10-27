// Generates frontend/config.js from environment variables at build time.
// Uses search-only Algolia key for the browser. Fails fast if required vars are missing.

const fs = require('fs');
const path = require('path');

function getEnv(name, { required = true, fallback = undefined } = {}) {
  const value = process.env[name] ?? fallback;
  if (required && (value === undefined || value === '')) {
    throw new Error(`Missing required env var: ${name}`);
  }
  return value;
}

function main() {
  // Use public-labeled vars so secrets scanning doesn't track their values
  const applicationId = getEnv('ALGOLIA_APPLICATION_ID');
  const apiKey = getEnv('ALGOLIA_SEARCH_API_KEY');
  const indexName = getEnv('ALGOLIA_INDEX_NAME', { required: true });
  const auth0Domain = getEnv('AUTH0_DOMAIN', { required: false });
  const auth0ClientId = getEnv('AUTH0_CLIENT_ID', { required: false });
  const auth0Audience = getEnv('AUTH0_AUDIENCE', { required: false });

  const output = `// Configuration for Algolia Search (generated at build time)\n` +
    `const ALGOLIA_CONFIG = {\n` +
    `    applicationId: '${applicationId}',\n` +
    `    apiKey: '${apiKey}',\n` +
    `    indexName: '${indexName}'\n` +
    `};\n\n` +
    `// Optional Auth0 configuration (generated at build time)\n` +
    `const AUTH0_CONFIG = ${auth0Domain && auth0ClientId ? `{\n` +
    `    domain: '${auth0Domain}',\n` +
    `    clientId: '${auth0ClientId}',\n` +
    `    authorizationParams: { redirect_uri: (typeof window !== 'undefined' ? window.location.origin : '')${auth0Audience ? `, audience: '${auth0Audience}'` : ''} },\n` +
    `    cacheLocation: 'localstorage',\n` +
    `    useRefreshTokens: true,\n` +
    `    useRefreshTokensFallback: true\n` +
    `}` : `null`};\n\n` +
    `const GAME_CONFIG = {\n` +
    `    clueCategories: [\n` +
    `        { key: 'artists', label: 'Artists', icon: 'bi-person-fill', description: 'Shared artists' },\n` +
    `        { key: 'genres', label: 'Genres', icon: 'bi-music-note-list', description: 'Shared musical genres' },\n` +
    `        { key: 'release_year', label: 'Year', icon: 'bi-calendar-fill', description: 'Release year' },\n` +
    `        { key: 'countries', label: 'Countries', icon: 'bi-globe', description: 'Countries of origin' },\n` +
    `        { key: 'musicians', label: 'Musicians', icon: 'bi-people-fill', description: 'Shared musicians/contributors' }\n` +
    `    ]\n` +
    `};\n\n` +
    `if (typeof module !== 'undefined' && module.exports) {\n` +
    `    module.exports = { ALGOLIA_CONFIG, AUTH0_CONFIG, GAME_CONFIG };\n` +
    `}\n`;

  const destination = path.join(__dirname, 'config.js');
  fs.writeFileSync(destination, output, 'utf8');
  console.log(`Generated ${destination}`);
}

try {
  main();
} catch (err) {
  console.error(err.message);
  process.exit(1);
}


