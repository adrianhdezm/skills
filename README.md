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

## Existing Plugins

- Cortex - a concern-centric development process for planned product and system
  changes. Cortex turns product intent into PRDs, suggests epic options when
  needed, creates validated epics one at a time, adds independently validated
  stories and bugfixes inside those epics, implements one work item at a time,
  records validation evidence, updates durable system knowledge, and archives
  completed epic history. Read
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

- `create-prd` - define product intent.
- `suggest-epics` - suggest candidate epics from a PRD plus active and archived epics.
- `create-epic` - create one executable active epic plan.
- `validate-epic` - validate one active epic against the PRD.
- `add-story` - add one planned value slice to an active epic.
- `add-bugfix` - add one surgical bugfix to an active epic.
- `validate-work-item` - validate one story or bugfix before implementation.
- `implement-work-item` - implement one validated story or bugfix.
- `run-validation` - validate implementation against the written work item and quality gates.
- `document-current-system` - update living concern knowledge.
- `document-decisions` - capture important durable decisions as ADRs.
- `archive-epic` - preserve completed or closed epic history.
- `write-skill` - create or update Codex skills.
