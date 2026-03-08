# Story 5.5: Final Polish & Phase 0 Milestone Tag

Status: ready-for-dev

## Story

As a **portfolio owner**,
I want the Phase 0 portfolio complete, deployed, and tagged,
So that I have a proven foundation to build upon and a milestone to reference.

## Acceptance Criteria

1. All pages render correctly on the deployed Netlify site — no broken layouts, missing images, or CSS errors
2. No broken links, missing images, or 404s exist on any page
3. The homepage displays real posts, patterns, and timeline moments (not empty sections)
4. The contact page (`content/contact.md`) is reviewed — updated if placeholder content remains
5. Navigation works correctly across all sections: `/`, `/posts/`, `/patterns/`, `/timeline/`, `/about/`, `/contact/`
6. `pnpm run test` passes with 0 errors
7. The milestone is tagged: `git tag v0.2.0-phase0-complete`
8. Tag is pushed to remote: `git push origin v0.2.0-phase0-complete`

## Tasks / Subtasks

- [ ] Full site audit — every page (AC: 1, 2, 5)
  - [ ] Run `pnpm run test` — confirm page count and 0 errors
  - [ ] Navigate to `/` — hero, posts section, patterns section, timeline section all populated
  - [ ] Navigate to `/posts/` — all posts listed with block metadata
  - [ ] Navigate to each post detail — confidence bar, evidence trail, block-meta render correctly
  - [ ] Navigate to `/patterns/` — all pattern cards render (confidence bars, meta row)
  - [ ] Navigate to each pattern detail — all fields render
  - [ ] Navigate to `/timeline/` — all moments in chronological order, color dots visible
  - [ ] Navigate to `/about/` — real bio, no placeholder text
  - [ ] Navigate to `/contact/` — review and update if placeholder

- [ ] Fix any visual glitches found (AC: 1)
  - [ ] Nicolas is hands-on for this story — visual issues are fixed directly, not deferred
  - [ ] No design debt policy: if it looks wrong, fix it now
  - [ ] Common areas to check: typography consistency, spacing, dark mode rendering, mobile layout

- [ ] Review and update contact page (AC: 4)
  - [ ] Read `content/contact.md` — is it real content or placeholder?
  - [ ] Update if needed: contact method, brief note about Nicolas

- [ ] Verify deployed Netlify site (AC: 1, 2, 3)
  - [ ] Confirm Netlify deploy succeeds after story 5.1-5.4 changes are merged
  - [ ] Check deployed site (not just local) for any rendering differences
  - [ ] Verify OG images appear correctly in social sharing preview (use a social card previewer)

- [ ] Create milestone tag (AC: 7, 8)
  - [ ] Confirm all Epic 5 stories are done and merged to main
  - [ ] `git tag v0.2.0-phase0-complete`
  - [ ] `git push origin v0.2.0-phase0-complete`

- [ ] Run `pnpm run test` final confirmation (AC: 6)

## Dev Notes

### No Design Debt Policy

From Epic 4 Retro: "Nicolas hands-on — direct visual glitch fixing during Epic 5, no design debt deferred."

This story is the final opportunity to fix anything that looks wrong. Visual issues encountered:
- Spacing inconsistencies between sections
- Font rendering differences in dark mode
- Mobile layout issues at `sm` breakpoint
- Pattern card height alignment in grid

Fix them. Don't open tickets. Don't defer to Phase 1.

### What "Complete" Means

Phase 0 is complete when:
- A visitor can land on the homepage and understand immediately who Nicolas is and what he builds
- The patterns gallery demonstrates real capability with evidence backing
- The timeline tells a coherent story of growth
- Posts show the depth of thinking behind the work
- Every page is real — no placeholder content anywhere

The bar is not perfection. The bar is: "Would I be comfortable sharing this URL with a technical recruiter today?"

### Final Page Count Estimate

Starting at 59 pages (end of Epic 4). Epic 5 adds:
- Story 5.3: 2-3 post bundles → +2-3 pages
- Story 5.4: any new patterns/timeline → +0-5 pages
- Story 5.2: about page already exists, just updated

Expected range: 62-70 pages with 0 errors.

### Milestone Tag Convention

From architecture.md:
- Phase 0 milestone: `v0.2.0-phase0-complete`
- Previous milestone: `v0.1.0-phase0-foundation` (Epic 1)

The tag goes on `main` after all stories are merged.

### Post-Phase 0 Handoff

After tagging, the backlog.md items become Phase 1 candidates:
1. Constellation SVG for pattern cards
2. `design-spec-split` skill
3. `ndb_hugo content schemas` skill (backend-frontend contract)
4. ndb_backoffice planning begins

The schemas documented in Story 5.3's ndb_hugo post are the source material for the backoffice integration contract. Keep that post precise — it will be referenced.

### Contact Page Context

`content/contact.md` may have been created in Epic 1 or Epic 2 as part of the site structure. Check if it has:
- Real contact method (email, GitHub, LinkedIn)
- Brief note about what Nicolas is open to (collaborations? roles? consulting?)
- Or if it's just a placeholder form from TailBliss

Update to reflect Nicolas's actual contact preferences.

### Architecture Compliance

- [Source: epics.md §Story 5.5 — Final Polish & Phase 0 Milestone Tag]
- [Source: epics.md §D3.1] — Tag milestone `v0.2.0-phase0-complete`
- [Source: epics.md §NFR-2] — Continuous Operation — real-time updates via Netlify git push
- [Source: CLAUDE.md §Development Workflow] — `pnpm run test` before committing

### Project Structure Notes

Files potentially touched (based on polish findings):
- `content/contact.md` (review and update)
- Any layout partial with visual glitches
- `layouts/index.html` if homepage section spacing needs adjustment

No structural changes expected — this is a polish and verification story.

### References

- [Source: epics.md §Story 5.5 — Final Polish & Phase 0 Milestone Tag]
- [Source: epic-4-retro-2026-03-07.md §Epic 5 Preview — Nicolas hands-on, no design debt]
- [Source: backlog.md — post-Phase 0 work queued]
- [Source: CLAUDE.md §Building & Testing] — `pnpm run test` validation command

## Dev Agent Record

### Agent Model Used

*Recommended: claude-sonnet-4-6 — holistic audit and visual polish requires judgment across many files*

### Debug Log References

### Completion Notes List

### File List
