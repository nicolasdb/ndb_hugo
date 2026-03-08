# Story 5.3: Seed Real Posts & Evidence Trails (ndb_hugo Documentation First)

Status: ready-for-dev

## Story

As a **portfolio owner**,
I want 2-3 real posts published with evidence trails, starting with a post that documents ndb_hugo itself,
So that the portfolio demonstrates the knowledge-first approach with authentic content AND the architecture is validated end-to-end through documentation.

## Acceptance Criteria

**Technical ACs:**

1. At least 2 new posts exist as page bundles in `content/posts/` (beyond the one from Epic 3 Story 3.5)
2. The first new post documents ndb_hugo's content architecture: frontmatter schemas, evidence.yaml format, pattern/timeline models, homepage assembly
3. Each new post has populated core and block frontmatter fields with real data (not placeholder values)
4. At least 2 posts have `evidence.yaml` sidecars with real block entries (minimum 3 blocks each)
5. Posts appear on the post list page (`/posts/`) and homepage "Latest Posts" section
6. Evidence trails expand/collapse correctly on each post detail page
7. The content demonstrates variety: different block counts, timespans, confidence levels across posts
8. `pnpm run test` passes

**Content/Author Attention Points:**

- The ndb_hugo documentation post reads like a genuine technical reference — someone unfamiliar with the system should understand it
- Evidence blocks in `evidence.yaml` are real dated events from the project (Epics 1-4 milestones), not fabricated
- Confidence scores are honest: 78-85 for battle-tested patterns, lower for evolving ones
- The post body connects to the reader: "here's why this architecture matters" not just "here's what it does"

## Tasks / Subtasks

- [ ] Create the ndb_hugo documentation post (AC: 1, 2, 3, 4)
  - [ ] Scaffold: `hugo new content posts/ndb-hugo-architecture`
  - [ ] File: `content/posts/ndb-hugo-architecture/index.md`
  - [ ] File: `content/posts/ndb-hugo-architecture/evidence.yaml`
  - [ ] Write comprehensive post body (see Dev Notes for outline)
  - [ ] Frontmatter: title, date, description, tags, categories, blockCount, timespan, confidence, patterns (link to relevant patterns)
  - [ ] evidence.yaml: at least 3 real blocks from Epics 1-4 milestones with dates and color semantics

- [ ] Create a second real post (AC: 1, 3, 4, 7)
  - [ ] Topic: something Nicolas has actually built or learned (not ndb_hugo itself — different subject)
  - [ ] Examples: container orchestration journey, evidence-first engineering approach, the knowledge graph vision
  - [ ] Scaffold: `hugo new content posts/{slug}`
  - [ ] Frontmatter: different confidence + blockCount + timespan from post 1 (demonstrate variety)
  - [ ] evidence.yaml: at least 3 real blocks

- [ ] Verify post rendering (AC: 5, 6)
  - [ ] `/posts/` — both posts appear in list with block metadata visible
  - [ ] `/` (homepage) — "Latest Posts" section shows new posts
  - [ ] Post detail pages: confidence bar, block-meta, collapsible evidence trail all render
  - [ ] Evidence trail expands/collapses correctly (Alpine.js)

- [ ] Run `pnpm run test` (AC: 8)

## Dev Notes

### ndb_hugo Documentation Post — Detailed Outline

**Why this post matters (Epic 4 Retro Decision):**
> "The first real post documents the ndb_hugo system — writing this post confronts every architectural assumption and validates the content pipeline. The resulting schemas become source material for a reusable backend-frontend contract skill (post-Phase 0)."

**Suggested structure for `content/posts/ndb-hugo-architecture/index.md`:**

```markdown
---
title: "ndb_hugo: A Knowledge-First Portfolio Architecture"
date: 2026-03-07
description: "How this portfolio models skills as evidence, not claims — and why that distinction matters for building a trustworthy knowledge system."
tags: ["hugo", "architecture", "knowledge-systems", "ndb"]
categories: ["Technical"]
draft: false
blockCount: 12
timespan: "December 2025 – March 2026"
confidence: 85
patterns: ["manual-content-publishing"]
---

## The Problem with Portfolio Sites

[Why standard portfolios fail to demonstrate actual capability]

## Three Content Types, One Evidence Model

[Overview of posts, patterns, timeline — and how they connect]

### Post Bundles

[index.md + evidence.yaml — the page bundle pattern. Frontmatter schema with all fields.]

### evidence.yaml Format

[Schema documentation. Color semantics: fresh/pattern/convergence/depth. Example entry.]

### Pattern Content Type

[Leaf files at content/patterns/. Frontmatter: confidence, blockCount, timespan, trajectory, featuredOnHomepage]

### Timeline Moments

[Leaf files at content/timeline/. Frontmatter: year, color, quote, linkedPost, featuredOnHomepage]

## Homepage Assembly

[How index.html queries featured patterns and timeline moments. The fallback logic.]

## The Backend-Frontend Contract

[How these schemas will become the contract for ndb_backoffice. The bridge is git-commit.]

## What Comes Next

[Phase 1: ndb_backoffice uploads to this portfolio via git. The schemas above are the API.]
```

**evidence.yaml for this post — real Epic milestones:**

```yaml
blocks:
  - date: 2025-12-01
    color: fresh
    content: "Started ndb_hugo-tailbliss. First question: how do you make skills visible without self-assessment? Answer: evidence trails."

  - date: 2026-02-07
    color: pattern
    content: "Architecture locked. Post bundles with evidence.yaml sidecars. Pattern + Timeline as separate content sections. The contract is defined before any UI exists."

  - date: 2026-02-14
    color: fresh
    content: "First archetype created. hugo new content posts/{slug} scaffolds the entire evidence structure in one command."

  - date: 2026-02-18
    color: pattern
    content: "Evidence trail partial built. YAML sidecar becomes a collapsible timeline of dated insight. The content model works."

  - date: 2026-02-26
    color: convergence
    content: "Pattern content section live. Skills modeled as evidence clusters, not self-described levels."

  - date: 2026-03-04
    color: convergence
    content: "Homepage wired: posts + patterns + timeline visible together. The knowledge-first narrative is visible."

  - date: 2026-03-07
    color: depth
    content: "Writing this post. Documenting the architecture while using it. The system is eating itself, in the best way."
```

### Frontmatter Schema Reference

For dev agent use — the complete post frontmatter schema:

```yaml
---
title: ""
date: YYYY-MM-DD       # Must be past or current date — future dates don't publish
description: ""
tags: []
categories: []
draft: false
# Block fields (optional but recommended for real posts)
blockCount: 0          # Number of evidence blocks in evidence.yaml
timespan: ""           # Human-readable: "Month YYYY – Month YYYY"
confidence: 0          # 0-100 integer
patterns: []           # Slugs of related patterns (e.g., ["manual-content-publishing"])
---
```

### evidence.yaml Schema Reference

```yaml
blocks:
  - date: YYYY-MM-DD
    color: fresh|pattern|convergence|depth  # semantic color tokens
    content: "Dated event description — what happened, what was learned"
```

Color semantics:
- `fresh` — new insight, unvalidated, recent discovery
- `pattern` — structural, reliable, confirmed through use
- `convergence` — intersecting skills, where different things came together
- `depth` — deep mastery, long-cultivated

### Post-Story Value: Backend Contract Skill

From Epic 4 Retro: the schemas documented in this post (frontmatter, evidence.yaml, pattern/timeline models) become source material for the `ndb_hugo content schemas` skill (post-Phase 0). The backend-frontend contract is:
- Backend (ndb_backoffice) outputs files matching these schemas
- Frontend (ndb_hugo) renders them without an API
- The bridge is a git commit

Keep the schema documentation in this post precise and complete — it will be copied into that skill.

### Existing Post from Story 3.5

Story 3.5 created one post (slug unknown — check `content/posts/`). This story adds 2+ more posts. The existing post does NOT need modification unless a bug is found.

### Architecture Compliance

- [Source: epics.md §Story 5.3 — dual acceptance criteria]
- [Source: epics.md §D1.1] — Post frontmatter schema with core + optional block fields; evidence trail as page bundle sidecar (evidence.yaml)
- [Source: epics.md §NFR-3] — Evidence-based: every skill claim links to documented outcomes
- [Source: 3-5-create-first-real-post-with-evidence-trail.md — evidence of quality bar set in Epic 3]
- [Source: epic-4-retro-2026-03-07.md §5.3 refocus decision] — ndb_hugo documentation as first post

### Hugo Pattern: Page Bundle

Posts MUST be page bundles (not single .md files):
```
content/posts/{slug}/
  index.md       ← post content + frontmatter
  evidence.yaml  ← evidence sidecar (optional but present for real posts)
```

NOT `content/posts/{slug}.md` — that breaks the page bundle pattern and `evidence.yaml` sidecar lookup.

### Project Structure Notes

New files:
- `content/posts/ndb-hugo-architecture/index.md`
- `content/posts/ndb-hugo-architecture/evidence.yaml`
- `content/posts/{slug-2}/index.md`
- `content/posts/{slug-2}/evidence.yaml`

No template changes needed — all templates built in Epics 3-4.

### References

- [Source: epics.md §Story 5.3 — Seed Real Posts & Evidence Trails]
- [Source: epic-4-retro-2026-03-07.md §Decisions — Story 5.3 refocused to ndb_hugo system docs]
- [Source: 4-5-seed-meta-content-for-template-verification.md §Completion Notes — existing content state]
- [Source: backlog.md — ndb_hugo content schemas skill planned post-Phase 0]

## Dev Agent Record

### Agent Model Used

*Recommended: claude-sonnet-4-6 — technical documentation post requires clear, precise writing*
*Note: Nicolas is hands-on for content quality. Storytelling agent may assist with narrative shaping.*

### Debug Log References

### Completion Notes List

### File List
