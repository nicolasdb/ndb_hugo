# Story 4.2: Build Pattern Card & Pattern Pages

Status: done

## Story

As a **portfolio visitor**,
I want to browse skill patterns as visual cards and drill into pattern detail pages,
So that I can understand Nicolas's emerging capabilities and their evidence.

## Acceptance Criteria

1. `layouts/partials/pattern-card.html` renders a card with title, confidence, block count, timespan, and short description
2. The partial receives context via `dict` (`{{ partial "pattern-card.html" (dict "pattern" . "index" $i) }}`)
3. `layouts/patterns/list.html` displays pattern cards in a responsive grid
4. `layouts/patterns/single.html` renders full pattern detail (description, confidence bar, block count, timespan, trajectory, linked tags)
5. The `confidence-bar.html` partial (from Epic 3) is reused on pattern detail pages
6. Pattern cards use design token colors and Tailwind utilities (no custom CSS for layout)
7. `pnpm run test` passes

## Tasks / Subtasks

- [x] Create `layouts/partials/pattern-card.html` (AC: 1, 2, 6)
  - [x] Accept `dict` context with `"pattern"` and `"index"` keys
  - [x] Render: title (Literata 16px heading), confidence bar snippet, blockCount + timespan meta (Commit Mono), description excerpt
  - [x] Use `{{ with .pattern.Params.confidence }}` guards for optional fields
  - [x] Card border: 1px `--border`, radius 3px, background `--surface-elevated`
  - [x] Use semantic color tokens from DESIGN-SPEC §3

- [x] Create `layouts/patterns/` directory and `list.html` (AC: 3)
  - [x] Extend `_default/baseof.html` with `{{ define "main" }}`
  - [x] Query `.Pages` for all patterns, display in responsive grid (2-col on md+)
  - [x] Use `pattern-card.html` partial with dict context
  - [x] Include `section-heading.html` partial for page title
  - [x] Graceful empty state (no patterns → message, no error)

- [x] Create `layouts/patterns/single.html` (AC: 4, 5)
  - [x] Extend `_default/baseof.html`
  - [x] Render full pattern: title (h1), description, confidence bar (`confidence-bar.html` partial)
  - [x] Meta section: blockCount, timespan, trajectory — Commit Mono, design token colors
  - [x] Tags section: tag pills linking to tag pages
  - [x] Body content (markdown)
  - [x] Back link: "← Patterns" (Commit Mono 12px, text-tertiary)
  - [x] Use `{{ with }}` / `{{ if }}` guards for all optional fields

- [x] Run `pnpm run test` (AC: 7)

## Dev Notes

### Pattern Card DESIGN-SPEC Reference (§6)

From DESIGN-SPEC §6 "Component: Pattern Card (2×2 grid)":
- Border: 1px `--border`, radius 3px, background `--surface-elevated`
- Top row: title (Literata 16px, weight 700) + meta (Commit Mono 11px, text-tertiary: `{blocks} blocks · {span} · {trajectory}`)
  - Trajectory in `--convergence` color
- Description: Hanken Grotesk 13px, line-height 1.6, text-secondary
- Confidence bar: label "CONFIDENCE" (Commit Mono 10px uppercase), 3px bar, percentage
- Mini constellation SVG (72×44px) — **Skip for Phase 0** (procedural SVG is backoffice scope). Use a simple confidence bar instead.

**Phase 0 simplification for constellation:** The mini constellation is described but not critical for Phase 0. Implement the card without it — the confidence bar covers the essential visual. Note "constellation deferred" in dev notes.

### Partial Interface — Dict Context Pattern (from Epic 3)

Follow the established dict context pattern from Epic 3 partials:

```html
{{/* pattern-card.html — receives dict context */}}
{{- $pattern := .pattern -}}
{{- $index := .index | default 0 -}}

<article class="...">
  <a href="{{ $pattern.RelPermalink }}">
    <h3>{{ $pattern.Title }}</h3>
    {{- with $pattern.Params.confidence -}}
      {{ partial "confidence-bar.html" (dict "confidence" .) }}
    {{- end -}}
    {{- with $pattern.Params.blockCount -}}
      <span>{{ . }} blocks</span>
    {{- end -}}
    ...
  </a>
</article>
```

### Reusing `confidence-bar.html`

The `confidence-bar.html` partial already exists from Story 3.2. It accepts `dict` with `"confidence"` key:
```html
{{ partial "confidence-bar.html" (dict "confidence" .Params.confidence) }}
```

Check the existing partial's interface before using — it was built with dict context. Verify the key name. [Source: 3-2-build-block-meta-confidence-partials.md]

### Layout Inheritance Pattern

Follow the same pattern as `layouts/posts/list.html` and `layouts/posts/single.html` from Story 3.4:

```html
{{ define "main" }}
<main>
  ...
</main>
{{ end }}
```

No need to extend `_default/list.html` — define `main` block directly.

### File Structure to Create

```
layouts/
  partials/
    pattern-card.html          ← NEW
  patterns/
    list.html                  ← NEW
    single.html                ← NEW
```

### Graceful Degradation (Required)

All optional pattern fields use guards:
```html
{{- with .Params.confidence -}} ... {{- end -}}
{{- with .Params.blockCount -}} ... {{- end -}}
{{- with .Params.timespan -}} ... {{- end -}}
{{- with .Params.trajectory -}} ... {{- end -}}
```

Patterns without these fields (e.g., if some were created before the archetype was updated) should render cleanly as basic cards — title + description only.

### Responsive Grid

```html
<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
  {{ range .Pages }}
    {{ partial "pattern-card.html" (dict "pattern" . "index" $i) }}
  {{ end }}
</div>
```

Max-width 920px, page padding-x 32px per DESIGN-SPEC §4.

### Architecture Compliance

- [Source: epics.md §D1.2] — Pattern section has dedicated list/single layouts
- [Source: DESIGN-SPEC.md §6] — Pattern card component spec, 2×2 grid
- [Source: DESIGN-SPEC.md §4] — Portfolio max-width 920px, section padding 44px
- [Source: 3-2-build-block-meta-confidence-partials.md] — confidence-bar.html interface

### References

- [Source: _bmad-output/planning-artifacts/epics.md — Story 4.2 AC]
- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md §6 — Pattern card spec]
- [Source: _bmad-output/implementation-artifacts/3-4-build-post-list-post-detail-pages.md] — Layout pattern from posts (single.html structure)
- [Source: _bmad-output/implementation-artifacts/3-2-build-block-meta-confidence-partials.md] — confidence-bar.html dict interface

## Dev Agent Record

### Agent Model Used

claude-sonnet-4-6

### Debug Log References

None — clean implementation, no issues.

### Completion Notes List

- Implemented `pattern-card.html` with full dict context pattern, all optional field guards, DESIGN-SPEC color tokens, and confidence bar reuse from Story 3.2.
- Note: Mini constellation SVG deferred (Phase 0 simplification per story Dev Notes). Confidence bar covers the essential visual.
- `list.html` uses responsive 2-col grid (md:grid-cols-2), graceful empty state, and h1 page title in header.
- `single.html` renders confidence bar, meta row (blockCount · timespan · trajectory in --convergence), linked tag pills, body content, and "← Patterns" back link.
- All optional fields wrapped with `{{ with }}` guards throughout.
- `pnpm run test` passes: 49 pages built in 144ms, no errors.

### File List

- layouts/partials/pattern-card.html (new)
- layouts/patterns/list.html (new)
- layouts/patterns/single.html (new)

### Code Review Fixes Applied (2026-02-27)

1. **Confidence bar height correction (CRITICAL)** — Changed `h-1` (4px) to `height: 3px` inline style to match DESIGN-SPEC §6.5 spec
2. **Section heading consistency (MEDIUM)** — Replaced `<h1>` in patterns/list.html with `section-heading.html` partial to match patterns established in Story 3.4 (posts list)
3. **Separator logic consistency (MEDIUM)** — Fixed pattern card meta separators to check all three fields (blockCount, timespan, trajectory) consistently before rendering `·` dividers
4. **Description truncation (MEDIUM)** — Added `line-clamp-3` to pattern card description to prevent text overflow in 2-column grid layout
5. **Empty state styling (LOW)** — Improved empty patterns list message with centered layout and lighter styling (`text-tertiary`, italic) to differentiate from content instructions

**Status:** All fixes applied and tested. `pnpm run test` passes: 49 pages, 72ms, 0 errors.

### Change Log

- 2026-02-27: Code review complete—5 issues fixed, all ACs validated ✅
- 2026-02-27: Implemented pattern-card partial and patterns list/single layouts (Story 4.2)
