---
title: "ndb_hugo: A Knowledge-First Portfolio Architecture"
date: 2026-03-07
description: "How this portfolio models skills as evidence, not claims — and why that distinction matters for building a trustworthy knowledge system."
tags: ["hugo", "architecture", "knowledge-systems", "ndb"]
categories: ["Technical"]
draft: false
blockCount: 7
timespan: "December 2025 – March 2026"
patterns: ["manual-content-publishing"]
---

Most portfolio sites are a list of claims. "Proficient in X." "Experience with Y." There's no mechanism for the reader to evaluate those claims — they either trust you or they don't.

This portfolio is built on a different premise: skills are only as credible as the evidence behind them. Every post here is backed by a trail of dated knowledge blocks — real events, real decisions, real moments where understanding was gained or confirmed. The architecture is designed to make that evidence visible.

This post documents how that architecture works, why it was built this way, and what it makes possible.

## The Problem with Portfolio Sites

Self-described skill levels have a fundamental flaw: the person being assessed is also the person doing the assessing. "Expert" and "familiar with" mean different things to different people, and there's no anchor.

The alternative — GitHub activity, project lists, contribution counts — measures activity, not understanding. Lines of code written doesn't tell you if the author understood what they were doing.

What actually demonstrates capability is documented learning: a record of when you encountered something, how your understanding evolved, where it converged with other knowledge, and what you built when it all came together.

## Three Content Types, One Evidence Model

ndb_hugo organizes portfolio content into three types, each backed by the same underlying evidence model.

### Post Bundles

Each post lives in a page bundle — a directory containing `index.md` and an optional `evidence.yaml` sidecar:

```
content/posts/{slug}/
  index.md        ← post content + frontmatter
  evidence.yaml   ← evidence sidecar (the knowledge trail)
```

The `index.md` frontmatter schema carries both standard Hugo fields and block-specific fields:

```yaml
---
title: ""
date: YYYY-MM-DD
description: ""
tags: []
categories: []
draft: false
# Block fields — present on real posts
blockCount: 0       # number of entries in evidence.yaml
timespan: ""        # human-readable: "Month YYYY – Month YYYY"
confidence: 0       # 0–100 integer (honest, not aspirational)
patterns: []        # slugs of related pattern pages
---
```

The `confidence` field deserves attention: it's meant to be honest. A score of 78–85 means battle-tested. A score of 60 means actively evolving. The point is calibration, not flattery.

### evidence.yaml Format

The `evidence.yaml` sidecar is where the actual evidence lives. Each entry is a knowledge block — a dated event that contributed to the post's understanding:

```yaml
blocks:
  - date: YYYY-MM-DD
    color: fresh|convergence|pattern|temporal|frontier|block
    content: "What happened. What was learned. Why it mattered."
```

Color semantics are semantic, not decorative:

- `fresh` — new insight, unvalidated, recent discovery
- `convergence` — an older idea meeting new work, intersection of domains
- `pattern` — a structural insight confirmed through repeated use
- `temporal` — a time marker, a checkpoint in a longer arc
- `frontier` — unexplored territory, a question without an answer yet
- `block` — deep mastery, long-cultivated, the accumulated thing

The evidence trail renders as a collapsible timeline on each post detail page, powered by Alpine.js. Readers can expand it to see the chronological journey, or ignore it entirely.

### Pattern Content Type

Patterns live as leaf files in `content/patterns/`. They model recurring skill clusters — things you reach for repeatedly across different contexts:

```yaml
---
title: ""
confidence: 0
blockCount: 0
timespan: ""
trajectory: "growing|stable|dormant"
featuredOnHomepage: true|false
---
```

A pattern with `featuredOnHomepage: true` appears in the homepage "Active Patterns" section. The trajectory field indicates whether the pattern is currently expanding, stable, or not actively used.

### Timeline Moments

Timeline entries live as leaf files in `content/timeline/`. They capture specific moments of inflection — project completions, insight crystallizations, first uses of a new approach:

```yaml
---
year: YYYY
color: ""        # CSS color token
quote: ""        # the moment, in one sentence
linkedPost: ""   # slug of related post (optional)
featuredOnHomepage: true|false
---
```

Timeline entries with `featuredOnHomepage: true` appear in the homepage "Growth Timeline" section.

## Homepage Assembly

The homepage queries content using Hugo's `.Pages` and `.Site.RegularPages` methods with `where` filters:

- **Latest Posts**: last 3 posts sorted by date
- **Active Patterns**: patterns where `featuredOnHomepage == true`
- **Growth Timeline**: timeline entries where `featuredOnHomepage == true`

If no featured patterns exist, the homepage falls back to showing all patterns. If no featured timeline entries exist, it shows the most recent three. The fallback logic ensures the page always renders something meaningful, even before content is fully seeded.

## The Backend-Frontend Contract

This architecture was designed with a specific future in mind: `ndb_backoffice`, a backend system that will author and publish content to this portfolio without a CMS.

The schemas documented above — post frontmatter, evidence.yaml, pattern and timeline models — are the contract between backend and frontend. The backend outputs files matching these schemas. The frontend renders them without an API. The bridge is a git commit.

This design means the frontend is completely static and the backend is completely decoupled. The contract is enforced by schema validation, not by runtime negotiation. If the backend produces a valid `evidence.yaml`, the frontend will render it correctly, always.

## What Comes Next

Phase 1 is `ndb_backoffice`: a system that reads knowledge from notes, conversations, and project logs, and generates content files matching these schemas. The schemas above become the API definition.

The portfolio you're reading was built in Phase 0 to define that contract precisely. Every architectural decision — page bundles over single files, YAML sidecars over embedded frontmatter, static rendering over dynamic queries — was made with the backend contract in mind.

The knowledge-first approach doesn't end here. It just moves upstream.
