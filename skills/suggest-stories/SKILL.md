---
name: suggest-stories
description: Suggest candidate stories for one active epic without creating files until the user accepts specific suggestions. Use after `validate-epic` when the user wants to plan the story set needed to fulfill an epic, find missing story coverage, or choose the next independently implementable value slices.
---

# Suggest Stories

## Core Rule

Suggest candidate story boundaries for exactly one active epic; do not create or modify story files unless the user explicitly accepts one or more suggestions and asks you to proceed with `add-story`. This skill separates story decomposition from story artifact creation. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load inputs:
   - Read exactly one `docs/epics/active/<epic>/epic.md`.
   - Read the source Product Vision when present.
   - Read existing `stories/story_*.md` and `bugfixes/bugfix_*.md` in the epic.
   - Read relevant `docs/knowledge/` concern specs and inspect code, tests, or docs enough to understand current system boundaries.

2. Analyze epic fulfillment:
   - Map the epic's intent, in-scope items, Product Vision coverage role, risks, rollout, and validation gaps to existing stories and bugfixes.
   - Identify already-planned work, partial coverage, missing value slices, sequencing constraints, regression boundaries, and duplicated ownership.
   - Distinguish planned value slices from corrective defect work. Recommend `add-bugfix` for defects that need root cause and regression preservation.

3. Suggest candidates:
   - Propose the smallest useful story set that can fulfill the epic's in-scope outcome.
   - For each candidate, include purpose, user or system value, in-scope and out-of-scope behavior, acceptance criteria themes, regression boundaries, dependencies, sequencing, verification approach, and overlap risk.
   - Keep each candidate independently implementable and validatable by `validate-work-plan`.
   - Do not force a complete story breakdown if the user asked only for the next story or a specific area.

4. Ask for acceptance:
   - Ask the user which candidate to create, revise, defer, or drop.
   - If accepted, use `add-story` for each accepted candidate, one story at a time.
   - If a candidate is actually a defect fix, recommend `add-bugfix` instead of creating a story.
   - If rejected or changed, revise suggestions before writing any artifact.

## Validation Checklist

- [ ] Exactly one active epic was analyzed.
- [ ] Existing stories and bugfixes in the epic were checked for coverage and overlap.
- [ ] Suggestions are independently implementable planned value slices, not technical task buckets.
- [ ] Defect fixes are routed to `add-bugfix`.
- [ ] Each suggestion maps to specific epic scope, Product Vision items when present, and acceptance criteria themes.
- [ ] Gaps, overlap, dependencies, sequencing, regression boundaries, and open questions are explicit.
- [ ] No files were created or modified unless the user accepted a suggestion and requested creation.
