# Cortex

Cortex is a concern-centric development process for product and system changes.
It turns product intent into a single Product Vision, routes incoming work to
the right planning artifact, validates written plans, implements one story or
bugfix at a time, records validation evidence, updates current system
knowledge, and archives completed delivery history.

The skills are designed to be used in order. Each artifact becomes the source of
truth for the next step, and each validation skill checks the written artifact
instead of relying on memory or conversation context.

Use Cortex by first identifying the project state, then choosing the matching
workflow for the change.

## Choose The Project State

### Greenfield Project

Use this when the repository, product, or product area is being created with
Cortex from the beginning.

Greenfield work starts by defining the Product Vision, then turns that vision
into epics, stories, implementation, validated current-system knowledge, and
archived delivery history.

### Brownfield Project Already Using Cortex

Use this when the repository already has Cortex artifacts such as
`docs/vision.md`, `docs/knowledge/`, active or archived epics, stories,
bugfixes, standalone changes, or ADRs.

Brownfield work starts from the existing Product Vision, active delivery plans,
archived history, and current-system knowledge. New work should preserve the
existing artifact chain instead of creating parallel planning records.

### Brownfield Project Not Yet Using Cortex

Use this when the repository already contains meaningful implementation, but no
Cortex artifact history.

This onboarding path documents the current product and system state. It does not
reconstruct past delivery history.

## Workflows

### 1. Start A Greenfield Project

Use this flow for a new project or product area where Cortex owns the delivery
process from the beginning.

```text
define-product-vision
  -> suggest-epics
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

Notes:

- `define-product-vision` creates `docs/vision.md` from the initial product
  intent, user goals, constraints, assumptions, non-goals, and open questions.
- `suggest-epics` should be used to discover candidate delivery boundaries
  before selecting the first epic.
- `suggest-stories` can be used after an epic passes validation, and again any
  time while the epic is active, to read existing stories and bugfixes and
  suggest remaining story coverage for the epic goals.
- `archive-epic` is used only after implementation, validation, and
  current-system documentation are complete, or when the epic is intentionally
  closed.

### 2. Onboard A Brownfield Project Without Cortex

Use this flow when substantial code already exists, but Cortex has not been used
yet.

```text
define-product-vision
  -> document-current-system
```

This flow creates the durable baseline that future Cortex changes will use.
`define-product-vision` captures current product direction from repository
evidence, existing docs, and user input. `document-current-system` documents the
implemented system under `docs/knowledge/<concern>/`.

Do not invent delivery history:

- Do not create archived epics for work that was not planned through Cortex.
- Do not create retroactive stories or bugfixes for already completed work.
- Do not create ADRs unless repository evidence exposes an important durable
  decision that is still relevant to future maintainers.
- Do not run `suggest-epics` during onboarding; stop after current-system
  knowledge is documented.

After onboarding, future changes should use the brownfield workflows below.

### 3. Add A New Product Feature

Use this flow in a brownfield project when the requested feature is a meaningful
new delivery outcome.

```text
define-product-vision if durable product direction changes
  -> suggest-epics optional
  -> create-epic
  -> validate-epic
  -> suggest-stories optional
  -> add-story
  -> validate-change-plan
  -> implement-change
  -> validate-implementation
  -> document-current-system
  -> archive-epic when complete
```

Use `define-product-vision` only when the feature changes stable product
direction. If the Product Vision already covers the feature, start from epic
planning.

Use `suggest-epics` when the delivery boundary is unclear, when multiple epics
could satisfy the request, or when the feature may overlap archived or active
work. Skip it when the user has already selected a specific epic outcome.

Use `suggest-stories` after `validate-epic` when the remaining story coverage is
unclear, when existing child work needs coverage review, or when the user wants
candidate value slices before creating story files. Skip it when the next story
or bugfix is already specific.

### 4. Implement An Existing Cortex Story Or Bugfix

Use this flow when the planning artifact already exists and the user wants the
work built.

```text
validate-change-plan if not already passing
  -> implement-change
  -> validate-implementation
  -> document-current-system
  -> archive-epic when epic is complete
```

Implementation follows exactly one `story_*.md` or `bugfix_*.md`, plus
`epic.md` for epic-scoped work. If implementation discovers that the plan is
wrong, incomplete, or materially risky, update the plan and re-run validation
before continuing unless the user explicitly accepts the risk of proceeding.

### 5. Plan And Execute A Small Change

Use this flow when the user brings one concrete request and it is not yet clear
whether it belongs to an active epic, should be standalone, is corrective work,
or needs a new epic.

```text
plan-change
  -> add-story or add-bugfix under an active epic, or
  -> add-story or add-bugfix under docs/standalone-changes/active/, or
  -> create-epic when the change is larger than expected

then:
  -> validate-change-plan
  -> implement-change
  -> validate-implementation
  -> document-current-system
  -> archive-epic when epic is complete
```

`plan-change` is a router, not the complete process. It inspects the Product
Vision, active epics, standalone changes, current-system knowledge, and relevant
repository context. It records whether the request is planned value or
corrective work, whether it fits an active epic, whether Product Vision work is
needed first, and where the artifact should be written.

Standalone changes are allowed only when the request is self-contained, does not
belong to a current active epic, and does not justify a new epic.

### 6. Increase Scope Or Add Missing Work To An Existing Epic

Use this flow when an active epic exists but needs more child work, such as a
missing value slice, a scope increase, or a defect discovered while the epic is
still active.

```text
confirm epic fit
  -> update epic and validate-epic if scope changes
  -> suggest-stories optional
  -> add-story or add-bugfix
  -> validate-change-plan
  -> implement-change
  -> validate-implementation
  -> document-current-system
  -> archive-epic when complete
```

Add a new `story_*.md` or `bugfix_*.md` instead of rewriting completed child
work. If the new work changes the epic outcome, public contract, rollout,
dependencies, or material risk profile, update `epic.md` and re-run
`validate-epic` before adding the child artifact.

Use `suggest-stories` when the missing work is not yet clearly bounded or when
the epic needs coverage review against existing stories and bugfixes. Skip it
when the next story or bugfix is already specific.

## Skill Reference

### Product Vision

Use `define-product-vision` when work starts from an idea, business request,
problem, stakeholder note, design, screenshot, existing repository, or
unstructured feature ask.

The Product Vision defines durable project direction: vision, problem,
audience, goals, success signals, principles, constraints, non-goals,
assumptions, open questions, and references. It should stay strategic and avoid
feature scope, acceptance criteria, implementation details, verification plans,
dependencies, rollout plans, and risk registers. Those details belong in epics,
stories, and bugfixes.

There is only one Product Vision per project. Update `docs/vision.md` only when
the stable product direction changes.

### Epic Planning

Use `suggest-epics` after the Product Vision is ready when the user wants
brainstorming, vision slicing, gap discovery, or candidate epic suggestions.
It suggests candidate delivery boundaries; it does not write epic files.

Use `create-epic` after the user has selected one specific delivery outcome.
Each epic owns one independently buildable delivery outcome and records Product
Vision coverage, scope, current-system context, concern impact, dependencies,
risks, rollout, implementation strategy, assumptions, open questions, and ADR
candidates.

Use `validate-epic` before adding child stories or bugfixes. A passing epic can
accept child work. A failed, partial, or blocked epic should be corrected before
child artifacts are created.

### Story And Bugfix Planning

Use `suggest-stories` after `validate-epic`, and any time while the epic remains
active, when the user wants to plan the story set needed to fulfill one active
epic, find missing child-work coverage against existing stories and bugfixes, or
choose the next independently implementable value slice. It suggests story
boundaries; it does not write story files.

Use `add-story` or `add-bugfix` for exactly one story or bugfix inside a
validated active epic or under `docs/standalone-changes/active/`.

A story is a planned value slice. A bugfix is corrective work. Each artifact
includes purpose, scope, non-scope, implementation tasks, dependencies,
verification steps, pass criteria, and validation sections.

### Validation And Implementation

Use `validate-change-plan` before implementation starts. It checks that one
story or bugfix fits its placement, preserves scope, includes executable
verification, and does not contradict the Product Vision, active epic when
present, concern knowledge, or sibling work.

Use `implement-change` after `validate-change-plan` passes and the user wants
the work built. If the user explicitly asks to implement an unvalidated or
partially validated change plan, record the override and risk before coding.

Use `validate-implementation` after implementation is complete or ready for
objective checking. It records pass, fail, partial, blocked, skipped checks,
command output, evidence, and remaining gaps in the selected story or bugfix
file.

### Knowledge And History

Use `document-current-system` when `validate-implementation` returns `Pass`,
when a `Partial` result is explicitly approved for current-state documentation,
or when an existing system needs to be documented from evidence.

`document-current-system` writes living current-state knowledge, not feature
history. It extracts facts from code, tests, migrations, configuration, docs,
operational artifacts, and validation evidence, then routes each fact to the
correct concern under `docs/knowledge/<concern>/`.

Use `archive-epic` when implementation, validation, and current-system updates
are complete, or when an epic is intentionally closed. Archiving writes a final
summary, preserves validation evidence and decision links, records deferred or
cancelled work, and moves the epic folder from `docs/epics/active/<epic>/` to
`docs/epics/archived/<epic>/`.

Standalone changes do not use an archive workflow. After validation and any
required current-system documentation, leave the standalone change artifact as
the durable planning and validation record.

## Artifact Layout

Generated project artifacts are written into the target repository that is being
planned or changed, not into the skills repository:

- `docs/vision.md` - the single project-level product vision created or
  updated by `define-product-vision`.
- `docs/epics/active/<epic>/epic.md` - active epic plans created by
  `create-epic`.
- `docs/epics/active/<epic>/story_<name>.md` - planned value slices added by
  `add-story`.
- `docs/epics/active/<epic>/bugfix_<name>.md` - surgical defect fixes added by
  `add-bugfix`.
- `docs/epics/archived/<epic>/` - completed or closed epic history moved by
  `archive-epic`.
- `docs/standalone-changes/active/story_<name>.md` - planned value slices that
  do not belong to a current active epic and do not need a new epic.
- `docs/standalone-changes/active/bugfix_<name>.md` - surgical defect fixes
  that do not belong to a current active epic and do not need a new epic.
- `docs/knowledge/<concern>/` - current system knowledge maintained by
  `document-current-system`.
- `docs/adrs/` - important durable decisions captured by
  `document-decisions`.

## Validation Gates

The process has three explicit gates:

- `validate-epic` decides whether one active epic can accept stories and
  bugfixes.
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

Gate transitions:

- `validate-epic`:
  - `Pass` allows `suggest-stories`, `add-story`, and `add-bugfix`.
  - `Fail` or `Blocked` must be corrected before child artifacts are created.
  - `Partial` does not allow child artifacts unless the user explicitly accepts
    the documented gaps and the child work does not depend on them.
- `validate-change-plan`:
  - `Pass` allows `implement-change`.
  - `Fail`, `Partial`, or `Blocked` should be corrected before implementation.
  - A user may explicitly override a missing or non-passing result; record the
    override and risk in the selected story or bugfix before coding.
- `validate-implementation`:
  - `Pass` allows `document-current-system` and epic completion checks.
  - `Partial` allows `document-current-system` or epic closure only when the
    user explicitly approves the remaining gaps and the documented facts are
    true current system state.
  - `Fail` or `Blocked` should return to `implement-change`,
    `validate-change-plan`, or the owning artifact skill before current-system
    documentation or epic closure.

## Decision Records

Use `document-decisions` when a Product Vision, epic, standalone change, story,
bugfix, implementation, or validation result exposes an important durable
decision that future maintainers must understand.

Use ADRs especially for durable decisions about architecture, data models,
execution models, API shape, integration strategy, test isolation, concurrency,
consistency, performance, security, or operations.

Do not write ADRs for routine implementation notes, transient choices, local
file layout, naming details, decisions already dictated by existing conventions,
or choices with only one viable option.

Important durable decisions live as ADRs under `docs/adrs/`. Repository naming
and code conventions should be extracted into
`docs/knowledge/engineering/conventions.md` by default, or into
`docs/knowledge/architecture/<topic>.md` when they define architecture,
ownership, or cross-system contracts.

## Knowledge Concerns

Use these explicit concerns when adding current-system knowledge:

- `product`: capabilities, features, user value, and product behavior.
- `platform`: reusable services, shared libraries, internal platforms, and
  developer-facing capabilities.
- `engineering`: code organization, naming, style, test patterns, tooling, and
  contributor workflow.
- `architecture`: components, flows, boundaries, interfaces, dependencies, and
  patterns.
- `security`: authentication, authorization, data protection, privacy, audit,
  and threat controls.
- `operations`: monitoring, alerts, runbooks, SLOs, support procedures, and
  failure handling.
- `infrastructure`: environments, networks, databases, queues, storage,
  compute, and managed resources.

Ownership rules:

- `product` owns user-visible behavior and value.
- `platform` owns reusable internal capabilities.
- `engineering` owns contributor conventions, tests, tooling, and workflow.
- `architecture` owns runtime structure, interfaces, boundaries, and flows.
- `security` owns protection rules and threat controls.
- `operations` owns monitoring, support, recovery, and operating procedures.
- `infrastructure` owns provisioned resources and environments.

## Clarification Policy

Skills should ask only when the answer can change validation safety, required
environment, credentials, data, thresholds, ownership, scope, sequencing, risk,
or the final decision.

If the answer can be discovered from repository context, existing planning
artifacts, concern specs, documentation, or code, inspect that evidence instead.
If ambiguity is non-blocking, proceed with a clear assumption and record it in
the relevant artifact.
