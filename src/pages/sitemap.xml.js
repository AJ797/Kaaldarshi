const ROUTES = ['/', '/udant', '/k-research'];

export function GET({ site }) {
  const urls = ROUTES.map((route) => {
    const loc = new URL(route.replace(/^\//, ''), site).href;
    return `  <url><loc>${loc}</loc></url>`;
  }).join('\n');

  const body = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls}
</urlset>
`;

  return new Response(body, {
    headers: { 'Content-Type': 'application/xml; charset=utf-8' },
  });
}
