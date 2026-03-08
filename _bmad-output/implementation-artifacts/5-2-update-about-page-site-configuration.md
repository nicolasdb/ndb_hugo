# Story 5.2: Update About Page & Site Configuration

Status: ready-for-dev

## Story

As a **portfolio visitor**,
I want to read Nicolas's real bio and navigate to all sections from the menu,
So that I understand who Nicolas is and can explore the full site.

## Acceptance Criteria

1. `content/about.md` contains Nicolas's real bio — not placeholder text
2. The bio links to the patterns gallery as capability evidence (at minimum one reference to `/patterns/`)
3. `hugo.yaml` includes menu items for all sections: Home, Posts, Patterns, Timeline, About
4. Menu items render correctly in `layouts/partials/nav.html`
5. Site metadata in `hugo.yaml` (title, description, author) reflects Nicolas's identity
6. `pnpm run test` passes

## Tasks / Subtasks

- [ ] Audit current about page and nav state (pre-work)
  - [ ] Read `content/about.md` — is it placeholder or partial content?
  - [ ] Read `hugo.yaml` — what menu items currently exist?
  - [ ] Read `layouts/partials/nav.html` — how are menu items rendered?
  - [ ] Note gaps before writing

- [ ] Write Nicolas's real bio in `content/about.md` (AC: 1, 2)
  - [ ] Keep it authentic and concise — this is the public face
  - [ ] Include: who Nicolas is, what he builds, the evidence-first approach to skills
  - [ ] Link to patterns gallery: "See my [skill patterns](/patterns/) for capability evidence"
  - [ ] Optional: link to a featured post or the ndb_hugo system doc post (Story 5.3)
  - [ ] Frontmatter: title, description, draft: false, date (past/current)

- [ ] Update hugo.yaml menu (AC: 3, 5)
  - [ ] Verify `main` menu includes: Home, Posts, Patterns, Timeline, About
  - [ ] Add any missing sections (Patterns and Timeline added in Epic 4 — confirm they're in menu)
  - [ ] Update `title`, `description`, `author` in hugo.yaml if Story 5.1 didn't already

- [ ] Verify nav renders all menu items correctly (AC: 4)
  - [ ] Run `pnpm run test` and check rendered nav
  - [ ] Verify nav links are correct: `/`, `/posts/`, `/patterns/`, `/timeline/`, `/about/`
  - [ ] Mobile nav (hamburger) also shows all items if applicable

- [ ] Run `pnpm run test` (AC: 6)

## Dev Notes

### About Page Content Guidance

The about page is the identity anchor of the portfolio. It should:

1. **Lead with what Nicolas builds** — not a bio list. Something like: "I build systems that make knowledge visible — from the CLI to the graph."
2. **Acknowledge the evidence model** — this portfolio IS the evidence system. The patterns gallery is the proof.
3. **Keep it short** — one screen. Visitors who want depth will read the posts.
4. **Link to patterns** — the patterns gallery is the "show don't tell" for capabilities.

Suggested structure for `content/about.md`:
```markdown
---
title: "About"
description: "Nicolas — building knowledge systems, one evidence block at a time."
draft: false
date: 2026-03-07
---

[2-3 paragraph bio]

## What I Build

[Short description of the ndb stack — Hugo portfolio + backoffice + knowledge graph]

## Skills as Evidence

This portfolio doesn't claim skills — it demonstrates them. The [patterns gallery](/patterns/)
shows emerging skill clusters backed by documented work. Each pattern links to the evidence trail.

## Get in Touch

[Contact link or note]
```

### Content/Author Attention Points

From Epic 4 Retro: Epic 5 stories have dual ACs — technical AND content quality.

**Author attention points for this story:**
- Does the bio sound like a real person, not a LinkedIn template?
- Does it connect the knowledge-first philosophy to the portfolio's purpose?
- Is the patterns gallery link natural, not forced?
- Would a technical recruiter understand in 30 seconds what Nicolas does?

### hugo.yaml Menu Structure

Hugo `main` menu typically looks like:
```yaml
menus:
  main:
    - name: Posts
      url: /posts/
      weight: 10
    - name: Patterns
      url: /patterns/
      weight: 20
    - name: Timeline
      url: /timeline/
      weight: 30
    - name: About
      url: /about/
      weight: 40
```

Verify this matches what `nav.html` expects. If the nav reads from `.Site.Menus.main`, this wiring is automatic.

### Architecture Compliance

- [Source: epics.md §Story 5.2 — About Page & Site Configuration AC]
- [Source: epics.md §Architecture D2.2] — Portfolio max-width 920px, mobile-first
- [Source: epics.md §UX Requirements] — Typography-forward design, generous whitespace
- [Source: DESIGN-SPEC.md §2 — Typography: "The Archivist"] — Literata heading, Hanken Grotesk body

### Project Structure Notes

Files touched:
- `content/about.md` (rewrite)
- `hugo.yaml` (menu items, metadata)
- `layouts/partials/nav.html` (verify only — should work automatically if hugo.yaml is correct)

### References

- [Source: epics.md §Story 5.2 — About Page & Site Configuration]
- [Source: epic-4-retro-2026-03-07.md §Epic 5 Preview — dual acceptance criteria]
- [Source: CLAUDE.md §Content Requirements] — draft: false, past/current dates

## Dev Agent Record

### Agent Model Used

*Recommended: claude-haiku-4-5-20251001 — content update and config wiring*

### Debug Log References

### Completion Notes List

### File List
