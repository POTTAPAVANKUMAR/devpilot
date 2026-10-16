---
name: planning
description: "Generates an exhaustive, deterministic, step-by-step implementation plan covering file creations, modifications, SQL migrations, and test commands."
---

# Planning Skill

## Purpose
Transforms findings from research and task breakdown into an exact blueprint before writing any code.

## Rules
- Every plan step must identify:
  - Exact file path to be created or modified.
  - Functions, types, or SQL DDL statements to add/change.
  - Rationale and dependencies.
- Include a specific section for **Database Changes (PostgreSQL)**:
  - Migration filename (e.g. `migrations/003_add_session_table.sql`).
  - DDL schema and index declarations.
  - Rollback script / down migration.
- Define the test commands that will validate each step.
- Output file: `.devpilot/<KEY>/planning.md`.
