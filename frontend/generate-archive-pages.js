// Generates one static, crawlable HTML page per revealed past daily album
// (schedule_date more than 90 days ago - see migration_mystery_album_schedule_blurb.sql).
// Runs at Netlify build time, alongside build-config.js. Output is gitignored
// and regenerated on every build, same as config.js.
//
// Why this exists: the archive calendar (past-dailies.html) renders entirely
// client-side from an authenticated API call, so a crawler that doesn't run
// JS (or doesn't wait out the Algolia/Netlify-function round trips) sees an
// empty page. These pages bake the same data into plain HTML so the archive
// has real, growing, indexable content instead of a JS-only widget.

require('dotenv').config();

const fs = require('fs');
const path = require('path');
const { neon } = require('@neondatabase/serverless');

const SITE_URL = 'https://albumguessr.com';
const OUTPUT_DIR = path.join(__dirname, 'archive');
const SITEMAP_PATH = path.join(__dirname, 'sitemap-archive.xml');

function getEnv(name) {
  const value = process.env[name];
  return value === undefined || value === '' ? null : value;
}

function escapeHtml(str) {
  return String(str || '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

function contributorNames(contributors) {
  if (!Array.isArray(contributors)) return [];
  return contributors
    .map((c) => (typeof c === 'string' ? c : c && c.name))
    .filter(Boolean);
}

let countryDisplayNames = null;
function getCountryName(code) {
  if (!code) return '';
  if (!countryDisplayNames) {
    try {
      countryDisplayNames = new Intl.DisplayNames(['en'], { type: 'region' });
    } catch (_) {
      return String(code).toUpperCase();
    }
  }
  try {
    return countryDisplayNames.of(String(code).toUpperCase());
  } catch (_) {
    return String(code).toUpperCase();
  }
}

function formatDuration(totalSeconds) {
  const seconds = Number(totalSeconds);
  if (!seconds || seconds <= 0) return null;
  const minutes = Math.round(seconds / 60);
  if (minutes < 60) return `${minutes} min`;
  const hours = Math.floor(minutes / 60);
  const rest = minutes % 60;
  return `${hours}h ${String(rest).padStart(2, '0')}min`;
}

function formatDisplayDate(dateStr) {
  const [year, month, day] = dateStr.split('-').map(Number);
  const date = new Date(year, month - 1, day);
  return date.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' });
}

async function fetchAlgoliaObject({ appId, apiKey, indexName }, objectID) {
  const attrs = [
    'objectID', 'title', 'artists', 'genres', 'release_year', 'countries',
    'contributors', 'cover_art_url', 'label', 'total_length_seconds',
    'is_solo_artist', 'is_group'
  ].join(',');
  const url = `https://${appId}-dsn.algolia.net/1/indexes/${encodeURIComponent(indexName)}/${encodeURIComponent(objectID)}?attributesToRetrieve=${attrs}`;
  const res = await fetch(url, {
    headers: {
      'X-Algolia-Application-Id': appId,
      'X-Algolia-API-Key': apiKey
    }
  });
  if (!res.ok) {
    throw new Error(`Algolia getObject ${objectID} failed: ${res.status}`);
  }
  return res.json();
}

async function mapWithConcurrency(items, limit, fn) {
  const results = new Array(items.length);
  let next = 0;
  async function worker() {
    while (next < items.length) {
      const i = next++;
      results[i] = await fn(items[i], i);
    }
  }
  await Promise.all(Array.from({ length: Math.min(limit, items.length) }, worker));
  return results;
}

function buildPageHtml({ date, displayDate, album, blurb }) {
  const title = album.title || 'Unknown album';
  const artists = Array.isArray(album.artists) ? album.artists : [];
  const artistLine = artists.length ? artists.join(', ') : 'Unknown artist';
  const genres = Array.isArray(album.genres) ? album.genres : [];
  const countries = Array.isArray(album.countries) ? album.countries : [];
  const countryNames = countries.map(getCountryName).filter(Boolean);
  const names = contributorNames(album.contributors);
  const duration = formatDuration(album.total_length_seconds);
  const isSolo = album.is_group === true
    ? false
    : album.is_solo_artist === true
      ? true
      : artists.length === 1;

  const pageTitle = `${title} by ${artistLine} — AlbumGuessr Archive (${displayDate})`;
  const metaDescriptionParts = [
    `AlbumGuessr's mystery album for ${displayDate} was "${title}" by ${artistLine}.`
  ];
  if (blurb) metaDescriptionParts.push(blurb);
  const metaDescription = metaDescriptionParts.join(' ').slice(0, 300);

  const canonical = `${SITE_URL}/archive/${date}.html`;
  const coverUrl = album.cover_art_url || `${SITE_URL}/img/logo.png`;

  const factRows = [];
  factRows.push(['Artist', artistLine]);
  factRows.push(['Artist type', isSolo ? 'Solo artist' : 'Group']);
  if (genres.length) factRows.push(['Genre', genres.join(', ')]);
  if (album.release_year) factRows.push(['Release year', String(album.release_year)]);
  if (countryNames.length) factRows.push(['Country', countryNames.join(', ')]);
  if (duration) factRows.push(['Length', duration]);
  if (album.label) factRows.push(['Label', album.label]);
  if (names.length) factRows.push(['Contributors', names.join(', ')]);

  const factsHtml = factRows
    .map(([label, value]) => `<li><strong>${escapeHtml(label)}:</strong> ${escapeHtml(value)}</li>`)
    .join('\n                        ');

  const blurbSection = blurb
    ? `
                    <section class="how-to-play-section">
                        <h2>Why this one</h2>
                        <p>${escapeHtml(blurb)}</p>
                    </section>`
    : '';

  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'MusicAlbum',
    name: title,
    byArtist: artists.map((name) => ({ '@type': 'MusicGroup', name })),
    ...(genres.length ? { genre: genres } : {}),
    ...(album.release_year ? { datePublished: String(album.release_year) } : {}),
    image: coverUrl,
    url: canonical
  };

  return `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <base href="/">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>${escapeHtml(pageTitle)}</title>
    <meta name="title" content="${escapeHtml(pageTitle)}">
    <meta name="description" content="${escapeHtml(metaDescription)}">
    <meta name="robots" content="index, follow">
    <meta name="theme-color" content="#6a4c93">

    <link rel="canonical" href="${canonical}">

    <link rel="icon" type="image/png" href="/favicon.png">
    <link rel="icon" type="image/x-icon" href="/favicon.ico">
    <link rel="apple-touch-icon" href="/favicon.png">

    <meta property="og:type" content="article">
    <meta property="og:url" content="${canonical}">
    <meta property="og:title" content="${escapeHtml(pageTitle)}">
    <meta property="og:description" content="${escapeHtml(metaDescription)}">
    <meta property="og:image" content="${escapeHtml(coverUrl)}">
    <meta property="og:site_name" content="AlbumGuessr">
    <meta property="og:locale" content="en_US">

    <script type="application/ld+json">
    ${JSON.stringify(jsonLd)}
    </script>

    <link rel="stylesheet" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
    <div class="container">
        <div id="site-header"></div>

        <main id="main-content" class="game-container">
            <div class="content-grid">
                <div class="main-column legal-content">
                    <h1>${escapeHtml(title)} by ${escapeHtml(artistLine)}</h1>
                    <p>AlbumGuessr mystery album for ${escapeHtml(displayDate)}</p>

                    <section class="how-to-play-section">
                        <img class="mystery-album-cover" src="${escapeHtml(coverUrl)}" alt="${escapeHtml(title)} cover art" loading="lazy">
                        <ul>
                        ${factsHtml}
                        </ul>
                    </section>
${blurbSection}
                    <section class="how-to-play-section">
                        <p>This was AlbumGuessr's daily mystery album for ${escapeHtml(displayDate)}. <a href="index.html?date=${date}">Play this puzzle</a> or <a href="past-dailies.html">browse the full archive</a>.</p>
                    </section>
                </div>
            </div>
        </main>

        <div id="site-footer"></div>
    </div>

    <script src="config.js"></script>
    <script src="analytics.js"></script>
    <script src="ads.js"></script>
    <script src="includes.js"></script>
    <script src="nav.js"></script>
</body>
</html>
`;
}

function buildSitemap(entries) {
  const urls = entries
    .map(({ date, lastmod }) => `    <url>
        <loc>${SITE_URL}/archive/${date}.html</loc>
        <lastmod>${lastmod}</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.4</priority>
    </url>`)
    .join('\n');
  return `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls}
</urlset>
`;
}

async function main() {
  const dbUrl = getEnv('NETLIFY_DATABASE_URL');
  if (!dbUrl) {
    console.log('generate-archive-pages: NETLIFY_DATABASE_URL not set, skipping archive page generation.');
    return;
  }

  const appId = getEnv('ALGOLIA_APPLICATION_ID');
  const apiKey = getEnv('ALGOLIA_SEARCH_API_KEY');
  const indexName = getEnv('ALGOLIA_INDEX_NAME');
  if (!appId || !apiKey || !indexName) {
    console.log('generate-archive-pages: Algolia env vars not set, skipping archive page generation.');
    return;
  }

  const sql = neon(dbUrl);
  const rows = await sql`
    SELECT schedule_date::text as date, object_id, blurb
    FROM mystery_album_schedule
    WHERE schedule_date <= CURRENT_DATE - INTERVAL '90 days'
    ORDER BY schedule_date DESC
  `;

  console.log(`generate-archive-pages: ${rows.length} revealed day(s) found.`);

  fs.mkdirSync(OUTPUT_DIR, { recursive: true });

  const results = await mapWithConcurrency(rows, 20, async (row) => {
    try {
      const album = await fetchAlgoliaObject({ appId, apiKey, indexName }, row.object_id);
      const html = buildPageHtml({
        date: row.date,
        displayDate: formatDisplayDate(row.date),
        album,
        blurb: row.blurb ? row.blurb.trim() : null
      });
      fs.writeFileSync(path.join(OUTPUT_DIR, `${row.date}.html`), html, 'utf8');
      return { date: row.date, lastmod: row.date, ok: true };
    } catch (err) {
      console.warn(`generate-archive-pages: skipping ${row.date} (${row.object_id}): ${err.message}`);
      return { ok: false };
    }
  });

  const written = results.filter((r) => r.ok);
  fs.writeFileSync(SITEMAP_PATH, buildSitemap(written), 'utf8');

  console.log(`generate-archive-pages: wrote ${written.length} page(s) and sitemap-archive.xml.`);
}

if (require.main === module) {
  main().catch((err) => {
    console.error('generate-archive-pages: unexpected error, continuing build without archive pages.');
    console.error(err);
  });
} else {
  module.exports = { buildPageHtml, formatDisplayDate, formatDuration, getCountryName, contributorNames };
}
