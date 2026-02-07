# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**TailBliss** is a modern Hugo static site generator theme combining:
- Hugo (v0.148.2+) for static site generation
- TailwindCSS 4.1 with Vite for build optimization
- Alpine.js 3.15.8 for lightweight interactivity
- Full dark/light mode support

The theme is structured as a proper Hugo theme with layouts, assets, and static files in the root, and example content in `exampleSite/`. When used in other projects, it's placed in `themes/tailbliss/`.

## Common Development Commands

### Initial Setup
```bash
pnpm install          # Install dependencies (automatically runs content setup)
```

### Development (Choose One)
```bash
pnpm run dev:watch    # RECOMMENDED: Auto-watches CSS and Hugo with live reload
pnpm run dev          # Traditional: Build CSS once, start Hugo server (manual rebuilds)
```

### Building & Testing
```bash
pnpm run build        # Production build (minified, cache-busted)
pnpm run rebuild      # Clean and rebuild CSS only (for manual mode)
pnpm run test         # Run Hugo build validation (checks for errors)
pnpm run optimize     # Production build with optimization message
```

### Content Setup
```bash
pnpm run install      # Manual content setup (normally auto-runs with pnpm install)
node install.js       # Alternative: Direct install script execution
```

## Build System Architecture

### CSS/Asset Pipeline
1. **Vite** processes `assets/css/main.css` with TailwindCSS 4.1 plugin
2. **Development**: Timestamp-based filenames (e.g., `main.abc123.css`) for instant cache-busting
3. **Production**: Content-hashed filenames (e.g., `main.xyz789.css`) for optimal caching
4. Output: `static/css/` directory (monitored by Hugo for changes)

### Hugo Build Process
- Compiles markdown in `content/` directory
- Processes templates from `layouts/` directory
- Outputs final site to `public/` directory
- Production: Runs with `--minify`, `--gc`, and `--cleanDestinationDir` flags

### Watch Mode Workflow
- `dev:watch` runs CSS watcher and Hugo server concurrently
- CSS changes trigger Vite rebuild with new hash → Hugo detects new CSS → browser auto-reloads
- HTML/template changes trigger Hugo reload directly

## Codebase Architecture

### Directory Structure Key Points
- **`layouts/`**: Hugo templates using `baseof.html` as base wrapper with component partials
- **`assets/css/`**: TailwindCSS 4 with custom OKLCH color variables and prose styles
- **`assets/js/`**: Dark mode toggle (localStorage-backed, respects OS preference)
- **`content/`**: Markdown posts with YAML frontmatter; blog posts in `posts/` subdirectory
- **`static/css/`**: Generated CSS output (cache-busted, auto-cleaned during rebuilds)
- **`exampleSite/`**: Reference content and Hugo config for testing the theme

### CSS Architecture (TailwindCSS 4)
- **Custom Colors**: Primary (Indigo), Secondary (Pink), Neutral, Gray, Zinc using OKLCH color space
- **Dark Mode**: Via `@custom-variant dark` class on `<html>` element
- **Typography**: Custom prose styles (no external `@tailwindcss/typography` dependency)
- **Custom Utilities**: `prose-2xl` for wider content (80ch with 110% font-size)

### Template Structure
- **`baseof.html`**: Wraps all pages with `{{ block "main" . }}` for content injection
- **Partials**: Reusable components (nav, footer, newsletter, post-tile, pagination)
- **Shortcodes**: `imgc` for WebP image optimization with lazy loading
- **Index & List Pages**: Homepage and category/tag archive pages with pagination (9 items/page)

### Configuration Management
- **`hugo.yaml`**: Site config, markup extensions (goldmark tables/footnotes/strikethrough), taxonomy setup
- **`vite.config.mjs`**: Build output targeting, cache-busting strategy, watch exclusions
- **`tailwind.config.js`**: Minimal; most config moved to CSS via `@theme` directive in `main.css`

## Important Development Notes

### CSS Workflow
- **When changing HTML/Tailwind classes**: No rebuild needed. Hugo detects template changes and reloads.
- **When changing CSS variables/colors**: Run `pnpm run rebuild` (manual mode) or wait for auto-rebuild (watch mode)
- Old CSS files auto-deleted on rebuild; unique filenames prevent cache issues

### Common Pitfall: Missing CSS File
If you see "failed to read directory 'static/css'" error:
1. Run `pnpm install` in the theme directory
2. Ensure CSS is built: `pnpm run build:css:dev`
3. Hugo reads CSS from your **site root's** `static/css/`, not the theme's

### Dark Mode Implementation
- Toggle in `assets/js/darkmode.js` (IIFE, no global pollution)
- Uses localStorage to persist preference
- Falls back to OS dark mode preference
- CSS uses `dark:` utility classes prefixed with dark mode custom variant

### Netlify Deployment
- Uses `netlify.toml` for build config (Hugo v0.148.2, minified build)
- Environment: Production builds with `--minify`, `--gc`, `--cleanDestinationDir`
- CSS is built before Hugo runs during deploy

## Testing & Code Quality

- **Hugo Build Test**: `npm test` runs Hugo to validate markdown/template syntax
- **Security Scanning**: CodeQL workflow runs on schedule (Fridays 14:15 UTC) and all PRs/pushes to main
- **Dependabot**: Automated dependency updates enabled

## Content Structure

- **Frontmatter**: YAML metadata (title, date, categories, tags, description)
- **Image Storage**: `assets/images/` for source; automatically optimized for WebP
- **Markdown Extensions Enabled**: Tables, footnotes, strikethrough, task lists, typographer
- **Taxonomies**: Categories and Tags with paginated archive pages

## Development Tips

1. **Fast iteration**: Use `pnpm run dev:watch` to avoid manual CSS rebuilds
2. **Hard refresh**: `Cmd+Shift+R` (Mac) or `Ctrl+Shift+R` (Windows) if styles seem stale (rare with new timestamp system)
3. **Content setup**: The `install.js` script only runs if no `content/` directory exists; won't overwrite existing content
4. **Theme testing**: The `exampleSite/` uses a symlink to test the theme; useful for PR validation
5. **Performance**: Check Hugo lighthouse scores in README; theme achieves high performance via asset optimization and lazy loading
