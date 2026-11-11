import { defineConfig } from 'astro/config';

// Netlify injects URL (the site's primary URL) at build time, so no domain is
// hardcoded here. Locally it falls back to the dev server origin.
const site = process.env.SITE_URL || process.env.URL || 'http://localhost:4321';

export default defineConfig({
  site,
  output: 'static',
  trailingSlash: 'never',
  compressHTML: true,
  devToolbar: { enabled: false },
  build: {
    // Every stylesheet must be an external file. An inlined <style> would need
    // a sha256 in the CSP, and the point is to never relax style-src.
    inlineStylesheets: 'never',
    format: 'file',
  },
  vite: {
    build: {
      // Same reasoning for assets: no data: URIs smuggled into CSS.
      assetsInlineLimit: 0,
    },
  },
});
