---
name: validate-implementation
description: Validate all review-state epic-scoped and standalone stories or bugfixes against their change plans and repository quality gates, then update each artifact with results and workflow state.
---

# Validate Implementation

## Core Rule

Validate implemented work against written story and bugfix plans, not memory. Find artifacts with `State: Review` and validate each one. Check that implemented code covers each plan, its implementation task verification, verification matrix, required tests, and repository quality gates. Record `Pass`, `Fail`, `Partial`, or `Blocked`, update workflow state, and report verification gaps instead of inventing new criteria. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Load verification context:
   - Find every review-state epic-scoped story or bugfix under `docs/epics/active/<epic>/story_*.md` or `docs/epics/active/<epic>/bugfix_*.md`, and every review-state standalone story or bugfix under `docs/standalone-changes/active/story_*.md` or `docs/standalone-changes/active/bugfix_*.md`.
   - If no story or bugfix has `State: Review`, stop and report that there is no implementation queued for validation.
   - Read `docs/vision.md` when present.
   - For epic-scoped review artifacts, read their parent `docs/epics/active/<epic>/epic.md`.
   - For standalone review artifacts, read active epics and sibling standalone changes when placement or regression scope may be affected.
   - Inspect package scripts, CI config, test files, benchmark scripts, migrations, and runbooks referenced by the review artifacts.
   - Check repository status to understand implementation scope and uncommitted changes.

2. Validate plan-to-code coverage:
   - Check that code, tests, migrations, configuration, documentation, and operational changes cover every completed implementation task.
   - Check that acceptance criteria, expected behavior, unchanged behavior, and pass criteria are satisfied by executable checks or documented evidence.
   - Check that every verification matrix row has a result.
   - Check that implemented behavior stays within each reviewed story or bugfix scope and placement, and no out-of-scope behavior was added.

3. Execute quality gates:
   - Run change verification commands where possible.
   - Run relevant tests, linters, formatters, type checks, builds, migrations, or CI-equivalent checks according to repository conventions.
   - Prefer focused checks first, then broader checks when time and project conventions support it.
   - Capture pass, fail, skipped, and blocked results with enough detail to reproduce.
   - Record any missing criterion, unclear threshold, unavailable environment, or alignment issue as a verification gap.

4. Update validation status:
   - Update each reviewed story or bugfix `Verification Matrix`, `Final Validation`, `Validation Result`, evidence, and gaps.
   - Set `State: Implemented` when the validation decision is `Pass`.
   - Set `State: Partial Implemented` when the validation decision is `Partial` and some scoped behavior is valid but known gaps remain.
   - Set `State: Ready` when the validation decision is `Fail` because fixable implementation gaps should return to implementation.
   - Set `State: Blocked` when the validation decision is `Blocked`, and fill `Blocked By` with the concrete blocker.
   - Set `Blocked By: N/A` for `Implemented`, `Partial Implemented`, and `Ready` results unless a remaining blocker still applies.
   - Leave implementation task checkboxes accurate; do not mark tasks complete unless their task-level verification passed.
   - Include unresolved failures and recommended remediation tasks in each affected story or bugfix.

5. Report result:
   - Summarize validation outcome by story or bugfix, plan-to-code coverage, failed or skipped checks, and quality gate results.
   - Recommend `document-current-system` when the result is `Pass`, or when a `Partial` result is explicitly approved for current-state documentation; otherwise recommend `implement-change`, `validate-change-plan`, or the artifact skill needed to fix the gap.

## Validation Checklist

- [ ] Results map back to each reviewed story or bugfix placement scope, criteria, and implementation task verification.
- [ ] Every validated story or bugfix was in `Review` before validation.
- [ ] Implemented code covers completed implementation tasks and criteria.
- [ ] Required tests were added or updated where relevant.
- [ ] Linters, formatters, type checks, builds, migrations, tests, or CI-equivalent checks passed or have documented gaps.
- [ ] Commands, environments, and outcomes are recorded.
- [ ] Failures include actionable details.
- [ ] Skipped checks explain why they were skipped.
- [ ] Results include an overall decision: `Pass`, `Fail`, `Partial`, or `Blocked`.
- [ ] Each reviewed story or bugfix state was updated to `Implemented`, `Partial Implemented`, `Ready`, or `Blocked` according to the validation result.
- [ ] Results can feed `document-current-system` when `Pass`, or when an explicitly approved `Partial` result has durable behavior to document.
