# Story 5.0: Design-Config TOML, Backlog Sweep & Hugo Gotchas (Prep)

Status: ready-for-dev

## Story

As a **development team**,
I want all DESIGN-SPEC measurable values extracted into structured TOML, all deferred items from Epics 1-4 swept into a backlog, and recurring Hugo gotchas documented,
So that Epic 5 starts with a clean slate — no tech debt, no lost deferred items, and a machine-readable design contract.

## Acceptance Criteria

1. `_bmad-output/implementation-artifacts/design-config.toml` exists with all measurable values from DESIGN-SPEC organized by component
2. The DESIGN-SPEC prose document references the TOML as the authoritative source for values (add note at top)
3. TOML values are cross-checked against implemented partials — actual CSS/HTML matches TOML (spot-check confidence bar, pattern card, timeline dot)
4. `_bmad-output/implementation-artifacts/backlog.md` is updated with any additional deferred items swept from Epic 1-4 story records (beyond what the retro already captured)
5. Hugo gotchas are documented in `docs/hugo-gotchas.md` — at minimum: slice empty checks (`len` not `if not`), `safeCSS` for dynamic CSS variables, and any others found during sweep
6. Story template (`_bmad/bmm/workflows/4-implementation/create-story/template.md`) references `design-config.toml` as the values contract in the Dev Notes section
7. Backlog review flagged as mandatory in the Epic 5 retrospective (already exists in backlog.md — verify it's there)
8. `pnpm run test` passes

## Tasks / Subtasks

- [ ] Extract DESIGN-SPEC values into `design-config.toml` (AC: 1, 2)
  - [ ] Scan DESIGN-SPEC.md sections for measurable values: typography sizes/weights, color tokens, spacing, border radii, component specs (confidence bar height, dot sizes, grid columns, etc.)
  - [ ] Organize TOML by component: `[typography]`, `[colors]`, `[spacing]`, `[components.confidence_bar]`, `[components.pattern_card]`, `[components.timeline]`, etc.
  - [ ] Add a note at the top of DESIGN-SPEC.md: "Measurable values are the authoritative source: see `design-config.toml`"

- [ ] Cross-check TOML against implemented partials (AC: 3)
  - [ ] `layouts/partials/confidence-bar.html` — verify height matches `components.confidence_bar.height` (should be 3px, not 4px/h-1)
  - [ ] `layouts/partials/timeline-moment.html` — verify dot size matches TOML (should be 5px, not 10px)
  - [ ] `layouts/partials/pattern-card.html` — verify any hardcoded values match TOML
  - [ ] Note any drift found; fix critical mismatches in this story

- [ ] Sweep Epic 1-4 story records for deferred items (AC: 4)
  - [ ] Read through `4-1-*.md`, `4-2-*.md`, `4-3-*.md`, `4-4-*.md`, `4-5-*.md` — look for deferred/TODO comments
  - [ ] Read through `3-*.md` files — look for deferred items
  - [ ] Read through `2-*.md` and `1-*.md` files — any deferred items not yet in backlog
  - [ ] Add any new items to `backlog.md` (constellation SVG already there — don't duplicate)

- [ ] Document Hugo gotchas (AC: 5)
  - [ ] Create `docs/hugo-gotchas.md` (create `docs/` if it doesn't exist)
  - [ ] Document: slice empty check — use `len` or `gt (len $slice) 0`, NOT `if not $slice`
  - [ ] Document: dynamic CSS values — must use `safeCSS` (e.g., `{{ printf "background: %s" $color | safeCSS }}`)
  - [ ] Document: `where` query alignment — use `.Params.fieldName` not `.fieldName` for frontmatter fields
  - [ ] Document: date sorting — use `sort` with `.Date` descending for chronological order
  - [ ] Add any others found during the sweep

- [ ] Update story template to reference design-config.toml (AC: 6)
  - [ ] Add a line in the Dev Notes section of `_bmad/bmm/workflows/4-implementation/create-story/template.md`: "Design values contract: `_bmad-output/implementation-artifacts/design-config.toml`"

- [ ] Verify backlog mandatory review flag (AC: 7)
  - [ ] Confirm `backlog.md` contains the mandatory Epic 5 retrospective review note

- [ ] Run `pnpm run test` (AC: 8)

## Dev Notes

### Why This Story Exists

Epic 4 Retro identified three recurring problems:
1. **LLM drift on pixel values** — DESIGN-SPEC has values, but they're buried in prose. Dev agents output `h-1` (4px) instead of the specified 3px. Story 4.2 and 4.3 both had critical review issues for this reason.
2. **Lost deferred items** — Constellation SVG was deferred in Story 4.2 with only a comment in the story file. No backlog existed.
3. **Hugo gotchas rediscovered** — `if not` on slices and `safeCSS` appeared in multiple stories.

The TOML approach: structured values as machine-readable contract alongside prose rationale. Future dev agents read TOML for exact values; they read prose for rationale. Prevents the "correct spec, wrong implementation" failure mode.

### design-config.toml Structure

```toml
# design-config.toml — Authoritative values contract for ndb_hugo
# Generated from: _bmad-output/implementation-artifacts/DESIGN-SPEC.md
# Last updated: 2026-03-07

[typography]
heading_font = "Literata"
body_font = "Hanken Grotesk"
mono_font = "Commit Mono"
heading_weights = [400, 500, 700]
body_weights = [400, 500, 600, 700]

[colors]
# OKLCH semantic palette — matches design-tokens in main.css
# block states
fresh = "oklch(78% 0.17 145)"        # green — new, recent, unvalidated
pattern = "oklch(65% 0.15 250)"      # blue — structural, reliable
convergence = "oklch(72% 0.18 55)"   # amber — intersecting skills
depth = "oklch(45% 0.12 290)"        # violet — deep mastery

[spacing]
portfolio_max_width = "920px"
post_content_max_width = "700px"
# ... etc

[components.confidence_bar]
height = "3px"             # CRITICAL: NOT h-1 (4px). Verified in Story 4.2 review.
border_radius = "2px"
# color thresholds use semantic palette

[components.timeline]
dot_size = "5px"           # CRITICAL: NOT 10px. Verified in Story 4.3 review.
dot_border_radius = "50%"
spine_color = "var(--color-neutral-200)"

[components.pattern_card]
grid_cols_desktop = 2
grid_cols_mobile = 1
# constellation SVG: deferred (see backlog.md)
```

### Cross-Check Method

For each component, read the implemented partial and compare rendered values against TOML. Prioritize:
- `confidence-bar.html` — height was a critical issue in Story 4.2
- `timeline-moment.html` — dot size was a critical issue in Story 4.3
- Any `style=` inline values or hardcoded Tailwind class equivalents

### Hugo Gotchas Reference

Key gotchas confirmed across Epic 3-4:

| Gotcha | Wrong | Correct |
|--------|-------|---------|
| Slice empty check | `{{ if not $items }}` | `{{ if eq (len $items) 0 }}` or `{{ if not (gt (len $items) 0) }}` |
| Dynamic CSS variables | `style="color: {{ $color }}"` | `{{ printf "color: %s" $color \| safeCSS }}` |
| Frontmatter query | `where .fieldName true` | `where .Params.fieldName true` |
| Date sort descending | `sort .Pages "Date"` | `sort .Pages "Date" "desc"` |
| Empty slice detection for `if` blocks | `{{ if $pages }}` (unreliable) | `{{ if gt (len $pages) 0 }}` |

### Project Structure Notes

- New file: `_bmad-output/implementation-artifacts/design-config.toml`
- New file: `docs/hugo-gotchas.md`
- Modified: `_bmad-output/implementation-artifacts/DESIGN-SPEC.md` (add TOML reference note)
- Modified: `_bmad-output/implementation-artifacts/backlog.md` (add swept items if any)
- Modified: `_bmad/bmm/workflows/4-implementation/create-story/template.md` (add design-config reference)
- Possibly modified: implemented partials if cross-check finds critical drift

### References

- [Source: epics.md §Epic 5, Story 5.0 AC]
- [Source: epic-4-retro-2026-03-07.md — §Challenges: DESIGN-SPEC Values Lost in Prose]
- [Source: epic-4-retro-2026-03-07.md — §Challenges: No Backlog for Deferred Items]
- [Source: epic-4-retro-2026-03-07.md — §Challenges: Hugo Gotchas Rediscovered]
- [Source: backlog.md — existing deferred items to NOT duplicate]

## Dev Agent Record

### Agent Model Used

*Recommended: claude-sonnet-4-6 — structural analysis + cross-referencing across multiple documents*

### Debug Log References

### Completion Notes List

### File List
