# Story 3.2: Build Block Meta & Confidence Partials

Status: ready-for-dev

## Story

As a **portfolio visitor**,
I want to see block metadata (block count, timespan, patterns, confidence) on posts that have it,
So that I understand the evidence backing each post.

## Acceptance Criteria

1. `layouts/partials/block-meta.html` renders optional block fields using `{{ with }}` / `{{ if }}` guards
2. The partial displays block count, timespan, linked patterns, and confidence when present
3. The partial renders nothing when block fields are absent (graceful degradation — no empty wrapper divs)
4. `layouts/partials/confidence-bar.html` renders a visual confidence indicator from `.Params.confidence`
5. The confidence bar renders nothing when confidence is absent
6. Both partials use design token colors and Tailwind utilities only (no custom CSS for layout)
7. Both partials are called with `dict` context (not `.`) to support reuse from any template
8. `pnpm run test` passes
9. **Visual validation:** render locally and confirm partials display correctly on a post that has block fields; verify clean render on a post without block fields

## Tasks / Subtasks

- [ ] Build `layouts/partials/confidence-bar.html` (AC: 4, 5, 6, 7)
  - [ ] Accept context via dict: `(dict "confidence" .Params.confidence)`
  - [ ] Render nothing if confidence is 0 or absent
  - [ ] Render a filled bar proportional to value (0–100) using design token `--pattern` or threshold colors
  - [ ] Display numeric value in mono font alongside bar
  - [ ] Use Tailwind utilities for bar width (`style` attribute with inline width % is acceptable here)

- [ ] Build `layouts/partials/block-meta.html` (AC: 1, 2, 3, 6, 7)
  - [ ] Accept context via dict: `(dict "page" .)`
  - [ ] Wrap entire output in `{{ if or .blockCount .timespan .patterns .confidence }}` — renders nothing if all absent
  - [ ] Render blockCount with block icon/label when present (`{{ with .page.Params.blockCount }}`)
  - [ ] Render timespan with label when present
  - [ ] Render linked patterns as list/pills when present
  - [ ] Include `confidence-bar.html` partial inline when confidence present
  - [ ] Use mono font, design token text colors (`--text-tertiary`, `--text-secondary`)
  - [ ] Use `--block`, `--pattern`, `--temporal` semantic colors per DESIGN-SPEC §3

- [ ] Write isolated test fixture (AC: 9)
  - [ ] Add block fields to one of the converted sample posts (`docker-journey/index.md`)
  - [ ] Render `pnpm run dev:watch` and visually verify block-meta appears on that post
  - [ ] Verify other post (no block fields) renders cleanly without any block-meta output

- [ ] Build validation (AC: 8)
  - [ ] `pnpm run test` passes

## Dev Notes

### Mechanics-First Principle

Story 2.6 established the visual shell. This story builds partials that **slot into** the existing design without altering it. Do not change spacing, typography, or color decisions from `_default/single.html`. The block-meta and confidence-bar output must integrate naturally as additional metadata below the existing date/reading-time row in the post header.

### Confidence Bar — Color Thresholds

From DESIGN-SPEC §3 (Confidence Thresholds):

| Range | Color token | Meaning |
|-------|-------------|---------|
| 0–39  | `--frontier` | Exploratory, low signal |
| 40–69 | `--convergence` | Developing, moderate signal |
| 70–89 | `--pattern` | Strong, emerging pattern |
| 90–100 | `--fresh` | High confidence, strong evidence |

The confidence bar should use the appropriate semantic color based on threshold, not a fixed color.

### Partial Interface Contracts

```
{{/* confidence-bar.html */}}
{{/* Call: {{ partial "confidence-bar.html" (dict "confidence" .Params.confidence) }} */}}
{{ $c := .confidence }}
{{ if $c }}
  ... render bar ...
{{ end }}
```

```
{{/* block-meta.html */}}
{{/* Call: {{ partial "block-meta.html" (dict "page" .) }} */}}
{{ $p := .page.Params }}
{{ if or $p.blockCount $p.timespan $p.patterns $p.confidence }}
  ... render block metadata ...
{{ end }}
```

### Integration Point in Post Header

The block-meta partial will be inserted in `layouts/posts/single.html` (created in story 3-4) **below** the existing date/tags row in the header. Do not modify `_default/single.html` — the posts-specific layout is created in 3-4.

For visual testing purposes (before 3-4 exists), temporarily test by calling the partial inline — or wait and test as part of 3-4's work. Either approach is valid.

### Test Fixture: Add Block Fields to docker-journey

To verify rendering, update `content/posts/docker-journey/index.md` frontmatter:

```yaml
blockCount: 7
timespan: "March 2024 – January 2025"
patterns: ["container-orchestration"]
confidence: 72
```

This provides a realistic data set for visual validation. Remove after testing if desired, or keep as sample data for Epic 5 replacement.

### Architecture Compliance

- [Source: epics.md §Additional Requirements — D1.1] — `block-meta.html` as shared renderer with template guards
- [Source: epics.md §Additional Requirements — D1.1] — Naming conventions: kebab-case partials, camelCase frontmatter
- [Source: epics.md §Additional Requirements — D1.1] — `{{ with }}`/`{{ if }}` guards for ALL optional block fields
- [Source: DESIGN-SPEC.md§3] — Semantic colors for block system
- [Source: DESIGN-SPEC.md§3] — Confidence thresholds

### Visual Validation Checklist

Before marking done, manually verify:
- [ ] Post WITH block fields: block-meta section appears, confidence bar renders with correct color
- [ ] Post WITHOUT block fields: no block-meta output, no empty divs or visual gaps
- [ ] Confidence bar width correctly proportional to value
- [ ] Mono font used for all metadata labels and values
- [ ] Design token colors used (inspect: `var(--text-tertiary)`, `var(--pattern)`, etc.)
- [ ] No layout breakage to existing header spacing (`pt-12 md:pt-[68px]` preserved)

### Project Structure Notes

**New files this story:**
```
layouts/partials/
  confidence-bar.html    ← NEW
  block-meta.html        ← NEW
```

No existing files modified (partials are called from future layouts/posts/ templates in 3-4).

### References

- [Source: _bmad-output/planning-artifacts/epics.md — Story 3.2 AC]
- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md§3 — Confidence thresholds, semantic colors]
- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md§2 — Typography: mono font for metadata]
- [Source: layouts/_default/single.html — Existing header structure to integrate with]

## Dev Agent Record

### Agent Model Used

claude-sonnet-4-6

### Debug Log References

### Completion Notes List

### File List
