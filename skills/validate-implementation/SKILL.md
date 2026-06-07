---
name: validate-implementation
description: Validate one review-state epic-scoped or standalone story or bugfix against its change plan and repository quality gates, then update that artifact with results and workflow state.
---

# Validate Implementation

## Core Rule

Validate exactly one implemented story or bugfix against its written plan, not memory. Only validate artifacts with `State: Review`. Check that implemented code covers the selected plan, its implementation task verification, verification matrix, required tests, and repository quality gates. Record `Pass`, `Fail`, `Partial`, or `Blocked`, update the selected artifact's workflow state, and report verification gaps instead of inventing new criteria. Follow [references/clarification-policy.md](references/clarification-policy.md).

## Workflow

1. Select exactly one implemented work item:
   - If the user provided a specific artifact path, use that path as the candidate work item.
   - If the user did not provide a specific artifact path, run this skill's `scripts/list-review-work.sh <target-repo-root>` to list review-state stories and bugfixes, then choose or ask for exactly one row from that output.
   - If no story or bugfix has `State: Review`, stop and report that there is no implementation queued for validation.
   - Do not validate multiple rows in one run. Stop and ask the user to choose when more than one review item is plausible and there is no clear single requested item.
   - Confirm the selected story or bugfix has `State: Review`; do not proceed with `Ready`, `Blocked`, `Partial Implemented`, or `Implemented` unless the user explicitly changes the artifact state.

2. Load verification context from the selected item:
   - Read only the selected epic-scoped story or bugfix under `docs/epics/active/<epic>/story_*.md` or `docs/epics/active/<epic>/bugfix_*.md`, or the selected standalone story or bugfix under `docs/standalone-changes/active/story_*.md` or `docs/standalone-changes/active/bugfix_*.md`.
   - Derive epic context from the selected item: for epic-scoped paths, read the sibling `docs/epics/active/<epic>/epic.md`; for standalone paths, treat `Epic: N/A` as authoritative unless the selected artifact says otherwise.
   - Read `docs/vision.md` when present and relevant to the selected artifact.
   - For standalone review artifacts, read active epics and sibling standalone changes only when the selected artifact's placement or regression scope depends on them.
   - Inspect package scripts, CI config, test files, benchmark scripts, migrations, and runbooks referenced by the selected artifact.
   - Check repository status to understand implementation scope and uncommitted changes.

3. Validate plan-to-code coverage:
   - Check that code, tests, migrations, configuration, documentation, and operational changes cover every completed implementation task.
   - Check that acceptance criteria, expected behavior, unchanged behavior, and pass criteria are satisfied by executable checks or documented evidence.
   - Check that every verification matrix row has a result.
   - Check that implemented behavior stays within the selected story or bugfix scope and placement, and no out-of-scope behavior was added.

4. Execute quality gates:
   - Run change verification commands where possible.
   - Run relevant tests, linters, formatters, type checks, builds, migrations, or CI-equivalent checks according to repository conventions.
   - Prefer focused checks first, then broader checks when time and project conventions support it.
   - Capture pass, fail, skipped, and blocked results with enough detail to reproduce.
   - Record any missing criterion, unclear threshold, unavailable environment, or alignment issue as a verification gap.

5. Update validation status:
   - Update the selected story or bugfix `Verification Matrix`, `Final Validation`, `Validation Result`, evidence, and gaps.
   - Set `State: Implemented` when the validation decision is `Pass`.
   - Set `State: Partial Implemented` when the validation decision is `Partial` and some scoped behavior is valid but known gaps remain.
   - Set `State: Ready` when the validation decision is `Fail` because fixable implementation gaps should return to implementation.
   - Set `State: Blocked` when the validation decision is `Blocked`, and fill `Blocked By` with the concrete blocker.
   - Set `Blocked By: N/A` for `Implemented`, `Partial Implemented`, and `Ready` results unless a remaining blocker still applies.
   - Leave implementation task checkboxes accurate; do not mark tasks complete unless their task-level verification passed.
   - Include unresolved failures and recommended remediation tasks in the selected story or bugfix.

6. Report result:
   - Summarize validation outcome for the selected story or bugfix, plan-to-code coverage, failed or skipped checks, and quality gate results.
   - Recommend `document-current-system` when the result is `Pass`, or when a `Partial` result is explicitly approved for current-state documentation; otherwise recommend `implement-change`, `validate-change-plan`, or the artifact skill needed to fix the gap.

## Validation Checklist

- [ ] Results map back to the selected story or bugfix placement scope, criteria, and implementation task verification.
- [ ] Exactly one story or bugfix was selected before epic, standalone, or verification context was loaded.
- [ ] The selected story or bugfix was in `Review` before validation.
- [ ] Implemented code covers completed implementation tasks and criteria.
- [ ] Required tests were added or updated where relevant.
- [ ] Linters, formatters, type checks, builds, migrations, tests, or CI-equivalent checks passed or have documented gaps.
- [ ] Commands, environments, and outcomes are recorded.
- [ ] Failures include actionable details.
- [ ] Skipped checks explain why they were skipped.
- [ ] Results include an overall decision: `Pass`, `Fail`, `Partial`, or `Blocked`.
- [ ] The selected story or bugfix state was updated to `Implemented`, `Partial Implemented`, `Ready`, or `Blocked` according to the validation result.
- [ ] Results can feed `document-current-system` when `Pass`, or when an explicitly approved `Partial` result has durable behavior to document.
