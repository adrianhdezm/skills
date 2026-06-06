# Cortex

Cortex is a concern-centric development process for planned product and system
changes. It turns product intent into a single Product Vision, suggests epic
and story options when decomposition is needed, creates validated epics one at a
time, adds
independently validated stories and bugfixes inside those epics, implements one
work item at a time, records validation evidence, updates durable system
knowledge, and archives completed epic history.

The skills are designed to be used in order. Each planning artifact becomes the
source of truth for the next step, and each validation skill checks the written
artifact instead of relying on memory or conversation context.

## Artifact Layout

Generated project artifacts are written into the target repository that is being
planned or changed, not into the skills repository:

- `docs/product-vision.md` - the single project-level product vision created or
  updated by `define-product-vision`.
- `docs/epics/active/<epic>/epic.md` - active epic plans created by
  `create-epic`.
- `docs/epics/active/<epic>/stories/story_<name>.md` - planned value slices
  added by `add-story`.
- `docs/epics/active/<epic>/bugfixes/bugfix_<name>.md` - surgical defect fixes
  added by `add-bugfix`.
- `docs/epics/archived/<epic>/` - completed or closed epic history moved by
  `archive-epic`.
- `docs/knowledge/<concern>/` - current system knowledge maintained by
  `document-current-system`.
- `docs/adrs/` - important durable decisions captured by
  `document-decisions`.

## Delivery Process

Use this sequence for planned product or system changes:

```text
define-product-vision
  -> suggest-epics optional
  -> create-epic
  -> validate-epic
  -> suggest-stories optional
  -> add-story or add-bugfix
  -> validate-work-plan
  -> implement-work-item
  -> validate-implementation
  -> document-current-system
  -> archive-epic
```

`document-decisions` is used when a Product Vision, epic, story, bugfix, implementation, or
validation result exposes an important durable decision that future maintainers
must understand. It is not a mandatory step for every change.

## Workflow Variants

Cortex supports five planning entry points. Choose the variant that matches the
starting material and risk level, while preserving durable artifact types and
validation gates.

### Requirements-First

Use requirements-first when the work starts from desired behavior, product
feedback, stakeholder notes, a problem statement, or a feature idea. This is the
default Cortex flow:

```text
define-product-vision
  -> suggest-epics optional
  -> create-epic
  -> validate-epic
  -> suggest-stories optional
  -> add-story
  -> validate-work-plan
```

The Product Vision captures stable project-level product intent, audience,
goals, success signals, principles, constraints, non-goals, assumptions, and
open questions.
`suggest-epics` helps discover candidate delivery boundaries when needed.
`create-epic` turns one accepted focus into a durable active epic, and stories
turn one validated epic into executable value slices. `suggest-stories` helps
plan those value slices before story files are created.

Example prompts:

- "Use Cortex requirements-first to define the project Product Vision from this
  stakeholder note, then stop before creating epics: <paste note>"
- "Update the Product Vision for improving checkout retry behavior only if it
  changes durable product direction; otherwise suggest epic options."
- "Define the Product Vision for this project. Ask only for blocking
  clarifications and inspect the repo."

### Design-Informed

Use design-informed planning when the work starts from an existing technical
design, architecture sketch, pseudocode, migration plan, integration proposal,
or feasibility constraint. Start with `define-product-vision`, but treat the design as a
source to derive product intent, constraints, non-goals, assumptions, and open
questions before epic planning begins.

The Product Vision must distinguish behavior the design requires from implementation
details that belong in epics and child work items. If the design implies product
behavior that is not approved, record it as an open question or assumption
instead of silently turning it into scope.

Example prompts:

- "Use Cortex design-informed planning. Start from this architecture sketch,
  derive the product vision, and keep implementation details in the epic:
  <paste design>"
- "Update the Product Vision from this migration proposal. Separate required
  user-visible behavior from suggested implementation details: <paste proposal>"
- "I have a low-level design for rate limiting. Use it as input to define or
  update the Product Vision first, then recommend the next Cortex step."

### Quick Plan

Use quick plan only for well-understood, low-risk work where the user explicitly
wants to move quickly and the repository context is clear. Quick plan may run
`define-product-vision`, `create-epic`, and `add-story` in one continuous planning pass,
but it must still write all artifacts and leave validation sections accurate.

Validation gates are not skipped. If quick plan creates an epic or work items
before formal validation, their validation decisions remain `Pending` until
`validate-epic` and `validate-work-plan` are run, or until the user explicitly
accepts the risk of proceeding with an unvalidated plan. Quick plan can skip
`suggest-stories` when the next story is already obvious.

Example prompts:

- "Use Cortex quick plan for a small settings-page copy update. Use the existing
  Product Vision, then create the epic and story in one pass, leaving validation
  pending."
- "Quick-plan this straightforward API field rename. Inspect the repo first and
  write all Cortex artifacts before implementation."
- "Create a quick Cortex plan for adding a feature flag around the new banner.
  Keep scope narrow and stop before coding."

### Bugfix

Use bugfix planning when the work starts from defective behavior that should be
corrected surgically inside an active epic. Bugfixes do not create child epics;
the bugfix file owns current behavior, expected behavior, unchanged behavior,
root cause, fix boundary, implementation tasks, and regression verification.

```text
add-bugfix
  -> validate-work-plan
  -> implement-work-item
  -> validate-implementation
```

Bugfix work should include a failing reproduction test or deterministic repro
evidence before the fix whenever practical. If the bugfix changes the epic's
outcome, public contract, rollout, or material risk profile, update the epic and
re-run `validate-epic` before implementation.

Example prompts:

- "Use Cortex to add a bugfix for the invite expiry timezone issue under the
  account-invites epic."
- "Add a Cortex bugfix for this failing test, include unchanged behavior, and
  stop before implementation."
- "This active epic has a regression in checkout retry. Add a bugfix work item
  with root cause analysis and regression checks."

### Epic Extension

Use epic extension when an active epic needs more work after its initial stories
or bugfixes were created. Add a new `story_*.md` or `bugfix_*.md` instead of
rewriting existing child work. If the new work is outside the current epic
scope, update the epic and re-run `validate-epic` first.

## Process Stages

### 1. Define Product Intent

Use `define-product-vision` when work starts from an idea, business request, problem,
stakeholder note, design, screenshot, or unstructured feature ask.

The Product Vision defines durable project direction: vision, problem,
audience, goals, success signals, principles, constraints, non-goals,
assumptions, open questions, and references. It should stay strategic and avoid
feature scope, acceptance criteria, implementation details, verification plans,
dependencies, rollout plans, and risk registers. Those details belong in epics,
stories, and bugfixes.
There is only one Product Vision per project; update `docs/product-vision.md`
only when the stable product direction changes.

Output: `docs/product-vision.md`.

### 2. Suggest Epic Options

Use `suggest-epics` after the Product Vision is ready when the user wants brainstorming,
vision slicing, gap discovery, or candidate epic suggestions.

This skill reads the Product Vision, current system knowledge, existing active
epics, relevant archived epics, and archive summaries, then suggests candidate
end-to-end epic boundaries. Archived epics are used to avoid duplicating
completed, cancelled, superseded, or intentionally deferred work without making
that reopening explicit. It does not write epic files unless the user accepts a
specific suggestion and asks to proceed with `create-epic`.

Output: suggested epic candidates, Product Vision coverage notes, overlap risks,
dependencies, sequencing, assumptions, and open questions.

### 3. Create One Epic

Use `create-epic` after the Product Vision is ready and the user has selected one specific
delivery outcome to plan.

Each epic owns one independently buildable delivery outcome. The epic records
Product Vision coverage role, scope, current system context, concern impact, dependencies,
cross-epic relationships, risks, rollout, implementation strategy, assumptions,
open questions, and ADR candidates. The epic is a durable container; child
stories and bugfixes can be added over time.

Output: `docs/epics/active/<epic>/epic.md`.

### 4. Validate One Epic

Use `validate-epic` before adding child stories or bugfixes.

Validation checks exactly one active epic at a time. It confirms the epic
preserves the Product Vision intent for its selected focus, owns an end-to-end delivery
outcome, is not too technical, avoids unapproved scope, stays consistent with
concern knowledge, and has no blocking open questions. It does not validate
whole Product Vision coverage across all epics; use `suggest-epics` for broader
Product Vision gap discovery and candidate epic suggestions. A passing epic can accept stories and
bugfixes. A failed, partial, or blocked epic should be corrected before child
work items are created.

Output: updated `Epic Validation` section in the target `epic.md` file.

### 5. Suggest Story Options

Use `suggest-stories` after `validate-epic` when the user wants to plan the
story set needed to fulfill one active epic, find missing child-work coverage,
or choose the next independently implementable value slice.

This skill reads one active epic, its source Product Vision when present, existing stories
and bugfixes in the epic, concern knowledge, and relevant repository context. It
suggests candidate story boundaries without writing files. Accepted candidates
are created later with `add-story`, one story at a time. Defect fixes should be
routed to `add-bugfix`.

Output: suggested story candidates, epic coverage notes, overlap risks,
dependencies, sequencing, verification themes, assumptions, and open questions.

### 6. Add Stories Or Bugfixes

Use `add-story` or `add-bugfix` for exactly one work item inside a validated
active epic.

A story is a planned value slice inside the epic. A bugfix is corrective work
inside the epic. Each work item includes purpose, scope, non-scope,
implementation tasks, dependencies, verification steps, pass criteria, and
validation sections. Work items can be added later to extend an active epic
without rewriting existing child work.

Outputs:

- `docs/epics/active/<epic>/stories/story_<name>.md`
- `docs/epics/active/<epic>/bugfixes/bugfix_<name>.md`

### 7. Validate One Work Plan

Use `validate-work-plan` before implementation starts.

Validation checks that one story or bugfix plan fits the epic, preserves scope,
includes executable verification, and does not contradict the Product Vision, epic, concern
knowledge, or sibling work items. Passing work plans can feed
`implement-work-item`.

Output: updated `Work Item Validation` section in the selected story or bugfix.

### 8. Implement One Work Item

Use `implement-work-item` after `validate-work-plan` passes and the user wants
the work built. If the user explicitly asks to implement an unvalidated or
partially validated work item, record the override and risk before coding.

Implementation follows the `epic.md` and exactly one `story_*.md` or
`bugfix_*.md`. It should keep scope tight, follow repository conventions, update
implementation task checkboxes only when work is complete and task-level
verification has passed, and stop for approval before materially changing the
plan. Important durable design decisions discovered during implementation
should be captured with `document-decisions` when they meet ADR criteria.

Output: scoped code, test, migration, documentation, or configuration changes,
plus updated work item status where appropriate.

### 9. Validate Implementation

Use `validate-implementation` after implementation is complete or ready for objective
checking.

Validation checks implemented work against the written Product Vision when present, epic,
selected story or bugfix plan, implementation task verification steps,
verification matrix rows, and repository quality gates. It records pass, fail,
partial, blocked, skipped checks, command output, evidence, and gaps in the
selected work item file.

Output: updated `Final Validation`, `Verification Matrix`, and
`Validation Result` sections in the selected story or bugfix.

### 10. Update Current System Knowledge

Use `document-current-system` when `validate-implementation` returns `Pass`, when a
`Partial` result is explicitly approved for current-state documentation, or when
an existing system needs to be documented from evidence.

This skill writes living current-state knowledge, not feature history. It
extracts facts from code, tests, migrations, configuration, docs, operational
artifacts, and `Pass` or explicitly approved `Partial` validation evidence, then
routes each fact to the correct concern under `docs/knowledge/<concern>/`.

Output: created or updated concern specs.

### 11. Archive Completed Epics

Use `archive-epic` when implementation, validation, and system-state updates are
complete, or when an epic is intentionally closed.

Archiving writes a final summary, preserves validation evidence and decision
links, records deferred or cancelled work, and moves the epic folder from
`docs/epics/active/<epic>/` to `docs/epics/archived/<epic>/`.

Output: archived epic folder and archive summary.

## Validation Gates

The process has three explicit gates:

- `validate-epic` decides whether one active epic can accept stories and bugfixes.
- `validate-work-plan` decides whether one story or bugfix plan can feed
  implementation.
- `validate-implementation` decides whether implemented work satisfies the
  selected story or bugfix plan.

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
