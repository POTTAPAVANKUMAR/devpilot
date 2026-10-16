---
name: codebase-analyst
description: "Performs deep contextual analysis of the repository returning exact file:line references, AST structures, and dependency graphs."
---

# Codebase Analyst Skill

## Purpose
Examines relevant code paths in depth to determine exactly which functions, classes, interfaces, or tables must be modified.

## Guidelines
- Always return exact `path/to/file:line_number` references.
- Map out the call graph from request handler / controller down to the database query / repository.
- Identify existing models, DTOs, schemas, and validators.
- Look for existing tests covering the affected areas.
