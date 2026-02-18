# Story 2.2: Redesign Navigation

Status: done

## Story

As a **portfolio visitor**,
I want a clean navigation bar that matches the portfolio's visual identity,
So that I can navigate between sections easily on any device.

## Acceptance Criteria

1. **Given** the nav uses the default TailBliss design
   **When** the nav is redesigned
   **Then** `layouts/partials/nav.html` matches DESIGN-SPEC §6.2

2. **And** the nav has backdrop blur on scroll (Alpine.js `x-data` for scroll detection)

3. **And** there is no dark mode toggle button in the nav

4. **And** nav links include: Home, Posts, Patterns, Timeline, About — in Hanken Grotesk 14px

5. **And** the nav is responsive (mobile hamburger menu or equivalent at `sm` breakpoint)

6. **And** the nav uses design token colors (not hardcoded values)

7. **And** the nav logo shows "ndb" in Literata 18px weight 500

8. **And** `hugo.yaml` menu config is updated with correct nav items

9. **And** `pnpm run test` passes

## Tasks / Subtasks

- [x] Task 1: Update hugo.yaml menu configuration (AC: #8)
  - [x] 1.1 Replace current `menu.main` entries with: Home (`/`), Posts (`/posts/`), Patterns (`/patterns/`), Timeline (`/timeline/`), About (`/about/`)
  - [x] 1.2 Remove `categories` and `dropdown` menu sections (TailBliss leftovers)
  - [x] 1.3 Update `menu.footer` entries to match new site structure

- [x] Task 2: Rewrite nav.html partial (AC: #1, #2, #3, #4, #6, #7)
  - [x] 2.1 Read current `layouts/partials/nav.html` completely
  - [x] 2.2 Rewrite to DESIGN-SPEC §6.2 specifications:
    - Sticky top, 54px height
    - Left: "ndb" logo text — `font-heading text-[18px] font-medium`
    - Right: nav links — `font-body text-[14px]`
    - Active link: text-primary, weight 600. Others: text-secondary, weight 400
    - Max-width: 920px centered
  - [x] 2.3 Add Alpine.js scroll detection for backdrop blur:
    - `x-data="{ scrolled: false }"` on nav element
    - `@scroll.window="scrolled = window.scrollY > 10"`
    - Transparent at top, `backdrop-blur-[10px]` + semi-transparent bg + border on scroll
  - [x] 2.4 Ensure NO dark mode toggle button exists
  - [x] 2.5 Use design token colors via Tailwind utilities (not hardcoded hex/oklch)

- [x] Task 3: Add responsive mobile menu (AC: #5)
  - [x] 3.1 Add Alpine.js `x-data="{ open: false }"` for mobile menu toggle
  - [x] 3.2 Add hamburger button visible only below `sm` breakpoint
  - [x] 3.3 Add mobile menu panel (full-width dropdown or slide-in)
  - [x] 3.4 Use `x-cloak` on mobile menu to prevent flash
  - [x] 3.5 Ensure desktop nav links hidden on mobile, shown on `sm:` and above

- [x] Task 4: Verify build and rendering (AC: #9)
  - [x] 4.1 Run `pnpm run build` — must succeed
  - [x] 4.2 Run `pnpm run test` — Hugo build validation must pass
  - [x] 4.3 Verify nav renders correctly at desktop and mobile widths

## Dev Notes

### DESIGN-SPEC §6.2 — Navigation Component

- Sticky top, 54px height
- Background: transparent at top, blurs (`backdrop-filter: blur(10px)`) + semi-transparent + border on scroll
- Left: "ndb" in Literata 18px weight 500
- Right: Posts, Patterns, Timeline, About — Hanken Grotesk 14px
- Active link: text-primary, weight 600. Others: text-secondary, weight 400
- Max-width: 920px centered

### Alpine.js Scroll Detection Pattern

```html
<nav x-data="{ scrolled: false, open: false }"
     @scroll.window="scrolled = window.scrollY > 10"
     :class="scrolled ? 'bg-[var(--surface-elevated)]/80 backdrop-blur-[10px] border-b border-[var(--border)]' : 'bg-transparent'"
     class="fixed top-0 w-full z-50 transition-none">
```

Per DESIGN-SPEC §9: No CSS transitions. The blur/background change should be instant (no `transition-*` classes). Use `transition-none` explicitly.

### Current Nav State

The existing `nav.html` is a TailBliss default with:
- Complex dropdown menus (categories, complex dropdown)
- Dark mode toggle button (should already be removed from Story 1.3/1.5)
- TailBliss logo/branding references
- Alpine.js `x-data` for mobile menu (can be adapted)

**Rewrite entirely** — the TailBliss nav structure is too different from DESIGN-SPEC to patch.

### Hugo Menu Template Pattern

```go-html-template
{{/* Nav links from hugo.yaml menu.main */}}
{{ range .Site.Menus.main }}
  <a href="{{ .URL }}"
     class="font-body text-[14px] {{ if $.IsMenuCurrent "main" . }}text-[var(--text-primary)] font-semibold{{ else }}text-[var(--text-secondary)] font-normal hover:text-[var(--text-primary)]{{ end }}">
    {{ .Name }}
  </a>
{{ end }}
```

### Previous Story Dependencies

- **Story 2.1** adds Google Fonts and `font-heading`/`font-body`/`font-mono` Tailwind utilities
- This story DEPENDS on 2.1 being complete for font classes to work
- If 2.1 is not done, font classes will fall back to system fonts (graceful degradation)

### Design Token Color References

Use CSS custom property references via Tailwind arbitrary values:
- `text-[var(--text-primary)]` — primary text
- `text-[var(--text-secondary)]` — secondary text (nav links)
- `bg-[var(--surface-elevated)]` — elevated surface (blurred nav bg)
- `border-[var(--border)]` — border color

Alternatively, if tokens are mapped in `@theme`, use the Tailwind utility names directly.

### What NOT to Do

- ❌ Do NOT keep TailBliss dropdown menus — replace entirely
- ❌ Do NOT add CSS transitions/animations — DESIGN-SPEC §9 forbids them
- ❌ Do NOT use hardcoded color values — use design token references
- ❌ Do NOT add a dark mode toggle
- ❌ Do NOT create a separate JS file for nav — use inline Alpine.js `x-data`
- ❌ Do NOT use `partials/components/nav/` subdirectory — flat partial naming

### Scope Boundary

This story redesigns `nav.html` and updates `hugo.yaml` menus. It does NOT:
- Create hero partial (Story 2.3)
- Redesign footer (Story 2.4)
- Create any new content sections or pages
- Build the homepage layout

### Project Structure Notes

**Files to modify:**
- `layouts/partials/nav.html` — Complete rewrite to DESIGN-SPEC
- `hugo.yaml` — Update menu.main and menu.footer entries

**Files NOT to modify:**
- `layouts/_default/baseof.html` — Already calls nav partial
- `assets/css/main.css` — No CSS changes needed (Tailwind utilities only)

### References

- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md#Component: Navigation]
- [Source: _bmad-output/planning-artifacts/architecture.md#D2.3: Alpine.js Scope]
- [Source: _bmad-output/planning-artifacts/architecture.md#Naming Patterns]
- [Source: _bmad-output/planning-artifacts/epics.md#Story 2.2]

### Branch Strategy

Per architecture D3.1: Create branch `phase0/2-2-redesign-navigation` from `main`.

## Dev Agent Record

### Agent Model Used

Claude Opus 4.6

### Debug Log References

None — clean implementation, no issues encountered.

### Completion Notes List

- Replaced TailBliss nav entirely with DESIGN-SPEC §6.2 compliant navigation
- hugo.yaml: Replaced menu.main with Home/Posts/Patterns/Timeline/About; removed categories and dropdown sections; updated footer menu
- nav.html: Fixed 54px sticky nav with "ndb" logo (font-heading 18px medium), right-aligned links (font-body 14px), active link highlighting via `IsMenuCurrent`
- Alpine.js scroll detection: transparent at top, backdrop-blur + semi-transparent bg + border on scroll (no CSS transitions per §9)
- Mobile: hamburger below `sm` breakpoint, full-width dropdown with x-cloak, desktop links hidden on mobile
- No dark mode toggle, no hardcoded colors — all design token CSS custom properties
- Home link excluded from desktop nav (logo serves as home link) but included in mobile menu
- `pnpm run test` and `pnpm run build` both pass

### Senior Developer Review (AI)

**Reviewer:** Nicolas (adversarial review) — 2026-02-18
**Build:** ✅ PASSES (53ms)
**All 9 ACs:** ✅ VALIDATED

**Issues Found & Fixed (4 HIGH, 2 MEDIUM, 2 LOW):**

1. ✅ FIXED [HIGH] Added `aria-controls="mobile-nav-menu"` on hamburger + `id="mobile-nav-menu"` on menu panel (WCAG 1.3.1)
2. ✅ FIXED [HIGH] Added `@click="open = false"` on mobile menu links — menu now closes on navigation
3. ✅ FIXED [HIGH] Added `@keydown.escape="open = false"` on nav element — Escape key closes mobile menu (WCAG 2.1.1)
4. ✅ FIXED [HIGH] Added `focus-visible:outline-2 focus-visible:outline-offset-2` on all interactive elements (WCAG 2.4.7)
5. NOTED [MEDIUM] Scroll threshold `window.scrollY > 10` is a magic number — not in DESIGN-SPEC
6. NOTED [MEDIUM] Hamburger icon color doesn't adapt on scroll state
7. ✅ FIXED [LOW] Mobile menu panel now has `id="mobile-nav-menu"` for aria association
8. NOTED [LOW] Home link in mobile but not desktop is intentional (documented in story)

**Verdict:** APPROVED after fixes applied. All HIGH issues resolved.

### Change Log

- 2026-02-18: Story 2.2 implemented — redesigned navigation to DESIGN-SPEC §6.2
- 2026-02-18: Code review — fixed 4 accessibility issues (aria-controls, escape key, focus-visible, mobile menu close)

### File List

- `hugo.yaml` — Updated menu.main and menu.footer, removed categories/dropdown sections
- `layouts/partials/nav.html` — Complete rewrite: DESIGN-SPEC §6.2 nav with Alpine.js scroll detection and mobile menu; accessibility fixes applied
