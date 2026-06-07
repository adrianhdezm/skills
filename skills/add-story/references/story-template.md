# Story: <Title>

## Status

- State: Draft
- Placement: Epic-scoped or Standalone Change
- Epic: `docs/epics/active/<epic>/epic.md` or N/A
- Product Vision: `docs/vision.md`
- Created: <YYYY-MM-DD>
- Updated: <YYYY-MM-DD>
- Owner: <name or team>

## Routing Decision

- Placement: <Epic-scoped or Standalone Change>
- Reason: <Why this story belongs in the selected placement>
- Active epics checked:
  - <epic path or name>: <Fit or non-fit reason>
- Product Vision impact: <No change, supports existing direction, or requires update>
- Epic needed: <Yes or No and why>
- Routed by: <plan-change, user selection, or direct epic scope>

## Sources

- `docs/epics/active/<epic>/epic.md` or N/A
- `docs/vision.md`
- <Relevant concern specs, code paths, docs, tests, designs, or operational references>

## Intent

<Why this story exists and what value it delivers inside the epic or as a standalone change.>

## Scope

### In Scope

- <Behavior, workflow, API, UI, job, data, docs, or operational change>

### Out Of Scope

- <Explicit exclusion>

## Acceptance Criteria

Use EARS notation where possible.

- WHEN <condition or event>
  THE SYSTEM SHALL <observable behavior>

## Regression Boundaries

- WHEN <condition or event>
  THE SYSTEM SHALL CONTINUE TO <existing behavior that must not change>

## Implementation Tasks

- [ ] 1. <Task title>
  - Purpose: <Why this task exists>
  - Scope: <Files, modules, data, docs, or config likely involved>
  - Depends on: <Task number or none>
  - Verification:
    - <Command, manual check, benchmark, migration check, security check, or observability check>
    - Pass criteria: <Observable result that proves this task works>

## Verification Matrix

| Acceptance Or Regression Criterion | Task(s) | Verification Method | Result |
| --- | --- | --- | --- |
| <criterion> | <task number(s)> | <command, test, review, metric, or manual method> | Pending |

## Change Plan Validation

- Decision: Pending
- Evidence:
  - <Epic scope item, Product Vision criterion, concern spec, code path, or review note>
- Gaps:
  - <Missing coverage, inconsistent task, unclear verification, or blocked question>

## Final Validation

- [ ] Change plan passed `validate-change-plan`.
- [ ] All implementation task verification passed.
- [ ] Every acceptance criterion has matching verification evidence.
- [ ] Every regression boundary has matching verification evidence.
- [ ] Implemented behavior stays within story scope and selected placement.
- [ ] No out-of-scope Product Vision, epic, story, or bugfix behavior was accidentally implemented.

## Validation Result

- Decision: Pending
- Evidence:
  - <Command output, test result, log, screenshot, metric, code path, or review note>
- Gaps:
  - <Missing criterion, failed check, unclear threshold, unavailable environment, or alignment issue>

## Sequencing Notes

<Important dependency, rollout, migration, or review notes.>

## Assumptions

- <Assumption>

## Deferred Work

- <Known follow-up intentionally left out of this story>

## Open Questions

- <Question>
