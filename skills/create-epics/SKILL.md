---
name: create-epics
description: Slice a PRD and current system state into one or more executable epic plans under `docs/epics/active/<epic>/epic.md`. Use when a PRD is ready for planning, when work needs bounded delivery streams, or when active planning should begin.
---

# Create Epics

## Core Rule

Slice product intent into the smallest set of independently buildable epics. The required flow is `create-prd -> create-epics -> validate-epics -> add-story or add-bugfix`; `create-epics` must not create child work item files. Each `docs/epics/active/<epic>/epic.md` owns one delivery outcome and can later contain independently validated stories and bugfixes. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load inputs:
   - Read the PRD from `docs/prd/`.
   - Read relevant `docs/knowledge/` concern specs and active epics.
   - Inspect code and docs enough to understand current system boundaries and related work.

2. Slice epics:
   - Decide whether the PRD maps to one epic or multiple epics.
   - Define each epic's outcome, in-scope behavior, out-of-scope behavior, dependencies, risks, and rollout approach.
   - Keep each epic independently buildable and verifiable.
   - Record cross-epic dependencies and sequencing.
   - Ask when epic boundaries are ambiguous enough to affect delivery.

3. Write epics:
   - Ensure one `docs/epics/active/<epic>/` folder exists for each epic.
   - Write `docs/epics/active/<epic>/epic.md` using [references/epic-template.md](references/epic-template.md).
   - Include implementation strategy, concern impact, rollout/backout, ADR candidates, and cross-epic relationships in each epic.
   - Do not write story or bugfix files; child work item sequencing and verification tracking are created by `add-story` and `add-bugfix`.

4. Report result:
   - Provide the absolute path for every epic created.
   - Summarize epic slicing decisions, cross-epic dependencies, assumptions, open questions, and recommend `validate-epics`.

## Validation Checklist

- [ ] PRD intent is preserved.
- [ ] Current system state and active work were checked.
- [ ] The PRD is sliced into one or more independently buildable epics.
- [ ] Each epic has concrete scope, non-scope, dependencies, risks, rollout, and concern impact.
- [ ] Cross-epic dependencies and sequencing are explicit.
- [ ] No story or bugfix files were created by this skill.
- [ ] Each epic is concrete enough to feed `validate-epics`.
