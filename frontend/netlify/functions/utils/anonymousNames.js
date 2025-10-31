/**
 * Generates a consistent, friendly anonymous username from a user_id.
 * Uses a hash-based approach to ensure the same user_id always gets the same name.
 * 
 * @param {string} userId - The Auth0 user ID (e.g., "google-oauth2|110253643736011489857")
 * @returns {string} A friendly anonymous name (e.g., "Player 3857")
 */
export function generateAnonymousUsername(userId) {
  if (!userId || typeof userId !== 'string') {
    return 'Anonymous';
  }

  // Extract numeric hash from user_id
  // For Auth0 IDs like "google-oauth2|110253643736011489857", take the part after |
  // For other formats, use the whole string
  let hashSource = userId;
  if (userId.includes('|')) {
    const parts = userId.split('|');
    hashSource = parts[parts.length - 1]; // Get last part after |
  }

  // Simple hash function to get a number from the string
  let hash = 0;
  for (let i = 0; i < hashSource.length; i++) {
    const char = hashSource.charCodeAt(i);
    hash = ((hash << 5) - hash) + char;
    hash = hash & hash; // Convert to 32-bit integer
  }

  // Make it positive and get last 4 digits
  const positiveHash = Math.abs(hash);
  const suffix = String(positiveHash).slice(-4).padStart(4, '0');

  return `Player ${suffix}`;
}

/**
 * Adjectives and nouns for generating fun random usernames.
 * Can be used as an alternative to Player #### format.
 */
const ADJECTIVES = [
  'Swift', 'Clever', 'Brave', 'Wise', 'Bold', 'Calm', 'Daring', 'Eager',
  'Fierce', 'Gentle', 'Happy', 'Jolly', 'Kind', 'Lively', 'Mighty', 'Noble',
  'Proud', 'Quick', 'Royal', 'Sharp', 'Silent', 'Steady', 'Vibrant', 'Wild'
];

const NOUNS = [
  'Fox', 'Eagle', 'Wolf', 'Bear', 'Tiger', 'Lion', 'Hawk', 'Owl',
  'Panther', 'Falcon', 'Dragon', 'Phoenix', 'Raven', 'Lynx', 'Puma', 'Otter',
  'Badger', 'Cobra', 'Jaguar', 'Leopard', 'Cheetah', 'Crane', 'Heron', 'Sparrow'
];

/**
 * Generates a fun anonymous username like "Swift Fox" or "Bold Tiger".
 * Uses the same hash-based approach to ensure consistency.
 * 
 * @param {string} userId - The Auth0 user ID
 * @returns {string} A fun anonymous name (e.g., "Swift Fox")
 */
export function generateFunAnonymousUsername(userId) {
  if (!userId || typeof userId !== 'string') {
    return 'Anonymous Player';
  }

  // Extract hash source
  let hashSource = userId;
  if (userId.includes('|')) {
    const parts = userId.split('|');
    hashSource = parts[parts.length - 1];
  }

  // Simple hash function
  let hash = 0;
  for (let i = 0; i < hashSource.length; i++) {
    const char = hashSource.charCodeAt(i);
    hash = ((hash << 5) - hash) + char;
    hash = hash & hash;
  }

  const positiveHash = Math.abs(hash);
  const adjIndex = positiveHash % ADJECTIVES.length;
  const nounIndex = Math.floor(positiveHash / ADJECTIVES.length) % NOUNS.length;

  return `${ADJECTIVES[adjIndex]} ${NOUNS[nounIndex]}`;
}

