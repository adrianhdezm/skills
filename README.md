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
  changes. Cortex turns product intent into PRDs, slices PRDs into validated
  epics, breaks epics into executable tasks, implements those tasks, records
  validation evidence, updates durable system knowledge, and archives completed
  epic history. Read [CORTEX.md](CORTEX.md) for the full process.

## Skills

- `create-prd` - define product intent.
- `create-epics` - slice a PRD into executable epic plans.
- `validate-epics` - validate epics against the PRD.
- `create-tasks` - break one validated epic into implementation tasks.
- `validate-tasks` - validate task coverage and verification.
- `implement-tasks` - implement task plans after `validate-tasks` passes, or after an explicit user override.
- `run-validation` - validate implementation against the written task plan and quality gates.
- `document-current-system` - update living concern knowledge.
- `document-decisions` - capture important durable decisions as ADRs.
- `archive-epic` - preserve completed or closed epic history.
- `write-skill` - create or update Codex skills.
