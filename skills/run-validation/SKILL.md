---
name: run-validation
description: Validate implemented code against task plans and repository quality gates, then update `docs/epics/active/<epic>/tasks.md` with results. Use after `implement-tasks` when implementation is complete or partially complete and the active epic needs objective validation before state evolution or archiving.
---

# Run Validation

## Core Rule

Validate against the written plan, not memory. Verify that implemented code covers the task plan, task verification, PRD acceptance criteria owned by the epic, required tests, and repository quality gates. Record `Pass`, `Fail`, `Partial`, or `Blocked`, and report verification gaps instead of inventing new criteria. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load verification context:
   - Read `docs/prd/<feature>.md`, `docs/epics/active/<epic>/epic.md`, and `docs/epics/active/<epic>/tasks.md`.
   - Inspect package scripts, CI config, test files, benchmark scripts, migrations, and runbooks referenced by `tasks.md`.
   - Check repository status to understand implementation scope and uncommitted changes.

2. Validate task-to-code coverage:
   - Check that code, tests, migrations, configuration, documentation, and operational changes cover every completed task.
   - Check that task acceptance criteria and pass criteria are satisfied by executable checks or documented evidence.
   - Check that every PRD goal and acceptance criterion owned by this epic has a matching acceptance verification row and result.
   - Check that implemented behavior stays within epic scope and no out-of-scope behavior was added.

3. Execute quality gates:
   - Run task-level verification commands where possible.
   - Run relevant tests, linters, formatters, type checks, builds, migrations, or CI-equivalent checks according to repository conventions.
   - Prefer focused checks first, then broader checks when time and project conventions support it.
   - Capture pass, fail, skipped, and blocked results with enough detail to reproduce.
   - Record any missing criterion, unclear threshold, unavailable environment, or alignment issue as a verification gap.

4. Update validation status:
   - Update `docs/epics/active/<epic>/tasks.md` acceptance verification rows, final validation checklist, validation result, evidence, and gaps.
   - Leave task checkboxes accurate; do not mark implementation tasks complete unless their task-level verification passed. Record final acceptance separately in `Final Validation` and `Validation Result`.
   - Include unresolved failures and recommended remediation tasks in `tasks.md`.

5. Report result:
   - Summarize validation outcome, task-to-code coverage, failed or skipped checks, and quality gate results.
   - Recommend `document-current-system` when the result is `Pass`, or when a `Partial` result is explicitly approved for current-state documentation; otherwise recommend `implement-tasks`, `validate-tasks`, or the artifact skill needed to fix the gap.

## Validation Checklist

- [ ] Results map back to PRD goals, epic scope, and task verification.
- [ ] Implemented code covers completed tasks and acceptance criteria.
- [ ] Required tests were added or updated where relevant.
- [ ] Linters, formatters, type checks, builds, migrations, tests, or CI-equivalent checks passed or have documented gaps.
- [ ] Commands, environments, and outcomes are recorded.
- [ ] Failures include actionable details.
- [ ] Skipped checks explain why they were skipped.
- [ ] Results include an overall decision: `Pass`, `Fail`, `Partial`, or `Blocked`.
- [ ] Results can feed `document-current-system` when `Pass`, or when an explicitly approved `Partial` result has durable behavior to document.
