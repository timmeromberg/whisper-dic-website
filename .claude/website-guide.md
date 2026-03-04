# Website Guide

Static landing page for whispervibe.

## Architecture

- SvelteKit (Svelte 5) static site
- Tailwind CSS v4 for styling
- `adapter-static` for deployment (GitHub Pages compatible)

## Key Details

- Built to mirror the app's dark theme and "hacker/developer" aesthetic
- Uses shared assets (fonts, colors) from the main app where possible
- Single-page layout with smooth scrolling sections

## Dev Commands

- `npm run dev` — start dev server
- `npm run build` — build for production
- `npm run check` — type check

## Versioning

- `VERSION` is source of truth for website version
- Bump on every commit/deploy
- Run `./scripts/sync-version.sh` after bumping to sync into `package.json`

## Key Files

- `src/routes/+page.svelte` — main landing page content
- `src/app.css` — global styles and font definitions
- `svelte.config.js` — SvelteKit configuration
- `tailwind.config.js` — Tailwind configuration (if applicable, or via CSS)
