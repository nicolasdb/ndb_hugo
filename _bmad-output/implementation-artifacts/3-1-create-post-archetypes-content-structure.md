# Story 3.1: Create Post Archetypes & Content Structure

Status: ready-for-dev

## Story

As a **portfolio owner**,
I want a post archetype that scaffolds page bundles with evidence sidecars,
So that every new post is created with the correct structure from the start.

## Acceptance Criteria

1. `archetypes/posts/index.md` exists with all core frontmatter fields (`title`, `date`, `description`, `tags`, `categories`, `draft`)
2. The archetype includes optional block fields (`blockCount`, `timespan`, `patterns`, `confidence`)
3. `archetypes/posts/evidence.yaml` exists as an empty sidecar template with example structure commented out
4. Running `hugo new content posts/test-post` creates a page bundle directory with both files
5. `content/posts/_index.md` exists as the posts list page config (already exists — verify it is correct)
6. Existing flat posts (`docker-journey.md`, `sewer-museum-valve-controller.md`) are converted to page bundles (`docker-journey/index.md`, `sewer-museum-valve-controller/index.md`) with placeholder `evidence.yaml` sidecars
7. `pnpm run test` passes

## Tasks / Subtasks

- [ ] Create archetype directory structure (AC: 1, 2, 3, 4)
  - [ ] Create `archetypes/posts/` directory
  - [ ] Write `archetypes/posts/index.md` with core + optional block frontmatter
  - [ ] Write `archetypes/posts/evidence.yaml` with commented example structure
  - [ ] Verify `hugo new content posts/test-post` creates correct page bundle

- [ ] Verify `content/posts/_index.md` (AC: 5)
  - [ ] Check existing `_index.md` has correct frontmatter (title, description)
  - [ ] Update if needed

- [ ] Convert existing flat posts to page bundles (AC: 6)
  - [ ] Convert `content/posts/docker-journey.md` → `content/posts/docker-journey/index.md`
  - [ ] Add placeholder `content/posts/docker-journey/evidence.yaml`
  - [ ] Convert `content/posts/sewer-museum-valve-controller.md` → `content/posts/sewer-museum-valve-controller/index.md`
  - [ ] Add placeholder `content/posts/sewer-museum-valve-controller/evidence.yaml`
  - [ ] Verify Hugo still resolves posts correctly after conversion

- [ ] Build validation (AC: 7)
  - [ ] Run `pnpm run test` — confirm all pages still render (should be 49+ pages)
  - [ ] Verify post list page still displays both sample posts

## Dev Notes

### Critical Context: Flat Posts Must Become Page Bundles

**Story 2.6 created placeholder posts as flat `.md` files.** The architecture (D1.1) requires posts to be **page bundles** (directories with `index.md` + `evidence.yaml` sidecar). This story must convert those files as part of establishing the correct content structure.

Existing flat posts to convert:
- `content/posts/docker-journey.md` → `content/posts/docker-journey/index.md`
- `content/posts/sewer-museum-valve-controller.md` → `content/posts/sewer-museum-valve-controller/index.md`

Hugo resolves both formats equally — the URL slug is unchanged. No template changes needed.

### Archetype Frontmatter Schema

`archetypes/posts/index.md` should contain:

```yaml
---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
date: {{ .Date }}
description: ""
tags: []
categories: []
draft: true

# Optional block fields (delete if not applicable)
# blockCount: 0          # Number of knowledge blocks backing this post
# timespan: ""           # e.g., "3 months", "2022–2024"
# patterns: []           # Linked skill patterns (slugs)
# confidence: 0          # 0–100 confidence score
---
```

### Evidence Sidecar Schema

`archetypes/posts/evidence.yaml` — commented example structure:

```yaml
# Evidence trail for this post.
# Each entry is a knowledge block that contributed to this insight.
# Uncomment and fill in when publishing with evidence backing.

# blocks:
#   - date: "2024-01-15"
#     color: fresh          # fresh | convergence | pattern | temporal | frontier | block
#     content: "Discovered that Docker overlay networks isolate by default..."
#   - date: "2024-02-03"
#     color: convergence
#     content: "Old insight from 2022 became relevant: subnets matter for container DNS..."
```

### Architecture Compliance

- **D1.1** (Architecture): Post frontmatter schema — core + optional block fields; evidence trail as page bundle sidecar (`evidence.yaml`); archetypes for page bundles
- **D1.3** (Architecture): Image handling via `imgc` shortcode (not relevant for this story, but archetype should not hardcode images)
- Posts as page bundles: `content/posts/{slug}/index.md` + `content/posts/{slug}/evidence.yaml`
- Content file convention: kebab-case slugs

### Project Structure Notes

**Existing state (after 2.6):**
```
archetypes/
  default.md                          ← Hugo default, leave untouched
content/posts/
  _index.md                           ← Already exists
  docker-journey.md                   ← FLAT — must convert to bundle
  sewer-museum-valve-controller.md    ← FLAT — must convert to bundle
```

**Target state (after this story):**
```
archetypes/
  default.md
  posts/
    index.md                          ← NEW: archetype with core + block frontmatter
    evidence.yaml                     ← NEW: evidence sidecar template
content/posts/
  _index.md                           ← Verify/retain
  docker-journey/
    index.md                          ← CONVERTED from flat file
    evidence.yaml                     ← NEW: empty/placeholder
  sewer-museum-valve-controller/
    index.md                          ← CONVERTED from flat file
    evidence.yaml                     ← NEW: empty/placeholder
```

### Previous Story Intelligence (2.6)

Story 2.6 seeded the site with placeholder content including sample posts. Key patterns established:
- Typography stack: Literata / Hanken Grotesk / Commit Mono
- Spacing hierarchy: `py-12 md:py-16` hero, `py-8 md:py-12` sections, `p-4 md:p-6` cards
- `layouts/_default/single.html` and `layouts/_default/list.html` are already in place (generic Hugo defaults, not posts-specific yet — posts-specific layouts come in Story 3.4)
- Sample post frontmatter used in 2.6 likely does NOT include block fields — that is fine; this story adds them to the archetype for future posts

### Git Intelligence

Recent commits:
- `5ae5823b` — story 2.6 completed (visual polish, placeholder content seeded)
- `ab98d470` — 2.5 code review complete (pearl→block rename)
- `9ce43c30` — add logo on navbar - for ref

The `pearl→block` rename was completed in story 2.5. All future naming uses "block" terminology.

### Block Field Color Reference

Evidence trail `color` values come from DESIGN-SPEC §3:
- `fresh` — green (oklch 145°) — new capture, strong signal
- `convergence` — amber (oklch 75°) — old idea meets new work
- `pattern` — coral (oklch 25°) — skill pattern highlighted
- `temporal` — blue (oklch 240°) — time markers
- `frontier` — gray (oklch 260°) — unexplored, quiet
- `block` — neutral warm (oklch 90°) — raw knowledge block

[Source: DESIGN-SPEC.md§3 — Semantic Colors / The Block System]

### Testing Strategy

1. After creating archetypes: `hugo new content posts/test-post` and verify it creates `content/posts/test-post/index.md` + `content/posts/test-post/evidence.yaml`
2. After converting flat posts: `pnpm run test` — Hugo must still find and render both sample posts
3. Navigate to `/posts/` in dev server — both posts must appear in list

### References

- [Source: _bmad-output/planning-artifacts/epics.md — Story 3.1 AC]
- [Source: _bmad-output/planning-artifacts/architecture.md — D1.1 post frontmatter schema]
- [Source: _bmad-output/implementation-artifacts/DESIGN-SPEC.md§3 — Block system colors]
- [Source: _bmad-output/implementation-artifacts/2-6-visual-polish-close-mockup-gap.md — File List, existing flat posts]

## Dev Agent Record

### Agent Model Used

claude-sonnet-4-6

### Debug Log References

### Completion Notes List

### File List
