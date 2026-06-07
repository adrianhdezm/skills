---
name: validate-implementation
description: Validate implemented code against one epic-scoped or standalone story or bugfix work plan and repository quality gates, then update that work item with results. Use after `implement-work-item` when implementation is complete or partially complete and objective validation is needed before state evolution or archiving.
---

# Validate Implementation

## Core Rule

Validate implemented work against the written story or bugfix plan, not memory. Verify that implemented code covers the plan, its implementation task verification, verification matrix, required tests, and repository quality gates. Record `Pass`, `Fail`, `Partial`, or `Blocked`, and report verification gaps instead of inventing new criteria. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load verification context:
   - Read one epic-scoped work item under `docs/epics/active/<epic>/stories/story_*.md` or `docs/epics/active/<epic>/bugfixes/bugfix_*.md`, or one standalone work item under `docs/standalone-changes/active/stories/story_*.md` or `docs/standalone-changes/active/bugfixes/bugfix_*.md`.
   - Read `docs/vision.md` when present.
   - For epic-scoped work, read `docs/epics/active/<epic>/epic.md`.
   - For standalone work, read active epics and sibling standalone changes when placement or regression scope may be affected.
   - Inspect package scripts, CI config, test files, benchmark scripts, migrations, and runbooks referenced by the work item.
   - Check repository status to understand implementation scope and uncommitted changes.

2. Validate plan-to-code coverage:
   - Check that code, tests, migrations, configuration, documentation, and operational changes cover every completed implementation task.
   - Check that acceptance criteria, expected behavior, unchanged behavior, and pass criteria are satisfied by executable checks or documented evidence.
   - Check that every verification matrix row has a result.
   - Check that implemented behavior stays within work item scope and selected placement and no out-of-scope behavior was added.

3. Execute quality gates:
   - Run work-item verification commands where possible.
   - Run relevant tests, linters, formatters, type checks, builds, migrations, or CI-equivalent checks according to repository conventions.
   - Prefer focused checks first, then broader checks when time and project conventions support it.
   - Capture pass, fail, skipped, and blocked results with enough detail to reproduce.
   - Record any missing criterion, unclear threshold, unavailable environment, or alignment issue as a verification gap.

4. Update validation status:
   - Update the selected story or bugfix `Verification Matrix`, `Final Validation`, `Validation Result`, evidence, and gaps.
   - Leave implementation task checkboxes accurate; do not mark tasks complete unless their task-level verification passed.
   - Include unresolved failures and recommended remediation tasks in the selected work item.

5. Report result:
   - Summarize validation outcome, plan-to-code coverage, failed or skipped checks, and quality gate results.
   - Recommend `document-current-system` when the result is `Pass`, or when a `Partial` result is explicitly approved for current-state documentation; otherwise recommend `implement-work-item`, `validate-work-plan`, or the artifact skill needed to fix the gap.

## Validation Checklist

- [ ] Results map back to placement scope, work item criteria, and implementation task verification.
- [ ] Implemented code covers completed implementation tasks and criteria.
- [ ] Required tests were added or updated where relevant.
- [ ] Linters, formatters, type checks, builds, migrations, tests, or CI-equivalent checks passed or have documented gaps.
- [ ] Commands, environments, and outcomes are recorded.
- [ ] Failures include actionable details.
- [ ] Skipped checks explain why they were skipped.
- [ ] Results include an overall decision: `Pass`, `Fail`, `Partial`, or `Blocked`.
- [ ] Results can feed `document-current-system` when `Pass`, or when an explicitly approved `Partial` result has durable behavior to document.
