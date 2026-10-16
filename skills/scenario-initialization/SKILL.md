---
name: scenario-initialization
description: "Verifies project prerequisites, git clean state, and bootstraps .devpilot/config.json from template if missing."
---

# Scenario Initialization Skill

## Purpose
Validates that the project repository is ready for autonomous execution and bootstraps necessary configuration files.

## Procedure
1. **Config Verification**:
   - Check if `.devpilot/config.json` exists in the repository root.
   - If not found, copy `config/devpilot.config.example.json` to `.devpilot/config.json`.
   - Ensure `.devpilot/` is added to `.gitignore` so local workflow runtime data is not committed to git.
2. **Git Status Check**:
   - Run `git status --porcelain`.
   - If uncommitted changes exist on the current branch, warn the developer and prompt them to stash or commit before proceeding.
3. **Database Connection Verification (PostgreSQL)**:
   - Check if `DATABASE_URL` is set or if connection parameters exist in `.devpilot/config.json`.
   - If PostgreSQL is configured, perform a lightweight check (e.g. `psql -c "SELECT 1;"` or inspect schema) to ensure database connectivity.
4. **GitHub Authentication Check**:
   - If `gh` CLI is available, test with `gh auth status`.
   - If using `GITHUB_TOKEN`, verify token environment variable.
