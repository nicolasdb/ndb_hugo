# Story 2.5: Rename `pearl` → `block` across codebase and docs

Status: ready-for-dev

## Story

As a **portfolio owner**,
I want all references to "pearl" renamed to "block" across code, templates, and documentation,
So that the conceptual model accurately reflects how knowledge compounds in 3D (blocks/Lego/atoms) rather than linear sequences.

## Acceptance Criteria

1. **CSS token renamed:** `--pearl` → `--block-color` in `assets/css/design-tokens.css` and all references updated
2. **Frontmatter fields renamed:** `pearls`/`pearlCount` → `blocks`/`blockCount` in all content archetypes and post frontmatter
3. **Partials renamed:** `pearl-meta.html` → `block-meta.html` (filename only; content behavior unchanged)
4. **Documentation updated:**
   - `DESIGN-SPEC.md`: all pearl references → block
   - `architecture.md`: all pearl references → block
   - `epics.md`: all pearl references → block (story descriptors stay, only variable names change)
5. **Verify no pearl references remain:** `grep -r "pearl" --exclude-dir=.git --exclude-dir=node_modules` returns 0 matches
6. **Codebase compiles cleanly:** `pnpm run test` passes with all changes
7. **Git history preserved:** Commit message documents the metaphor evolution and rationale

## Tasks / Subtasks

- [ ] Search codebase for all "pearl" references (371 occurrences across 19 files per retro)
- [ ] Update CSS tokens: `--pearl` → `--block-color`
  - [ ] `assets/css/design-tokens.css`
  - [ ] All `.css` and `.html` files using the token
- [ ] Update frontmatter field names in archetypes
  - [ ] `archetypes/posts/index.md` (pearlCount → blockCount)
  - [ ] `archetypes/patterns.md` (pearlCount → blockCount)
  - [ ] `archetypes/timeline.md` (if pearl fields present)
- [ ] Rename and update partials
  - [ ] Rename: `layouts/partials/pearl-meta.html` → `layouts/partials/block-meta.html`
  - [ ] Update all references in `*.html` files that call this partial
  - [ ] Update variable names inside the partial (internal `with` guards, etc.)
- [ ] Update Hugo configuration
  - [ ] `hugo.yaml`: Update any references in config/params
- [ ] Update documentation files
  - [ ] `_bmad-output/implementation-artifacts/DESIGN-SPEC.md`
  - [ ] `_bmad-output/planning-artifacts/architecture.md`
  - [ ] `_bmad-output/planning-artifacts/epics.md`
- [ ] Update content frontmatter
  - [ ] All existing posts in `content/posts/*/index.md`
  - [ ] All existing patterns in `content/patterns/*.md`
- [ ] Verify rename completeness
  - [ ] Run grep search for remaining "pearl" references
  - [ ] Run `pnpm run test` to ensure clean build
- [ ] Commit with clear message documenting metaphor evolution

## Dev Notes

### Naming Evolution: Pearl → Block

From retro insights:

> "Pearl" (linear, sequential necklace, precious) limits conceptual model.
> "Block" (Lego, Minecraft, voxels, atoms) enables 3D compounding — more blocks = more options & potential.

**Vocabulary Mapping:**

| Element | Old Name | New Name |
|---------|----------|----------|
| CSS token | `--pearl` | `--block-color` |
| Post frontmatter | `pearlCount` | `blockCount` |
| Post frontmatter | `pearls` | `blocks` |
| Pattern frontmatter | `pearlCount` | `blockCount` |
| Partial filename | `pearl-meta.html` | `block-meta.html` |
| **Evidence YAML array** | **`pearls:` (in evidence.yaml)** | **`blocks:` (full metaphor consistency)** |
| Confidence (stays) | `confidence` | `confidence` (UNCHANGED) |

### Files to Search & Update

**Codebase locations (per retro: 371 occurrences across 19 files):**
- CSS: `assets/css/design-tokens.css`, `assets/css/main.css`
- HTML partials: `layouts/partials/pearl-meta.html` (rename), other partials using the token
- Layouts: `layouts/_default/`, `layouts/posts/`, `layouts/patterns/`, etc.
- Configuration: `hugo.yaml`
- Archetypes: `archetypes/posts/index.md`, `archetypes/patterns.md`, `archetypes/timeline.md` (if applicable)
- Content: `content/posts/*/index.md` (frontmatter + evidence.yaml sidecars), `content/patterns/*.md`, `content/timeline/*.md`
- Docs: `DESIGN-SPEC.md`, `architecture.md`, `epics.md`

### Implementation Strategy

1. **Mechanical replacement with context awareness:**
   - Use find-and-replace tooling with careful attention to variable vs. semantic uses
   - "Pearl" in semantic/documentation text may stay in some places (e.g., "pearl of wisdom"), but technical names change

2. **Full metaphor consistency across evidence trail:**
   - The `pearls` array in `evidence.yaml` sidecars → rename to `blocks`
   - Each entry represents an evidence block (individual piece of proof-of-work)
   - This ensures block terminology is consistent everywhere (frontmatter, partials, YAML sidecars)

3. **File removal vs. rename:**
   - `pearl-meta.html` → `block-meta.html` (rename, not delete)
   - All `*.html` files update references to call the renamed partial

4. **Build validation:**
   - After rename, `pnpm run test` must pass
   - Grep for remaining "pearl" to catch any misses (should return 0)

### Architecture Compliance

[Source: DESIGN-SPEC.md§2] — Design foundation naming conventions
[Source: epics.md] — Pearl-backed epic (rename to Block-backed)
[Source: architecture.md] — Evidence trail model references

### Previous Story Intelligence

**Story 2.4 (Redesign Footer)** created design token integrations and partial namingpatterns. This story applies similar patterns at scale across the codebase.

### Critical Notes

- **Epic 3 dependency:** Stories 2.5 and 2.6 must complete before Epic 3 starts
- **Naming consistency:** All new code in Epic 3 will reference `block` terminology
- **Backward compatibility:** Not applicable (Phase 0, no external API)

## Dev Agent Record

### Agent Model Used

Haiku 4.5 (recommended for mechanical, structured rename tasks per retro model-optimization recipe)

### File List

**Files to modify (search result):**
- TBD (dev agent will run grep to identify all 371 occurrences across 19 files)

### Completion Notes

- [ ] All pearl → block renames verified
- [ ] No broken references remain
- [ ] Build passes
- [ ] Commit created with metaphor evolution documented

