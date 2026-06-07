# Cortex

Cortex is a concern-centric development process for planned product and system
changes. It turns product intent into a single Product Vision, plans incoming
changes, suggests epic and story options when decomposition is needed, creates
validated epics one at a time, adds independently validated stories and bugfixes
inside those epics or as standalone changes, implements one story or bugfix at a time,
records validation evidence, updates durable system knowledge, and archives
completed history.

The skills are designed to be used in order. Each planning artifact becomes the
source of truth for the next step, and each validation skill checks the written
artifact instead of relying on memory or conversation context.

## Artifact Layout

Generated project artifacts are written into the target repository that is being
planned or changed, not into the skills repository:

- `docs/vision.md` - the single project-level product vision created or
  updated by `define-product-vision`.
- `docs/epics/active/<epic>/epic.md` - active epic plans created by
  `create-epic`.
- `docs/epics/active/<epic>/story_<name>.md` - planned value slices
  added by `add-story`.
- `docs/epics/active/<epic>/bugfix_<name>.md` - surgical defect fixes
  added by `add-bugfix`.
- `docs/epics/archived/<epic>/` - completed or closed epic history moved by
  `archive-epic`.
- `docs/standalone-changes/active/story_<name>.md` - planned value
  slices that do not belong to a current active epic and do not need a new epic.
- `docs/standalone-changes/active/bugfix_<name>.md` - surgical defect
  fixes that do not belong to a current active epic and do not need a new epic.
- `docs/standalone-changes/archived/` - completed or closed standalone change
  history.
- `docs/knowledge/<concern>/` - current system knowledge maintained by
  `document-current-system`.
- `docs/adrs/` - important durable decisions captured by
  `document-decisions`.

## Delivery Process

Use this sequence for planned product or system changes:

```text
define-product-vision
  -> plan-change optional
  -> suggest-epics optional
  -> create-epic
  -> validate-epic
  -> suggest-stories optional
  -> add-story or add-bugfix
  -> validate-change-plan
  -> implement-change
  -> validate-implementation
  -> document-current-system
  -> archive-epic
```

`document-decisions` is used when a Product Vision, epic, standalone change,
story, bugfix, implementation, or validation result exposes an important
durable decision that future maintainers must understand. It is not a mandatory
step for every change.

For concrete incoming change requests where epic fit is unclear, use this
shorter routing sequence:

```text
plan-change
  -> create-epic when a new delivery outcome is needed
  -> add-story or add-bugfix under an active epic
  -> add-story or add-bugfix under docs/standalone-changes/active/

then:
  -> validate-change-plan
  -> implement-change
  -> validate-implementation
```

## Workflow Variants

Cortex supports seven planning entry points. Choose the variant that matches the
starting material and risk level, while preserving durable artifact types and
validation gates.

### Change Planning

Use change planning when the user brings one concrete request and it is not yet
clear whether the request belongs to an active epic, should be a standalone
story or bugfix, or needs a new epic.

```text
plan-change
  -> create-epic, or
  -> add-story or add-bugfix under an active epic, or
  -> add-story or add-bugfix under docs/standalone-changes/active/

then:
  -> validate-change-plan
```

`plan-change` inspects Product Vision, active epics, standalone changes, concern
knowledge, and relevant repository context. It classifies the request as planned
value or corrective work, checks active epic fit, checks Product Vision impact,
and decides whether an epic is needed. Standalone changes are allowed only when
the request is self-contained, outside active epic scope, and does not require a
new epic.

Example prompts:

- "Use Cortex to plan this small settings-page copy change. If it does not fit
  an active epic, create a standalone story."
- "Plan this failing test as a Cortex change. Route it to the right active epic
  or standalone bugfix before implementation."
- "Use `plan-change` to decide whether this request needs an epic or can be a
  standalone change: <paste request>"

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
  -> validate-change-plan
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
details that belong in epics and child stories or bugfixes. If the design implies product
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
`define-product-vision`, `plan-change`, `create-epic`, and `add-story` in one
continuous planning pass, but it must still write all artifacts and leave
validation sections accurate.

Validation gates are not skipped. If quick plan creates an epic, stories, or bugfixes
before formal validation, their validation decisions remain `Pending` until
`validate-epic` and `validate-change-plan` are run, or until the user explicitly
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
corrected surgically inside an active epic or as a standalone change. Bugfixes
do not create child epics; the bugfix file owns current behavior, expected
behavior, unchanged behavior, root cause, fix boundary, implementation tasks,
and regression verification.

```text
add-bugfix
  -> validate-change-plan
  -> implement-change
  -> validate-implementation
```

Bugfix work should include a failing reproduction test or deterministic repro
evidence before the fix whenever practical. If an epic-scoped bugfix changes the
epic's outcome, public contract, rollout, or material risk profile, update the
epic and re-run `validate-epic` before implementation. If a standalone bugfix
needs coordinated rollout, multiple stories or bugfixes, or durable Product Vision
change, route it through `plan-change` before implementation.

Example prompts:

- "Use Cortex to add a bugfix for the invite expiry timezone issue under the
  account-invites epic."
- "Add a Cortex bugfix for this failing test, include unchanged behavior, and
  stop before implementation."
- "This active epic has a regression in checkout retry. Add a bugfix
  with root cause analysis and regression checks."

### Epic Extension

Use epic extension when an active epic needs more work after its initial stories
or bugfixes were created. Add a new `story_*.md` or `bugfix_*.md` instead of
rewriting existing child work. If the new work is outside the current epic
scope, update the epic and re-run `validate-epic` first.

### Standalone Change

Use standalone change planning when `plan-change` determines a story or bugfix is
self-contained, does not belong to a current active epic, and does not justify a
new epic. Standalone changes still need a written story or bugfix, a routing
decision, `validate-change-plan`, `implement-change`, and
`validate-implementation`.

Outputs:

- `docs/standalone-changes/active/story_<name>.md`
- `docs/standalone-changes/active/bugfix_<name>.md`

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
There is only one Product Vision per project; update `docs/vision.md`
only when the stable product direction changes.

Output: `docs/vision.md`.

### 2. Plan One Change

Use `plan-change` when one incoming request may be too small for an epic, may
belong to an active epic, may be a bugfix, or may require a new epic before
story or bugfix planning.

This skill reads the Product Vision, active epics, existing standalone changes,
concern knowledge, and relevant repository evidence. It routes the request to
`create-epic`, `add-story`, or `add-bugfix`. When durable Product Vision work is
needed first, it recommends `define-product-vision` and leaves the route
unselected until product direction is updated. It does not replace the
artifact-writing skills; it records the planning path and target placement so
the next skill can write the right artifact.

Output: routing decision, recommended next skill, and target path shape.

### 3. Suggest Epic Options

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

### 4. Create One Epic

Use `create-epic` after the Product Vision is ready and the user has selected one specific
delivery outcome to plan.

Each epic owns one independently buildable delivery outcome. The epic records
Product Vision coverage role, scope, current system context, concern impact, dependencies,
cross-epic relationships, risks, rollout, implementation strategy, assumptions,
open questions, and ADR candidates. The epic is a durable container; child
stories and bugfixes can be added over time.

Output: `docs/epics/active/<epic>/epic.md`.

### 5. Validate One Epic

Use `validate-epic` before adding child stories or bugfixes.

Validation checks exactly one active epic at a time. It confirms the epic
preserves the Product Vision intent for its selected focus, owns an end-to-end delivery
outcome, is not too technical, avoids unapproved scope, stays consistent with
concern knowledge, and has no blocking open questions. It does not validate
whole Product Vision coverage across all epics; use `suggest-epics` for broader
Product Vision gap discovery and candidate epic suggestions. A passing epic can accept stories and
bugfixes. A failed, partial, or blocked epic should be corrected before child
stories or bugfixes are created.

Output: updated `Epic Validation` section in the target `epic.md` file.

### 6. Suggest Story Options

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

### 7. Add Stories Or Bugfixes

Use `add-story` or `add-bugfix` for exactly one story or bugfix inside a validated
active epic or under `docs/standalone-changes/active/`.

A story is a planned value slice. A bugfix is corrective work. Each artifact
includes purpose, scope, non-scope, implementation tasks, dependencies,
verification steps, pass criteria, and validation sections. Epic-scoped work can
be added later to extend an active epic without rewriting existing child work.
Standalone work must include a routing decision explaining why it does not
belong to an active epic and does not need a new epic.

Outputs:

- `docs/epics/active/<epic>/story_<name>.md`
- `docs/epics/active/<epic>/bugfix_<name>.md`
- `docs/standalone-changes/active/story_<name>.md`
- `docs/standalone-changes/active/bugfix_<name>.md`

### 8. Validate One Change Plan

Use `validate-change-plan` before implementation starts.

Validation checks that one story or bugfix plan fits its selected placement,
preserves scope, includes executable verification, and does not contradict the
Product Vision, active epic when present, concern knowledge, or sibling work
stories or bugfixes. Passing change plans can feed `implement-change`.

Output: updated `Change Plan Validation` section in the selected story or bugfix.

### 9. Implement One Change

Use `implement-change` after `validate-change-plan` passes and the user wants
the work built. If the user explicitly asks to implement an unvalidated or
partially validated change plan, record the override and risk before coding.

Implementation follows exactly one `story_*.md` or `bugfix_*.md`, plus
`epic.md` for epic-scoped work. It should keep scope tight, follow repository
conventions, update implementation task checkboxes only when work is complete
and task-level verification has passed, and stop for approval before materially
changing the plan. Important durable design decisions discovered during
implementation should be captured with `document-decisions` when they meet ADR
criteria.

Output: scoped code, test, migration, documentation, or configuration changes,
plus updated story or bugfix status where appropriate.

### 10. Validate Implementation

Use `validate-implementation` after implementation is complete or ready for objective
checking.

Validation checks implemented work against the written Product Vision when
present, active epic when present, selected story or bugfix plan, implementation
task verification steps, verification matrix rows, and repository quality gates.
It records pass, fail, partial, blocked, skipped checks, command output,
evidence, and gaps in the selected story or bugfix file.

Output: updated `Final Validation`, `Verification Matrix`, and
`Validation Result` sections in the selected story or bugfix.

### 11. Update Current System Knowledge

Use `document-current-system` when `validate-implementation` returns `Pass`, when a
`Partial` result is explicitly approved for current-state documentation, or when
an existing system needs to be documented from evidence.

This skill writes living current-state knowledge, not feature history. It
extracts facts from code, tests, migrations, configuration, docs, operational
artifacts, and `Pass` or explicitly approved `Partial` validation evidence, then
routes each fact to the correct concern under `docs/knowledge/<concern>/`.

Output: created or updated concern specs.

### 12. Archive Completed History

Use `archive-epic` when implementation, validation, and system-state updates are
complete, or when an epic is intentionally closed.

Archiving writes a final summary, preserves validation evidence and decision
links, records deferred or cancelled work, and moves the epic folder from
`docs/epics/active/<epic>/` to `docs/epics/archived/<epic>/`.

Completed standalone changes may be moved from `docs/standalone-changes/active/`
to `docs/standalone-changes/archived/` after validation and any required
current-system documentation. They do not require `archive-epic` unless the
project adds a dedicated standalone archive skill.

Output: archived epic folder and archive summary.

## Validation Gates

The process has three explicit gates:

- `validate-epic` decides whether one active epic can accept stories and bugfixes.
- `validate-change-plan` decides whether one story or bugfix plan can feed
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
