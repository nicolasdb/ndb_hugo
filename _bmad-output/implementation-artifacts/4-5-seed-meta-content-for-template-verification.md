# Story 4.5: Seed Meta-Content for Template Verification & Authoring Documentation

Status: ready-for-dev

## Story

As a **portfolio owner**,
I want sample content that documents the manual content publishing workflow itself,
So that templates are verified with genuinely useful content AND I have authoring reference material that survives into Epic 5.

## Acceptance Criteria

1. A pattern file exists at `content/patterns/manual-content-publishing.md` documenting the Hugo authoring workflow (drafting posts, writing evidence.yaml, creating patterns, adding timeline moments)
2. At least 1 additional pattern file exists in `content/patterns/` with `featuredOnHomepage: true` *(at least 1 of the existing 3 patterns already upgraded in Story 4.1 should have this set)*
3. At least 3 timeline moment files exist in `content/timeline/` using real project milestones (e.g., "first archetype created", "first evidence trail rendered", "first pattern documented")
4. At least 1 pattern has `featuredOnHomepage: true` and appears on the homepage
5. At least 1 timeline moment has `featuredOnHomepage: true` and appears on the homepage
6. Pattern detail pages render correctly with all fields (`/patterns/manual-content-publishing/`)
7. Timeline list page (`/timeline/`) displays moments in chronological order
8. `pnpm run test` passes

## Tasks / Subtasks

- [ ] Create `content/patterns/manual-content-publishing.md` (AC: 1, 6)
  - [ ] Full frontmatter: title, description, confidence, blockCount, timespan, trajectory, tags, featuredOnHomepage
  - [ ] Body: document the Hugo manual publishing workflow step-by-step
  - [ ] This IS real content AND documentation — write it with care

- [ ] Verify at least 1 existing pattern has `featuredOnHomepage: true` (AC: 2, 4)
  - [ ] Check patterns upgraded in Story 4.1 — if none have `featuredOnHomepage: true`, set it on the most relevant one (recommend: `container-orchestration` as it's linked from docker-journey)
  - [ ] Verify the homepage pattern section shows it

- [ ] Verify timeline moments cover real milestones from Epics 1-3 (AC: 3, 5)
  - [ ] Check existing 5 timeline files upgraded in Story 4.3 — do they cover real project milestones?
  - [ ] If needed, add timeline moments for: "first archetype created" (Epic 3.1), "first evidence trail rendered" (Epic 3.3), "first pattern documented" (this story)
  - [ ] Ensure at least 1 timeline moment has `featuredOnHomepage: true`

- [ ] Validate templates end-to-end (AC: 6, 7)
  - [ ] Navigate to `/patterns/` — pattern list shows cards
  - [ ] Navigate to `/patterns/manual-content-publishing/` — detail page renders all fields
  - [ ] Navigate to `/timeline/` — moments in chronological order
  - [ ] Navigate to `/` — featured pattern + timeline moment appear on homepage
  - [ ] `pnpm run test` passes (AC: 8)

## Dev Notes

### Meta-Content Approach (Epic 3 Retro Decision)

**This is the most important design decision for this story.** From the Epic 3 Retrospective:

> "The first pattern documents the manual content publishing workflow itself — both a test fixture AND authoring documentation. Dog-fooding the content model."

The `manual-content-publishing` pattern should document:
1. **How to draft a new post** — `hugo new content posts/{slug}`, fill frontmatter, write body
2. **How to write evidence.yaml** — schema, color semantics, chronological order
3. **How to create a pattern** — `hugo new content patterns/{slug}`, frontmatter fields
4. **How to add a timeline moment** — `hugo new content timeline/{slug}`, quote writing
5. **How to publish** — `git add`, commit, push to main → Netlify rebuilds

This document will survive into Epic 5 as real authoring documentation. It is NOT throwaway.

### `manual-content-publishing` Pattern Frontmatter

```yaml
---
title: "Manual Content Publishing"
date: 2026-02-26
draft: false
description: "The Hugo-native workflow for authoring posts, patterns, and timeline moments. Manual precision while the backoffice is being built."
tags: ["hugo", "workflow", "authoring"]
confidence: 78
blockCount: 8
timespan: "December 2025 – February 2026"
trajectory: rising
featuredOnHomepage: true
---
```

**Confidence 78:** Solid workflow, actively using it. Not 85+ because it's still being refined as the backoffice takes shape.

### Pattern Body Content Structure

The body of `manual-content-publishing.md` should be a genuine reference document:

```markdown
## The Content Stack

Three content types, three workflows. Each backed by the same evidence model.

## Creating a Post

```bash
hugo new content posts/{slug}
```

This scaffolds `content/posts/{slug}/index.md` and `evidence.yaml`...

## Writing evidence.yaml

Each block represents a dated event...

## Creating a Pattern

Patterns emerge from evidence density across posts...

## Adding Timeline Moments

Timeline moments are the inflection points...

## Publishing

```bash
git add content/
git commit -m "Add: {post/pattern/moment title}"
git push
```

Netlify triggers on push to main. Build completes in ~30 seconds.
```

Write this as you would want to read it 6 months from now when returning to this workflow.

### Timeline Moments from Real Milestones

Epics 1-3 provide authentic milestones for new timeline moments. If the existing 5 files don't cover these, create additional ones:

| Milestone | Suggested date | Color | Quote |
|-----------|---------------|-------|-------|
| First archetype created | 2026-02-14 | fresh | "A single `hugo new content` command scaffolds the entire evidence structure. The friction disappears." |
| First evidence trail rendered | 2026-02-18 | pattern | "The dots connected — literally. A YAML file becomes a collapsible timeline of dated insight." |
| First pattern documented | 2026-02-26 | convergence | "Writing a pattern about the act of writing patterns. The system is eating itself, in the best way." |

Set at least one of these with `featuredOnHomepage: true`.

### Verification Checklist

After creating all content, verify the full homepage renders without errors:

| Check | Expected |
|-------|---------|
| `/patterns/` list | Shows all patterns as cards with confidence bars |
| `/patterns/manual-content-publishing/` | Full detail renders: description, confidence bar, meta row |
| `/timeline/` | All moments in date order, color dots visible |
| `/` homepage patterns section | At least 1 featured pattern card visible |
| `/` homepage timeline section | At least 1 timeline moment visible |
| Hugo build | N pages, 0 errors |

### Architecture Compliance

- [Source: epics.md §4.5 — Meta-content approach, Epic 3 Retro Decision]
- [Source: epics.md §D1.2] — Pattern files are leaf files
- [Source: NFR-3] — Evidence-based: every skill claim links to documented outcomes
- [Source: DESIGN-SPEC.md §3] — confidence: 78 → convergence (amber), honest scoring

### References

- [Source: _bmad-output/planning-artifacts/epics.md — Story 4.5 meta-content AC]
- [Source: _bmad-output/implementation-artifacts/epic-3-retro-2026-02-26.md — Meta-content decision]
- [Source: _bmad-output/implementation-artifacts/3-5-create-first-real-post-with-evidence-trail.md — Content quality bar]

## Dev Agent Record

### Agent Model Used

*Recommended: claude-haiku-4-5-20251001 — structured content seeding (but with the meta-content body requiring thoughtful writing)*

### Debug Log References

### Completion Notes List

### File List
