# Story 4.1: Create Pattern Content Section & Archetype

Status: done

## Story

As a **portfolio owner**,
I want a patterns content section with a proper archetype,
So that I can create skill pattern pages with consistent frontmatter structure.

## Acceptance Criteria

1. `content/patterns/_index.md` exists as the patterns list page config *(already exists — verify it has correct frontmatter)*
2. `archetypes/patterns.md` exists with all pattern frontmatter fields (`title`, `description`, `confidence`, `blockCount`, `timespan`, `trajectory`, `tags`, `featuredOnHomepage`)
3. Pattern files are leaf files at `content/patterns/{slug}.md` (not page bundles)
4. Running `hugo new content patterns/test-pattern` creates a correctly structured file
5. `hugo.yaml` is updated with patterns section in site menu if not already present
6. The 3 existing pattern files (`commons-governance.md`, `container-orchestration.md`, `electronics-iot-prototyping.md`) are upgraded with the new frontmatter fields (real values, not placeholders)
7. `pnpm run test` passes

## Tasks / Subtasks

- [x] Verify `content/patterns/_index.md` (AC: 1)
  - [x] Check current content — file exists, confirm frontmatter is appropriate for list page config

- [x] Create `archetypes/patterns.md` (AC: 2)
  - [x] Include all fields: `title`, `description`, `confidence`, `blockCount`, `timespan`, `trajectory`, `tags`, `featuredOnHomepage`
  - [x] Add commented guidance for each field (e.g., `# trajectory: rising|stable|converging`)
  - [x] Set `draft: true` as default

- [x] Upgrade existing pattern files with new frontmatter (AC: 6)
  - [x] `content/patterns/commons-governance.md` — add `confidence`, `blockCount`, `timespan`, `trajectory`, `featuredOnHomepage` with real values
  - [x] `content/patterns/container-orchestration.md` — same (this pattern is already linked from docker-journey post)
  - [x] `content/patterns/electronics-iot-prototyping.md` — same

- [x] Verify archetype works (AC: 3, 4)
  - [x] Run `hugo new content patterns/test-pattern` — verify correct file created at leaf path
  - [x] Delete the test file after verification

- [x] Update `hugo.yaml` if needed (AC: 5)
  - [x] Check if Patterns nav link already in menu — add if missing

- [x] Run `pnpm run test` (AC: 7)

## Dev Notes

### Critical: Content Already Exists — Do NOT Recreate

`content/patterns/_index.md` already exists. **Do not recreate or overwrite it.** Verify it has appropriate list page config frontmatter and leave it as-is if correct.

Three pattern files already exist with PARTIAL frontmatter — they have `title`, `date`, `draft`, `description`, `tags` but LACK:
- `confidence` (integer, 0–100)
- `blockCount` (integer)
- `timespan` (string, e.g., `"2014 – present"`)
- `trajectory` (string: `rising`, `stable`, or `converging`)
- `featuredOnHomepage` (bool, default false)

**Add these fields with real values** — do not use placeholder numbers. Use honest estimates:
- `commons-governance`: decade of fablab management → high confidence (80s), many blocks
- `container-orchestration`: docker-journey post has `confidence: 72` — use consistent value; this pattern IS the one linked from docker-journey via `patterns: ["container-orchestration"]`
- `electronics-iot-prototyping`: check existing file content for context

### Pattern Frontmatter Schema

```yaml
---
title: "Pattern Name"
date: YYYY-MM-DD
draft: false
description: "One sentence description."
tags: ["tag1", "tag2"]
confidence: 75          # 0–100, honest estimate, see DESIGN-SPEC §3 thresholds
blockCount: 12          # number of evidence blocks backing this pattern
timespan: "2019 – 2024" # duration of demonstrated skill
trajectory: rising      # rising | stable | converging
featuredOnHomepage: false
---
```

### Archetype Location Convention

From Architecture (D1.2): "Pattern and Timeline as Hugo content sections with dedicated archetypes." Pattern files are **leaf files** (not page bundles — no directory with index.md). This differs from posts which are page bundles.

```
content/patterns/
  _index.md                  ← list page config (ALREADY EXISTS)
  commons-governance.md      ← leaf file (ALREADY EXISTS, needs frontmatter upgrade)
  container-orchestration.md ← leaf file (ALREADY EXISTS, needs frontmatter upgrade)
  electronics-iot-prototyping.md ← leaf file (ALREADY EXISTS, needs frontmatter upgrade)
```

Archetype at: `archetypes/patterns.md` (Hugo uses `{section}.md` for leaf archetypes)

### Confidence Thresholds (DESIGN-SPEC §3)

| Range | Color | Semantic |
|-------|-------|----------|
| 85%+  | `--fresh` (green) | Strong, well-evidenced |
| 70–84% | `--convergence` (amber) | Solid, growing |
| <70% | `--temporal` (blue) | Emerging, needs more evidence |

Use these thresholds when assigning confidence to existing patterns.

### Hugo Menu Check

In `hugo.yaml`, look for menu items. Nav was built in Story 2.2 to include: Home, Posts, Patterns, Timeline, About. If Patterns is already wired, no change needed. If missing, add:

```yaml
menus:
  main:
    - name: Patterns
      url: /patterns/
      weight: 20
```

### Architecture Compliance

- [Source: epics.md §D1.2] — Pattern files are leaf files (not page bundles)
- [Source: epics.md §D1.2] — Dedicated archetypes for each section
- [Source: DESIGN-SPEC.md §3] — Confidence thresholds for honest scoring
- [Source: DESIGN-SPEC.md §6] — Pattern card fields: title, confidence, blockCount, timespan, trajectory

### References

- [Source: _bmad-output/planning-artifacts/epics.md — Story 4.1 AC]
- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md §3 — Confidence thresholds]
- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md §6 — Pattern card component spec]
- [Source: content/posts/docker-journey/index.md — patterns: ["container-orchestration"] linking]

## Dev Agent Record

### Agent Model Used

*Recommended: claude-sonnet-4-6 — frontmatter design + honest content value judgments*

### Debug Log References

None — implementation was straightforward.

### Completion Notes List

- `content/patterns/_index.md`: Verified existing file has appropriate list page config (`title`, `description`). No changes needed.
- `archetypes/patterns.md`: Created with all required fields (`title`, `date`, `draft`, `description`, `tags`, `confidence`, `blockCount`, `timespan`, `trajectory`, `featuredOnHomepage`) plus inline commented guidance for each field.
- `content/patterns/commons-governance.md`: Added `confidence: 85` (strong — decade of practice), `blockCount: 14`, `timespan: "2014 – present"`, `trajectory: stable`, `featuredOnHomepage: true`.
- `content/patterns/container-orchestration.md`: Added `confidence: 72` (consistent with docker-journey post), `blockCount: 8`, `timespan: "2021 – present"`, `trajectory: converging`, `featuredOnHomepage: false`.
- `content/patterns/electronics-iot-prototyping.md`: Added `confidence: 78` (solid, long history from satellite to ESP32), `blockCount: 11`, `timespan: "2009 – present"`, `trajectory: rising`, `featuredOnHomepage: true`.
- `hugo.yaml`: Patterns menu entry already present at weight 30. No change needed.
- Archetype verified: `hugo new content patterns/test-pattern.md` created a correct leaf file with all fields. Test file deleted.
- `pnpm run test`: Passed cleanly. 49 pages built in 122ms, no errors.

### File List

- `archetypes/patterns.md` (new)
- `content/patterns/commons-governance.md` (modified — frontmatter upgraded)
- `content/patterns/container-orchestration.md` (modified — frontmatter upgraded)
- `content/patterns/electronics-iot-prototyping.md` (modified — frontmatter upgraded)

### Code Review (2026-02-27)

**Summary:** Adversarial review found 2 Medium issues, both fixed automatically.

**Findings:**
- M1 (AC 2 Partial): Archetype guidance comments incomplete — missing comments for `title`, `date`, `draft`, `description`, `tags`, `featuredOnHomepage`. **FIXED**: Added inline comments explaining purpose and format expectations for all 9 fields.
- M2 (Content consistency): `_index.md` lacked `draft: false` field present in all pattern leaf files. **FIXED**: Added `draft: false` for consistency.

**Low-severity items (not fixed):**
- L1: Archetype `timespan` placeholder could ship as literal text — added note in comment to replace
- L2: Dev Notes had incorrect weight example (20 vs 30) — code was correct, docs had typo

**Verification:** All fixes applied. `pnpm run test` passes (49 pages, 91ms).

### Change Log

- 2026-02-27: Code review complete — 2 Medium issues fixed. Added comprehensive field guidance to archetype. Added `draft: false` to `_index.md`. Build verified.
- 2026-02-27: Created `archetypes/patterns.md` with full pattern frontmatter schema and inline guidance. Upgraded 3 existing pattern files with `confidence`, `blockCount`, `timespan`, `trajectory`, `featuredOnHomepage` fields using honest estimates. Verified `_index.md` and `hugo.yaml` menu required no changes.
