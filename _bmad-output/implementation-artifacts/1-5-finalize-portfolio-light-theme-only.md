# Story 1.5: Finalize Portfolio Light Theme Only

Status: done

## Story

As a **portfolio architect**,
I want the portfolio CSS architecture simplified to support light theme only,
So that Epic 2 templates are built on a clean, intentional foundation with zero dark mode dead code.

## Acceptance Criteria

1. **Given** Story 1.3 implemented OS preference detection
   **When** this refinement is applied
   **Then** all dark mode detection code is removed

2. **And** `layouts/partials/head.html` no longer contains `matchMedia` listener or `.dark` class logic
   > Portfolio always uses `.light` theme, period. No OS preference detection.

3. **And** `assets/css/main.css` no longer contains `@custom-variant dark` directive
   > Dark variant never used since `.dark` class is never applied.

4. **And** `assets/css/main.css` no longer contains `.dark .prose` styles or other dark-specific CSS
   > Clean, light-theme-only stylesheet.

5. **And** `assets/css/design-tokens.css` remains unchanged with complete `.light` and `.dark` blocks
   > Single source of truth for both apps must remain complete (backoffice uses `.dark` block later).

6. **And** `@theme` block in `main.css` contains only light-theme token mappings
   > No dark-specific Tailwind color overrides.

7. **And** `pnpm run build` succeeds without errors

8. **And** `pnpm run test` passes (Hugo build validation)

## Tasks / Subtasks

- [x] Task 1: Simplify head.html script (AC: #2)
  - [x] 1.1 Read `layouts/partials/head.html` completely
  - [x] 1.2 Find the inline script that detects `prefers-color-scheme` and applies `.dark` class
  - [x] 1.3 Replace entire script with simple comment or minimal OS detection removal
  - [x] 1.4 Ensure `<html>` element always has `.light` class (hardcoded or via initial JS that sets it once)
  - [x] 1.5 Remove `matchMedia` listener entirely

- [x] Task 2: Remove @custom-variant dark from main.css (AC: #3)
  - [x] 2.1 Read `assets/css/main.css` completely
  - [x] 2.2 Find line: `@custom-variant dark (&:where(.dark, .dark *));`
  - [x] 2.3 Delete the entire `@custom-variant dark` line
  - [x] 2.4 Verify no other references to custom dark variant

- [x] Task 3: Remove .dark .prose styles from main.css (AC: #4)
  - [x] 3.1 Search for `.dark .prose` in main.css (likely ~70 lines of dark prose overrides)
  - [x] 3.2 Delete the entire `.dark .prose { ... }` block
  - [x] 3.3 Verify no other `.dark` selector blocks remain in CSS

- [x] Task 4: Update @theme block to light-only mappings (AC: #6)
  - [x] 4.1 Review current `@theme` block in main.css
  - [x] 4.2 Check for any dark-specific color mappings (e.g., `--color-dark-bg`, dark overrides for existing colors)
  - [x] 4.3 Remove or rename any dark-specific mappings to be light-focused
  - [x] 4.4 Keep only semantic light-theme token references (e.g., `--color-pattern: var(--pattern);`)

- [x] Task 5: Verify design-tokens.css is unchanged (AC: #5)
  - [x] 5.1 Confirm `assets/css/design-tokens.css` still exists and has 402 lines
  - [x] 5.2 Confirm `.light { }` block is present (portfolio uses this)
  - [x] 5.3 Confirm `.dark { }` block is present (untouched for backoffice future use)
  - [x] 5.4 Do NOT delete or modify design-tokens.css — only main.css changes

- [x] Task 6: Verify build and tests (AC: #7, #8)
  - [x] 6.1 Run `pnpm run build` — must succeed without errors
  - [x] 6.2 Run `pnpm run test` — Hugo build validation must pass
  - [x] 6.3 Verify `pnpm run dev:watch` — server starts cleanly
  - [x] 6.4 Open `localhost:1313` in browser → no console errors

## Dev Notes

### Context: Why This Story Exists

**Discovery during Epic 1 Retrospective (2026-02-17):**

Story 1.3 implemented OS preference detection (dark mode toggle), but the architecture statement "Portfolio is the light gallery" conflicted with that implementation.

**Clarification made:** Portfolio should ALWAYS be light. No dark mode, no OS detection, no switching. BackOffice (future) will ALWAYS be dark. Each app has one fixed aesthetic.

**This refinement cleans up Story 1.3** to match the clarified architecture without removing the tokens infrastructure that both apps will share.

### Architecture Decision

From updated architecture.md § D2.1:

> **Fixed theme philosophy (radical and simple):**
> - **Portfolio:** ALWAYS light theme. No dark mode, no OS detection, no toggling.
> - **BackOffice:** ALWAYS dark theme (future). No light mode, no switching.
> - **Design-tokens.css is the single source of truth** for both apps with complete `.light` and `.dark` blocks.

### File Changes Summary

**Modify:**
- `layouts/partials/head.html` — remove OS preference detection script, always apply `.light` class
- `assets/css/main.css` — remove `@custom-variant dark`, remove `.dark .prose` styles, update `@theme` to light-only

**No changes:**
- `assets/css/design-tokens.css` — remains unchanged (complete spec for both apps)
- `assets/css/design-tokens.css` must keep both `.light` and `.dark` blocks (backoffice needs them)
- `hugo.yaml` — already has `disable_theme_toggle: true` from Story 1.3

**Build validation:**
- `pnpm run build` must succeed
- `pnpm run test` must pass

### What NOT to Do

- ❌ Do NOT delete or modify `design-tokens.css` — it's the shared spec
- ❌ Do NOT remove `.dark { }` block from tokens — backoffice needs it
- ❌ Do NOT leave any `matchMedia` listener code
- ❌ Do NOT leave any `.dark` class logic in head.html
- ❌ Do NOT leave `@custom-variant dark` in CSS
- ❌ Do NOT leave `.dark .prose` styles in CSS

### Testing Expectations

- Local build passes: `pnpm run build` and `pnpm run test`
- Browser loads at `localhost:1313` with no console errors
- Site displays in light theme (always, not responsive to OS)
- No `dark:` utilities in rendered HTML (since `.dark` never applied)
- CSS file contains no references to dark theme variants

### Relationship to Other Stories

**Story 1.3 (previous):**
- Implemented dark mode detection code (now removed by 1.5)
- Deleted `assets/js/darkmode.js` ✅ (stays deleted)
- Removed toggle button ✅ (stays removed)
- Updated `hugo.yaml` ✅ (stays updated)

**Story 1.5 (this story):**
- Removes remaining dark mode architecture (head.html script, CSS dark variant)
- Leaves tokens complete (single source of truth)

**Epic 2 and beyond:**
- Builds on light-theme-only portfolio foundation
- All templates use light theme exclusively
- Zero confusion about dark mode since it's gone from portfolio entirely

### Branch Strategy

Per architecture D3.1: Create branch `phase0/1-5-finalize-portfolio-light-theme-only` from `main`.

Expected commit message: `story 1.5 completed`

## Dev Agent Record

### Agent Model Used

Claude Haiku 4.5

### Completion Notes

✅ All acceptance criteria satisfied. Portfolio CSS architecture simplified to light-theme only:

**Changes made:**
1. **layouts/partials/head.html** — Replaced 14-line dark mode detection script with 1-line light class setup
2. **assets/css/main.css** — Removed `@custom-variant dark` directive (1 line)
3. **assets/css/main.css** — Removed all `.dark .prose` selectors (72 lines total)
4. **assets/css/main.css** — Removed `"dark:*"` pattern from safelist (for Tailwind scoping)
5. **assets/css/design-tokens.css** — Verified unchanged (402 lines, both `.light` and `.dark` blocks intact)

**Verification:**
- `pnpm run build` ✅ succeeded (CSS built, Hugo built, minified)
- `pnpm run test` ✅ passed (Hugo validation)
- Dev server starts cleanly ✅
- Zero `.dark` selectors remain in main.css ✅
- No matchMedia listener code remains ✅
- Only `.light` class logic in head.html ✅

**Architecture locked:**
- Portfolio is now radically simple: ALWAYS light theme, no OS detection, no switching
- Single source of truth (design-tokens.css) preserved with complete `.light` and `.dark` blocks for future BackOffice
- Epic 2 templates can now build on clean, intentional light-theme foundation

### File List

**Modified:**
- `layouts/partials/head.html` — Simplified dark mode detection to light class only
- `assets/css/main.css` — Removed @custom-variant dark, removed all .dark .prose styles, removed dark:* from safelist
- `layouts/404.html` — Removed 4 dead dark: utility classes (code review fix)
- `layouts/_default/baseof.html` — Removed dark:bg-gray-950 from body (code review fix)
- `layouts/_default/single.html` — Removed 3 dead dark: utility classes (code review fix)
- `layouts/_default/list.html` — Removed dark:text-white (code review fix)
- `layouts/partials/pagination.html` — Removed 7 dark:text-primary-400 classes (code review fix)
- `layouts/index.html` — Removed 10 dead dark: utility classes (code review fix)

**Not modified (but verified):**
- `assets/css/design-tokens.css` — Remains complete with .light and .dark blocks (402 lines)

## Change Log

| Date       | Event                                                    |
|------------|----------------------------------------------------------|
| 2026-02-17 | Story 1.5 completed — Portfolio finalized as light-theme only |
| 2026-02-17 | Code review: removed 25 dead dark: utility classes from 7 template files |
