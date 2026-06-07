---
name: add-story
description: Add or extend one validated epic with one scoped story file under `docs/epics/active/<epic>/stories/story_<name>.md`. Use when the user has chosen a specific planned value slice to create. Use `suggest-stories` first when the user wants to discover or plan multiple stories for an epic.
---

# Add Story

## Core Rule

Add exactly one story to an existing active epic. A story is the implementation source of truth for one planned value slice inside the epic; implementation tasks live inside the story file as a checklist. Do not use stories for defects that need root cause and regression preservation; use `add-bugfix` instead. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load inputs:
   - Read `docs/epics/active/<epic>/epic.md` and its source `docs/vision.md`.
   - Read existing `stories/story_*.md` and `bugfixes/bugfix_*.md` in the epic.
   - Inspect relevant code, tests, docs, and concern specs.
   - If the user asks to plan or create all stories needed for the epic, recommend `suggest-stories` before creating files.

2. Confirm fit:
   - Verify the requested story is within the epic scope.
   - If it changes the epic outcome, success criteria, implementation strategy, rollout, or risk profile, stop and recommend updating `epic.md` and re-running `validate-epic`.
   - If it is a defect fix, use `add-bugfix`.

3. Write the story:
   - Create or update `docs/epics/active/<epic>/stories/story_<story-slug>.md`.
   - Use [references/story-template.md](references/story-template.md).
   - Include acceptance criteria, non-goals, dependencies, implementation tasks, verification, and validation sections.
   - Keep existing child work item statuses intact.

4. Report result:
   - Provide the absolute story path.
   - Summarize epic fit, assumptions, first implementation task, and recommend `validate-work-plan`.

## Validation Checklist

- [ ] Story is inside the epic scope.
- [ ] Story has user or system value and testable acceptance criteria.
- [ ] Non-goals and regression boundaries are explicit where relevant.
- [ ] Implementation tasks are ordered, concrete, and independently checkable.
- [ ] Verification includes commands or evidence methods with pass criteria.
- [ ] Story can feed `validate-work-plan`.
