---
name: add-story
description: Add one scoped story file either under a validated active epic or under `docs/standalone-changes/active/`. Use when the user has chosen a specific planned value slice, or after `plan-change` routes a request to story planning.
---

# Add Story

## Core Rule

Add exactly one story. A story is the implementation source of truth for one planned value slice; implementation tasks live inside the story file as a checklist. Place the story inside an active epic when it fits that epic, or under `docs/standalone-changes/active/` when it is self-contained and no active epic or new epic is needed. Do not use stories for defects that need root cause and regression preservation; use `add-bugfix` instead. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load inputs:
   - If an epic is provided, read `docs/epics/active/<epic>/epic.md` and its source `docs/vision.md`.
   - If no epic is provided, read `docs/vision.md` when present, active epics under `docs/epics/active/`, and standalone changes under `docs/standalone-changes/active/`.
   - Read existing sibling `story_*.md` and `bugfix_*.md` files for the selected placement.
   - Inspect relevant code, tests, docs, and concern specs.
   - If the user asks to plan or create all stories needed for the epic, recommend `suggest-stories` before creating files.

2. Confirm fit:
   - For epic-scoped stories, verify the requested story is within the epic scope.
   - For standalone stories, verify the requested story does not fit an active epic, does not need a new epic, and does not materially change the Product Vision.
   - If an epic-scoped story changes the epic outcome, success criteria, implementation strategy, rollout, or risk profile, stop and recommend updating `epic.md` and re-running `validate-epic`.
   - If a standalone story needs multiple coordinated stories or bugfixes, rollout/backout planning, cross-cutting risk tracking, or durable product direction changes, stop and recommend `plan-change`, `create-epic`, or `define-product-vision` as appropriate.
   - If it is a defect fix, use `add-bugfix`.

3. Write the story:
   - For epic-scoped placement, create or update `docs/epics/active/<epic>/story_<story-slug>.md`.
   - For standalone placement, create or update `docs/standalone-changes/active/story_<story-slug>.md`.
   - Use [references/story-template.md](references/story-template.md).
   - For standalone placement, include a `Routing Decision` section that records placement, reason, active epics checked, Product Vision impact, epic need, and `plan-change` when it supplied the route.
   - Include acceptance criteria, non-goals, dependencies, implementation tasks, verification, and validation sections.
   - Keep existing sibling story or bugfix statuses intact.

4. Report result:
   - Provide the absolute story path.
   - Summarize placement fit, assumptions, first implementation task, and recommend `validate-change-plan`.

## Validation Checklist

- [ ] Story is inside the epic scope, or has a recorded standalone routing decision.
- [ ] Story has user or system value and testable acceptance criteria.
- [ ] Non-goals and regression boundaries are explicit where relevant.
- [ ] Implementation tasks are ordered, concrete, and independently checkable.
- [ ] Verification includes commands or evidence methods with pass criteria.
- [ ] Story can feed `validate-change-plan`.
