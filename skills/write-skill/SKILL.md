---
name: write-skill
description: Create new agent skills with proper structure, progressive disclosure, and bundled resources. Use when the user wants to create, write, build, or update a skill.
---

# Write Skill

## Core Rule

Keep `SKILL.md` concrete: core workflow, trigger-specific guidance, and validation checklist only. If it approaches or exceeds 100 lines, move details into one-level support files and link to them from `SKILL.md`.

Use progressive disclosure: keep essential instructions in `SKILL.md`, and load detailed references, scripts, or assets only when needed.

## Process

1. Gather requirements:
   - What task or domain does the skill cover?
   - What use cases should it handle?
   - Does it need executable scripts or just instructions?
   - Are there reference materials to include?
   - Are there templates or other assets the agent should reuse?

2. Draft the skill:
   - Create `SKILL.md` with concise instructions.
   - Use support files only when they keep `SKILL.md` concrete or make the skill more reliable.
   - Use the starter template in [references/templates.md](references/templates.md) when helpful.

3. Review with the user:
   - Does this cover the intended use cases?
   - Is anything missing or unclear?
   - Should any section be more or less detailed?

## Skill Structure

```text
my-skill/
|-- SKILL.md          # Required: metadata + instructions
|-- agents/           # Recommended: UI metadata
|-- scripts/          # Optional: executable code
|-- references/       # Optional: documentation
|-- assets/           # Optional: templates, resources
`-- ...               # Any additional files or directories
```

## Description Requirements

The description is the only thing the agent sees when deciding whether to load the skill. Write it so the agent can identify:
- What capability the skill provides.
- When or why to trigger it, including specific keywords, contexts, or file types.

Description format:
- Maximum 1024 characters.
- Write in third person.
- First sentence: what the skill does.
- Second sentence: `Use when [specific triggers].`

Good example: `Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.`

Bad example: `Helps with documents.`

## Additional Files

Choose support files by purpose:
- Use `agents/openai.yaml` for UI metadata when the skill should appear in skill lists or chips.
- Use `references/` for documentation the agent may need to read, such as schemas, policies, API notes, long examples, or advanced workflows.
- Use `scripts/` for executable helpers when an operation is deterministic, repeated, fragile, or needs explicit error handling.
- Use `assets/` for files the agent should reuse in outputs, such as templates, images, icons, fonts, or boilerplate projects.
- Use lowercase semantic names. Prefer hyphen-case for docs and assets, such as `references/finance-schema.md`; use snake_case when it matches language or project conventions, such as `scripts/validate_schema.py`.

Do not add support files just to add structure. Avoid vague names such as `REFERENCE.md`, `NOTES.md`, or `misc.md`; prefer names that state the content or use case. Keep conventional names like `README.md` only when the surrounding project expects them. Keep references one level deep from `SKILL.md`.

## Review Checklist

- [ ] Description includes triggers with `Use when...`.
- [ ] `SKILL.md` is under 100 lines.
- [ ] No time-sensitive information.
- [ ] Consistent terminology.
- [ ] Concrete examples included when useful.
- [ ] Support files use the correct folder and lowercase semantic names.
- [ ] References are linked from `SKILL.md` and one level deep.
