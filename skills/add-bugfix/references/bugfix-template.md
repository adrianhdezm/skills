# Bugfix: <Title>

## Status

- State: Draft
- Placement: Epic-scoped or Standalone Change
- Epic: `docs/epics/active/<epic>/epic.md` or N/A
- Product Vision: `docs/vision.md` or N/A
- Created: <YYYY-MM-DD>
- Updated: <YYYY-MM-DD>
- Owner: <name or team>

## Routing Decision

- Placement: <Epic-scoped or Standalone Change>
- Reason: <Why this bugfix belongs in the selected placement>
- Active epics checked:
  - <epic path or name>: <Fit or non-fit reason>
- Product Vision impact: <No change, supports existing direction, or requires update>
- Epic needed: <Yes or No and why>
- Routed by: <plan-change, user selection, or direct epic scope>

## Sources

- `docs/epics/active/<epic>/epic.md` or N/A
- <Issue, report, log, test failure, user request, concern spec, code path, or operational reference>

## Current Behavior

- WHEN <condition or event>
  THE SYSTEM <incorrect observable behavior>

## Expected Behavior

- WHEN <condition or event>
  THE SYSTEM SHALL <correct observable behavior>

## Unchanged Behavior

- WHEN <condition or event>
  THE SYSTEM SHALL CONTINUE TO <existing behavior that must not regress>

## Reproduction Evidence

- Repro command or steps: <command, test, manual steps, log query, or "Not yet reproducible">
- Observed result: <failure, output, screenshot, log, or report>
- Repro confidence: <High, Medium, Low and why>

## Root Cause Analysis

- Suspected root cause: <cause>
- Evidence: <code path, test, log, trace, metric, or reasoning>
- Alternative causes considered:
  - <alternative and why it is less likely>

## Fix Boundary

### In Scope

- <Code, test, data, config, docs, or operational change required to fix the defect>

### Out Of Scope

- <Behavior, refactor, cleanup, feature, or broader remediation intentionally excluded>

### Constraints

- <Code path, API, schema, behavior, dependency, rollout, data, or compatibility constraint>

## Regression Risks

- <Risk and the check that protects it>

## Implementation Tasks

- [ ] 1. Add or confirm failing reproduction coverage
  - Purpose: Prove the defect exists before the fix, or record why deterministic reproduction is not possible.
  - Scope: <Tests, scripts, logs, fixtures, or manual evidence>
  - Depends on: none
  - Verification:
    - <Command or evidence method>
    - Pass criteria: <Failure reproduces the current behavior, or evidence explains why no failing test is practical>

- [ ] 2. <Fix task title>
  - Purpose: <Why this task fixes the root cause>
  - Scope: <Files, modules, data, docs, or config likely involved>
  - Depends on: 1
  - Verification:
    - <Command, manual check, migration check, security check, or observability check>
    - Pass criteria: <Expected behavior is observed>

- [ ] 3. Confirm regression boundaries
  - Purpose: Prove unchanged behavior still works.
  - Scope: <Tests, scripts, docs, logs, or manual checks>
  - Depends on: 2
  - Verification:
    - <Command or evidence method>
    - Pass criteria: <Unchanged behavior is preserved>

## Verification Matrix

| Property | Criterion | Task(s) | Verification Method | Result |
| --- | --- | --- | --- | --- |
| Reproduction | <current behavior criterion> | 1 | <command, test, log, or manual method> | Pending |
| Fix | <expected behavior criterion> | 2 | <command, test, log, or manual method> | Pending |
| Regression | <unchanged behavior criterion> | 3 | <command, test, log, or manual method> | Pending |

## Work Item Validation

- Decision: Pending
- Evidence:
  - <Repro evidence, root cause evidence, placement scope item, concern spec, code path, or review note>
- Gaps:
  - <Missing reproduction, unclear expected behavior, weak unchanged behavior, overbroad fix, or blocked question>

## Final Validation

- [ ] Work item passed `validate-work-plan`.
- [ ] Reproduction evidence proves the bug exists or explains why deterministic reproduction is not practical.
- [ ] Fixed behavior satisfies expected behavior.
- [ ] Unchanged behavior and regression boundaries still pass.
- [ ] Implemented behavior stays within bugfix scope and selected placement.
- [ ] No out-of-scope behavior, refactor, or cleanup was accidentally implemented.

## Validation Result

- Decision: Pending
- Evidence:
  - <Command output, test result, log, screenshot, metric, code path, or review note>
- Gaps:
  - <Missing criterion, failed check, unclear threshold, unavailable environment, or alignment issue>

## Assumptions

- <Assumption>

## Deferred Work

- <Known follow-up intentionally left out of this bugfix>

## Open Questions

- <Question>
