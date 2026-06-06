---
name: validate-work-item
description: Validate one story or bugfix file before implementation. Use after `add-story` or `add-bugfix` to confirm the work item fits its epic, has concrete implementation tasks, and includes executable verification without blocking gaps.
---

# Validate Work Item

## Core Rule

Validate the written story or bugfix, not memory. Confirm exactly one work item is ready to feed `implement-work-item`: it fits the epic, has complete implementation tasks, concrete verification, and no blocking open questions. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load validation context:
   - Read one `docs/epics/active/<epic>/stories/story_*.md` or `docs/epics/active/<epic>/bugfixes/bugfix_*.md`.
   - Read `docs/epics/active/<epic>/epic.md` and its source PRD when present.
   - Read relevant concern specs, sibling stories, sibling bugfixes, and code evidence when they affect scope or verification.

2. Validate epic fit:
   - Check that the work item stays inside epic scope and does not contradict the PRD, epic, concern specs, or sibling work items.
   - Check that any scope change, public behavior change, rollout change, or material risk is reflected in `epic.md`; otherwise mark the item `Blocked` or `Fail`.

3. Validate work item quality:
   - For stories, check acceptance criteria, regression boundaries, implementation tasks, verification matrix, assumptions, and open questions.
   - For bugfixes, check current behavior, expected behavior, unchanged behavior, reproduction evidence, root cause, fix boundary, regression risks, implementation tasks, and verification matrix.
   - Check that every implementation task has purpose, scope, dependencies, verification steps, and pass criteria.
   - Check that verification methods are concrete enough to execute during `run-validation`.

4. Update validation status:
   - Update the work item's `Work Item Validation` section with evidence, gaps, skipped checks, and a decision: `Pass`, `Fail`, `Partial`, or `Blocked`.
   - Add remediation implementation tasks or notes when coverage or verification is missing.
   - Do not implement code; implementation belongs to `implement-work-item`.

5. Report result:
   - Summarize validation outcome, epic fit, coverage gaps, verification gaps, and blocking open questions.
   - Recommend `implement-work-item` when the result is `Pass`; otherwise recommend the specific artifact skill needed to fix the gap.

## Validation Checklist

- [ ] Work item fits the active epic and source PRD when present.
- [ ] Work item does not contradict sibling stories or bugfixes.
- [ ] Every acceptance, expected behavior, or unchanged behavior criterion has verification coverage.
- [ ] Every implementation task has concrete verification and pass criteria.
- [ ] Blocking open questions are resolved or recorded as `Blocked`.
- [ ] Result includes an overall decision: `Pass`, `Fail`, `Partial`, or `Blocked`.
- [ ] Passing work item can feed `implement-work-item`.
