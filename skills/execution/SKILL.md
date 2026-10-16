---
name: execution
description: "Executes the deterministic implementation plan step by step in the isolated worktree or branch, writing code, migrations, and tests."
---

# Execution Skill

## Purpose
Carries out the concrete edits described in `planning.md` strictly within the isolated workspace.

## Execution Rules
1. **One Step at a Time**: Complete each step sequentially.
2. **Preserve Integrity**: Retain existing docstrings, formatting styles, and surrounding code.
3. **Database Migrations First**: When changing schema, create and test the migration file first before modifying repositories or models that depend on it.
4. **Immediate Compilation Check**: After completing a module or file, verify syntax or run type checking to catch errors early.
5. **No Direct Master Commits**: Always verify you are on the isolated feature branch (`git branch --show-current`).
