# whisper-dic-website

Static landing page for [whispervibe](https://github.com/timmeromberg/whisper-dic) — the open-source hold-to-dictate tool.

## Stack

- **SvelteKit** (Svelte 5) with `adapter-static`
- **Tailwind CSS v4** via Vite plugin
- **Vite 7** build tooling
- **TypeScript** strict mode

## Development

Prerequisites: Node 20+, pnpm.

```bash
pnpm install
pnpm dev          # dev server on localhost:5173
pnpm run check    # type check
pnpm run build    # static build → build/
pnpm preview      # preview production build
```

## Project Structure

```
src/
├── routes/
│   ├── +layout.svelte    # root layout (metadata, global wrapper)
│   └── +page.svelte      # landing page (all sections)
├── lib/
│   ├── assets/favicon.svg
│   └── index.ts
├── app.css               # global styles, CSS variables, font imports
├── app.html              # HTML template
└── app.d.ts              # TypeScript declarations
static/
├── fonts/                # DM Sans, JetBrains Mono (variable TTFs)
└── robots.txt
scripts/
└── sync-version.sh       # sync VERSION → package.json
```

## Design System

Dark theme matching the desktop app aesthetic.

**Fonts:** DM Sans (body), JetBrains Mono (code) — loaded from `static/fonts/`.

**Colors** (CSS custom properties in `app.css`):

| Token | Purpose |
|---|---|
| `--bg-deep` / `--bg-base` / `--bg-surface` | Background layers |
| `--text-primary` / `--text-secondary` | Typography |
| `--accent` (`#6c5ce7`) | Purple accent, buttons, highlights |
| `--green` / `--red` / `--amber` | Status colors with `-soft` and `-glow` variants |

## Versioning

`VERSION` is the source of truth. After bumping, run:

```bash
./scripts/sync-version.sh
```

This updates `package.json` to match.

## Deployment

`pnpm run build` outputs a fully static site to `build/`. The SvelteKit config uses `fallback: '404.html'` for SPA-style routing on static hosts like GitHub Pages.

## License

MIT
