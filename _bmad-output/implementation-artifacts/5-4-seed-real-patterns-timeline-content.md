# Story 5.4: Seed Real Patterns & Timeline Content

Status: ready-for-dev

## Story

As a **portfolio owner**,
I want real skill patterns and timeline moments replacing the minimal samples,
So that the patterns gallery and timeline showcase authentic growth narrative.

## Acceptance Criteria

**Technical ACs:**

1. At least 3 pattern files exist in `content/patterns/` with real skill descriptions, confidence scores, and block counts
2. At least 5 timeline moment files exist in `content/timeline/` with real dates, quotes, and color indicators
3. At least 2 patterns have `featuredOnHomepage: true` and appear on the homepage pattern section
4. At least 3 timeline moments have `featuredOnHomepage: true` and appear on the homepage timeline section
5. Pattern detail pages render correctly with all fields
6. Timeline list page displays moments in chronological order
7. Sample/placeholder content from Epic 4 is reviewed — either upgraded to real content or replaced
8. `pnpm run test` passes

**Content/Author Attention Points:**

- Patterns represent real, demonstrable skill clusters — not aspirational or placeholder
- Confidence scores are honest: battle-tested patterns score 75-90, emerging patterns 40-65
- Timeline quotes are memorable and specific — capture the feeling of a real moment, not a bland description
- The `trajectory` field is meaningful: `rising` for actively growing, `stable` for proven, `emerging` for new
- The overall pattern gallery should tell a coherent story about Nicolas's skill profile

## Tasks / Subtasks

- [ ] Audit existing patterns (AC: 7)
  - [ ] List all files in `content/patterns/`
  - [ ] From Story 4.1: 3 patterns upgraded (check which ones — likely include `commons-governance`, `electronics-iot-prototyping`, one more)
  - [ ] From Story 4.5: `manual-content-publishing` added
  - [ ] Assess: which are real enough to keep? Which need upgrading? Are any purely placeholder?

- [ ] Audit existing timeline moments (AC: 7)
  - [ ] List all files in `content/timeline/`
  - [ ] From Story 4.3: 5 moments upgraded with year/color/quote/linkedPost
  - [ ] From Story 4.5: 3 new moments added (2026-first-archetype, 2026-evidence-trail-rendered, 2026-pattern-documented)
  - [ ] Total: ~8 timeline moments — are any purely placeholder needing replacement?

- [ ] Create/upgrade patterns to meet AC (AC: 1, 3, 5)
  - [ ] Ensure at least 3 patterns exist with full real frontmatter and body content
  - [ ] `manual-content-publishing` already good — carries forward
  - [ ] Existing patterns from 4.1 — do they have real content or minimal stubs? Upgrade if needed
  - [ ] Set `featuredOnHomepage: true` on the 2 strongest patterns
  - [ ] Pattern body: describe the skill cluster, how it emerged, why it matters

- [ ] Create/upgrade timeline moments to meet AC (AC: 2, 4, 6)
  - [ ] Ensure at least 5 moments with real dates and meaningful quotes
  - [ ] Existing 8 from Epics 4.3/4.5 likely cover this — verify quality
  - [ ] Set `featuredOnHomepage: true` on the 3 most impactful moments
  - [ ] Verify chronological order on `/timeline/` list page

- [ ] Verify homepage sections (AC: 3, 4)
  - [ ] Homepage pattern section shows 2+ featured pattern cards
  - [ ] Homepage timeline section shows 3+ featured timeline moments
  - [ ] All cards/moments render correctly (confidence bars, color dots, quotes)

- [ ] Run `pnpm run test` (AC: 8)

## Dev Notes

### Current Content State (from Story 4.5 Completion Notes)

**Patterns (4 total):**
- `manual-content-publishing.md` — confidence 78, blockCount 8, trajectory rising, featuredOnHomepage true
- `commons-governance.md` — confidence 85, blockCount 14, featuredOnHomepage true
- `electronics-iot-prototyping.md` — confidence 78, blockCount 11, featuredOnHomepage true
- One more pattern from Story 4.1 (check files)

**Timeline (8 total):**
- 5 from Story 4.3 (real project milestones pre-2026)
- `2026-first-archetype.md` — fresh color, 2026-02-14
- `2026-evidence-trail-rendered.md` — pattern color, 2026-02-18
- `2026-pattern-documented.md` — convergence color, featuredOnHomepage true, 2026-02-26

### Pattern Frontmatter Schema

```yaml
---
title: ""
date: YYYY-MM-DD
draft: false
description: ""          # 1-2 sentences for card display
tags: []
confidence: 0            # 0-100 integer — be honest
blockCount: 0            # number of evidence blocks backing this pattern
timespan: ""             # "Month YYYY – present" or "Month YYYY – Month YYYY"
trajectory: rising       # rising | stable | emerging | declining
featuredOnHomepage: false
---
```

**Confidence calibration guide:**
- 90-100: Expert, deeply validated across years and contexts
- 75-89: Advanced, battle-tested, go-to skill
- 60-74: Intermediate, solid but still growing
- 40-59: Emerging, early pattern visible
- Below 40: Nascent, not ready for pattern status

### Pattern Body Content Structure

Each pattern body should explain:
1. **What this pattern is** — the skill cluster in plain language
2. **How it emerged** — which projects, contexts, timeline
3. **Key evidence** — specific examples that back the confidence score
4. **Where it's going** — trajectory rationale (why rising/stable/etc.)

Example structure:
```markdown
## What This Pattern Is

[2-3 sentence description of the skill cluster]

## How It Emerged

[Narrative of the skill development — which projects, what experiences]

## Evidence

[Specific, dated examples. Links to posts or timeline moments where relevant.]

## Trajectory

[Why the trajectory is what it is. What's driving growth or stabilization.]
```

### Timeline Moment Frontmatter Schema

```yaml
---
title: ""
date: YYYY-MM-DD
draft: false
year: YYYY               # integer year (used for grouping on list page)
color: fresh             # fresh | pattern | convergence | depth
quote: ""                # The memorable line — specific, evocative
linkedPost: ""           # Optional: /posts/{slug}/ if this moment has a linked post
featuredOnHomepage: false
---
```

**Color semantics (from design-config.toml):**
- `fresh` — new discovery, recent insight, unvalidated
- `pattern` — structural, reliable, confirmed through repeated use
- `convergence` — where different skills/projects came together
- `depth` — deep mastery, long-cultivated, defining capability

**Quote writing guidance:**
- Capture the feeling of the moment, not a bland description
- First person, present tense preferred: "The dots connected — literally."
- Specific details beat generalities: "A YAML file becomes a collapsible timeline" > "Built the evidence trail feature"
- Aim for ~15-30 words

### Pattern Gallery Coherence Check

After creating/updating all patterns, step back and ask:
- Do these patterns tell a coherent story about Nicolas's capabilities?
- Is there variety in confidence levels (not all 85)?
- Do the patterns connect to the posts and timeline moments?
- Would a technical reviewer understand the skill profile?

Featured patterns (on homepage) should be the strongest evidence of Nicolas's most marketable skills.

### Architecture Compliance

- [Source: epics.md §D1.2] — Pattern files are leaf files at `content/patterns/{slug}.md`
- [Source: epics.md §D1.2] — Timeline files are leaf files at `content/timeline/{slug}.md`
- [Source: epics.md §NFR-3] — Evidence-based: every skill claim links to documented outcomes
- [Source: 4-1-create-pattern-content-section-archetype.md] — Pattern archetype structure
- [Source: 4-3-create-timeline-content-section-partial.md] — Timeline archetype structure
- [Source: design-config.toml] — Color semantics for timeline dots (fresh/pattern/convergence/depth)

### Hugo Pattern: where Query for Featured Content

Homepage queries (for reference — already implemented in Story 4.4):
```go-html-template
{{ $featured := where .Site.RegularPages "Params.featuredOnHomepage" true }}
```

If no featured patterns exist, Story 4.4 implemented a fallback to show any patterns. This story ensures the featured flag is set correctly so the primary path works.

### Project Structure Notes

Files to modify/create:
- `content/patterns/*.md` — upgrade/create as needed
- `content/timeline/*.md` — upgrade/create as needed
- No template changes needed — all built in Epics 4

### References

- [Source: epics.md §Story 5.4 — Seed Real Patterns & Timeline Content]
- [Source: epic-4-retro-2026-03-07.md §Retrospective Closure] — "meta-content scales"
- [Source: 4-5-seed-meta-content-for-template-verification.md §Completion Notes] — current content state
- [Source: 4-3-create-timeline-content-section-partial.md] — timeline color semantics

## Dev Agent Record

### Agent Model Used

*Recommended: claude-haiku-4-5-20251001 — content seeding with quality guidance in Dev Notes*
*Note: Nicolas is hands-on for content decisions. Content/author attention points require direct authorial judgment.*

### Debug Log References

### Completion Notes List

### File List
