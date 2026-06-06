# Cortex

Cortex is a concern-centric development process for planned product and system
changes. It turns product intent into PRDs, slices PRDs into validated epics,
breaks epics into executable tasks, implements those tasks, records validation
evidence, updates durable system knowledge, and archives completed epic history.

The skills are designed to be used in order. Each planning artifact becomes the
source of truth for the next step, and each validation skill checks the written
artifact instead of relying on memory or conversation context.

## Artifact Layout

Generated project artifacts are written into the target repository that is being
planned or changed, not into the skills repository:

- `docs/prd/` - product requirements documents created by `create-prd`.
- `docs/epics/active/<epic>/epic.md` - active epic plans created by
  `create-epics`.
- `docs/epics/active/<epic>/tasks.md` - task plans created by `create-tasks`.
- `docs/epics/archived/<epic>/` - completed or closed epic history moved by
  `archive-epic`.
- `docs/knowledge/<concern>/` - current system knowledge maintained by
  `document-current-system`.
- `docs/adrs/` - important durable decisions captured by
  `document-decisions`.

## Delivery Process

Use this sequence for planned product or system changes:

```text
create-prd
  -> create-epics
  -> validate-epics
  -> create-tasks
  -> validate-tasks
  -> implement-tasks
  -> run-validation
  -> document-current-system
  -> archive-epic
```

`document-decisions` is used when a PRD, epic, task plan, implementation, or
validation result exposes an important durable decision that future maintainers
must understand. It is not a mandatory step for every change.

## Process Stages

### 1. Define Product Intent

Use `create-prd` when work starts from an idea, business request, problem,
stakeholder note, design, screenshot, or unstructured feature ask.

The PRD defines why the work exists: problem, users, goals, success criteria,
constraints, non-goals, affected concerns, assumptions, open questions,
dependencies, risks, and references. It should mention likely surfaces only as
product context. Final implementation details belong in epics and tasks.

Output: `docs/prd/<feature>.md`.

### 2. Slice Executable Epics

Use `create-epics` after the PRD is ready for planning.

Each epic owns one independently buildable delivery outcome. The epic records
scope, current system context, concern impact, dependencies, cross-epic
relationships, risks, rollout, implementation strategy, assumptions, open
questions, and ADR candidates. This skill does not create task files.

Output: `docs/epics/active/<epic>/epic.md`.

### 3. Validate Epics

Use `validate-epics` before creating tasks.

Validation checks that active epics preserve the PRD intent, cover every current
goal and acceptance criterion, avoid unapproved scope, stay consistent with
concern knowledge, and have no blocking open questions. Passing epics can move
to task planning. Failed, partial, or blocked epics should be corrected before
tasks are created.

Output: updated `Epic Validation` sections in the relevant `epic.md` files.

### 4. Create Task Plans

Use `create-tasks` for exactly one validated epic at a time.

The task plan breaks the epic into ordered, reviewable implementation units.
Every task includes purpose, scope, dependencies, verification steps, and pass
criteria. The task file also includes acceptance verification rows that map PRD
goals or acceptance criteria to epic outcomes, tasks, and verification methods.

Output: `docs/epics/active/<epic>/tasks.md`.

### 5. Validate Tasks

Use `validate-tasks` before implementation starts.

Validation checks that tasks cover the epic, preserve task sequencing and
dependencies, include executable verification, and do not contradict the PRD or
epic. Passing task plans can feed `implement-tasks`.

Output: updated `Task Plan Validation` section in `tasks.md`.

### 6. Implement The Plan

Use `implement-tasks` after `validate-tasks` passes and the user wants the work
built. If the user explicitly asks to implement an unvalidated or partially
validated task plan, record the override and risk before coding.

Implementation follows the `epic.md` and `tasks.md`. It should keep
scope tight, follow repository conventions, update task checkboxes only when
implementation work is complete and task-level verification has passed, and
stop for approval before materially changing the plan. Important durable design
decisions discovered during implementation should be captured with
`document-decisions` when they meet ADR criteria.

Output: scoped code, test, migration, documentation, or configuration changes,
plus updated task status where appropriate.

### 7. Run Validation

Use `run-validation` after implementation is complete or ready for objective
checking.

Validation checks implemented work against the written PRD, epic, task plan,
task verification steps, acceptance verification rows, and repository quality
gates. It records pass, fail, partial, blocked, skipped checks, command output,
evidence, and gaps in `tasks.md`.

Output: updated `Final Validation`, `Acceptance Verification`, and
`Validation Result` sections in `tasks.md`.

### 8. Update Current System Knowledge

Use `document-current-system` when `run-validation` returns `Pass`, when a
`Partial` result is explicitly approved for current-state documentation, or when
an existing system needs to be documented from evidence.

This skill writes living current-state knowledge, not feature history. It
extracts facts from code, tests, migrations, configuration, docs, operational
artifacts, and `Pass` or explicitly approved `Partial` validation evidence, then
routes each fact to the correct concern under `docs/knowledge/<concern>/`.

Output: created or updated concern specs.

### 9. Archive Completed Epics

Use `archive-epic` when implementation, validation, and system-state updates are
complete, or when an epic is intentionally closed.

Archiving writes a final summary, preserves validation evidence and decision
links, records deferred or cancelled work, and moves the epic folder from
`docs/epics/active/<epic>/` to `docs/epics/archived/<epic>/`.

Output: archived epic folder and archive summary.

## Validation Gates

The process has three explicit gates:

- `validate-epics` decides whether epic plans can feed task planning.
- `validate-tasks` decides whether task plans can feed implementation.
- `run-validation` decides whether implemented work satisfies the task plan.

Validation decisions use these result values:

- `Pass` - the artifact or implementation is ready for the next stage.
- `Fail` - required coverage, consistency, or verification is missing.
- `Partial` - some requirements pass, but remaining gaps are documented.
- `Blocked` - validation cannot continue without missing information, access,
  environment, credentials, ownership, or thresholds.

## Clarification Policy

Skills should ask only when the answer can change validation safety, required
environment, credentials, data, thresholds, ownership, scope, sequencing, risk,
or the final decision. If the answer can be discovered from repository context,
existing planning artifacts, concern specs, documentation, or code, inspect that
evidence instead. If ambiguity is non-blocking, proceed with a clear assumption
and record it in the relevant artifact.

## Decision Records

Use `document-decisions` for important durable decisions, especially decisions
about architecture, data models, execution models, API shape, integration
strategy, test isolation, concurrency, consistency, performance, security, or
operations.

Do not write ADRs for routine implementation notes, transient choices, local
file layout, naming details, decisions already dictated by existing conventions,
or choices with only one viable option.

Important durable decisions live as ADRs under `docs/adrs/`.
Repository naming and code conventions should be extracted into
`docs/knowledge/engineering/conventions.md` by default, or into
`docs/knowledge/architecture/<topic>.md` when they define architecture,
ownership, or cross-system contracts.

## Knowledge Concerns

Use these explicit concerns when adding current-system knowledge:

- `product`: capabilities, features, user value, and product behavior.
- `platform`: reusable services, shared libraries, internal platforms, and developer-facing capabilities.
- `engineering`: code organization, naming, style, test patterns, tooling, and contributor workflow.
- `architecture`: components, flows, boundaries, interfaces, dependencies, and patterns.
- `security`: authentication, authorization, data protection, privacy, audit, and threat controls.
- `operations`: monitoring, alerts, runbooks, SLOs, support procedures, and failure handling.
- `infrastructure`: environments, networks, databases, queues, storage, compute, and managed resources.

Ownership rules:

- `product` owns user-visible behavior and value.
- `platform` owns reusable internal capabilities.
- `engineering` owns contributor conventions, tests, tooling, and workflow.
- `architecture` owns runtime structure, interfaces, boundaries, and flows.
- `security` owns protection rules and threat controls.
- `operations` owns monitoring, support, recovery, and operating procedures.
- `infrastructure` owns provisioned resources and environments.
