# Skills

This repository contains Codex skills for developing software with agents.
Skills package repeatable workflows, templates, and guidance so agents can
perform specialized work consistently across repositories.

The repository can also group related skills into named processes or plugins.
Each plugin describes when its skills should be used together and where to find
the supporting process documentation.

## Repository Layout

- `skills/<skill>/SKILL.md` - trigger guidance, workflow, and validation rules
  for each skill.
- `skills/<skill>/references/` - templates, clarification policies, and support
  documentation loaded only when needed.
- `skills/<skill>/agents/openai.yaml` - optional UI metadata for showing skills
  in Codex.
- `scripts/` - repository maintenance checks, including Cortex consistency
  validation.

## Existing Plugins

- Cortex - a concern-centric development process for planned product and system
  changes. Cortex turns product intent into a single Product Vision, suggests
  epic and story options when needed, plans incoming changes, creates validated
  epics one at a time, adds ready or blocked stories and bugfixes inside those
  epics or as standalone changes, implements one ready or partially implemented
  story or bugfix at a time,
  records validation evidence, updates durable system knowledge, and archives
  completed history. Read
  [CORTEX.md](CORTEX.md) for the full process.

## Install From GitHub

Cortex is distributed through the repo marketplace at
`.agents/plugins/marketplace.json`.

```bash
codex plugin marketplace add adrianhdezm/skills --ref main
```

After adding the marketplace, restart Codex and install Cortex from the Built
by ADH marketplace.

## Skills

- `define-product-vision` - define the single project Product Vision.
- `plan-change` - route one incoming change to an epic, story, bugfix, or standalone change.
- `suggest-epics` - suggest candidate epics from the Product Vision plus active and archived epics.
- `create-epic` - create one executable active epic plan.
- `validate-epic` - validate one active epic against the Product Vision.
- `suggest-stories` - suggest candidate stories for one active epic.
- `add-story` - add one planned value slice to an active epic or standalone changes.
- `add-bugfix` - add one surgical bugfix to an active epic or standalone changes.
- `validate-change-plan` - validate one story or bugfix plan before implementation.
- `implement-change` - implement one ready or partially implemented story or bugfix.
- `validate-implementation` - validate review-state work against the plan and quality gates.
- `document-current-system` - update living concern knowledge.
- `document-decisions` - capture important durable decisions as ADRs.
- `archive-epic` - preserve completed or closed epic history.
- `write-skill` - create or update Codex skills.
