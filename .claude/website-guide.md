# Website Guide

Static landing page for whispervibe.

## Architecture

- SvelteKit (Svelte 5) static site
- Tailwind CSS v4 for styling (via `@tailwindcss/vite` plugin)
- `adapter-static` for deployment (GitHub Pages compatible)
- Single `+page.svelte` contains all landing page content

## Page Sections

The landing page is a single-page layout with these sections in order:

1. **Hero** — tagline, subtitle, interactive demo, download buttons
2. **Interactive demo** — tabbed demo with 3 "vibes" (Claude Code, Terminal, Communication). Each shows a voice input → cleaned output transformation with typing animation
3. **Features grid** — 4-column grid: Hacker-First, AI Clean-up, Context Aware, Local or Cloud
4. **Benchmarks** — performance comparison table (whispervibe vs Wispr Flow vs Superwhisper vs Apple Dictation)
5. **CTA** — "Ready to change how you code?" with download buttons
6. **Footer** — logo, links (Docs, License, Privacy, GitHub), copyright

## Interactive Features

- **Vibe tabs** — click to switch demo context; each vibe has its own input/output text
- **Typing animation** — output text types character-by-character (40ms interval per char)
- **Wave animation** — animated frequency bars during voice processing state
- **Pulse indicator** — green dot with version badge ("v0.2.11 Now Available")
- **Hover effects** — scale/color transitions on buttons and feature cards

## Styling System

### CSS Custom Properties (`app.css`)

```
Backgrounds:  --bg-deep, --bg-base, --bg-surface, --bg-raised, --bg-overlay, --bg-hover
Text:         --text-primary, --text-secondary, --text-tertiary
Accent:       --accent (#6c5ce7), --accent-soft, --accent-glow
Status:       --red, --green, --amber (each with -soft and -glow variants)
Typography:   --font ('DM Sans'), --mono ('JetBrains Mono')
Layout:       --radius-sm (8px), --radius (12px), --radius-lg (16px)
Transition:   --transition (180ms cubic-bezier)
```

### Fonts

- **DM Sans** (variable, italic + upright) — body text, loaded from `static/fonts/`
- **JetBrains Mono** (variable) — code/monospace, loaded from `static/fonts/`

### Tailwind Integration

Tailwind v4 is configured via the `@tailwindcss/vite` plugin in `vite.config.ts`. Custom properties are used alongside Tailwind utility classes.

## Dev Commands

- `pnpm dev` — start dev server (localhost:5173)
- `pnpm run build` — build for production → `build/`
- `pnpm run check` — type check with svelte-check
- `pnpm preview` — preview production build

## Versioning

- `VERSION` is source of truth for website version
- Bump on every commit/deploy
- Run `./scripts/sync-version.sh` after bumping to sync into `package.json`

## Build Output

- `build/` directory contains pre-rendered static HTML, CSS, JS, and fonts
- `svelte.config.js` sets `fallback: '404.html'` for SPA routing on static hosts
- Output is ready for GitHub Pages or any static file host

## Key Files

- `src/routes/+page.svelte` — main landing page content and all section markup
- `src/routes/+layout.svelte` — root layout wrapper (metadata, head tags)
- `src/app.css` — global styles, CSS variables, font-face declarations
- `svelte.config.js` — SvelteKit static adapter configuration
- `vite.config.ts` — Vite + Tailwind + SvelteKit plugin setup
- `scripts/sync-version.sh` — VERSION → package.json automation
