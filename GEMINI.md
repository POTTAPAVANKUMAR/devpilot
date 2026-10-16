# DevPilot - Project Rules

This repository contains the **DevPilot** SDLC orchestration plugin for Google Antigravity CLI (`agy`), optimized for GitHub repositories and PostgreSQL databases.

## Invariants & Guidelines

- **Architecture**: Antigravity Plugin with `agents/`, `skills/`, `rules/`, `hooks.json`, and `mcp_config.json`.
- **Git Isolation**: Never commit code directly to `main`/`master`. Always isolate changes in dedicated feature branches (`feature/gh-{id}-{slug}`) or worktrees.
- **PostgreSQL Safety**:
  - Always enforce parameterized queries ($1, $2, :param).
  - Schema migrations must be idempotent (`IF NOT EXISTS`) and wrapped in explicit transactions (`BEGIN; ... COMMIT;`).
  - Index all foreign keys to prevent table locking during parent updates/deletions.
- **GitHub Workflow**:
  - Conventional Commits (`type(scope): description`).
  - Traceable PRs linked to GitHub issues (`Fixes #12`).
  - Validation test suite and database migration checks must pass before opening a PR.
