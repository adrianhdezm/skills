---
name: suggest-epics
description: Suggest candidate epics from a PRD, current system state, active epics, and archived epics without creating files until the user accepts a specific suggestion. Use when the user wants to brainstorm, slice a vision, find PRD coverage gaps, or generate new epic options.
---

# Suggest Epics

## Core Rule

Suggest candidate epic boundaries; do not create or modify epic files unless the user explicitly accepts one or more suggestions and asks you to proceed with `create-epic`. This skill separates PRD decomposition from artifact creation. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load inputs:
   - Read the source PRD from `docs/prd/`.
   - Read existing `docs/epics/active/*/epic.md`.
   - Read relevant `docs/epics/archived/*/epic.md` and archive summaries when they inform overlap, precedent, cancelled scope, deferred scope, sequencing, or lessons from completed work.
   - Read relevant `docs/knowledge/` concern specs and inspect code or docs enough to understand current system boundaries.

2. Analyze coverage:
   - Map current PRD goals, user stories, constraints, non-goals, and acceptance criteria to active and relevant archived epics.
   - Identify already-owned scope, partial coverage, gaps, conflicts, duplicated ownership, and sequencing constraints.
   - Use archived epics to avoid re-suggesting completed, cancelled, superseded, or intentionally deferred work without calling out why it is being reopened.
   - Distinguish product or platform outcomes from technical layers.
   - Treat full-PRD coverage analysis as suggestion input, not as epic validation.

3. Suggest candidates:
   - Propose the smallest useful set of candidate epics that cover missing or requested PRD outcomes.
   - For each candidate, include outcome, why it is end-to-end, key in-scope and out-of-scope items, PRD coverage, dependencies, sequencing, overlap risk, and open questions.
   - Prefer fewer, clearer candidates. Do not force a full breakdown if the user asked about one area.

4. Ask for acceptance:
   - Ask the user which candidate to create or revise.
   - If accepted, use `create-epic` for each accepted candidate, one epic at a time.
   - If rejected or changed, revise suggestions before writing any artifact.

## Validation Checklist

- [ ] Existing active epics were checked for coverage and overlap.
- [ ] Relevant archived epics and archive summaries were checked for precedent, completed scope, cancelled scope, deferred scope, and lessons learned.
- [ ] Suggestions are end-to-end delivery outcomes, not technical layers.
- [ ] Each suggestion maps to specific PRD items.
- [ ] Gaps, overlap, dependencies, sequencing, and open questions are explicit.
- [ ] No files were created or modified unless the user accepted a suggestion and requested creation.
