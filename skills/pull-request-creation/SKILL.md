---
name: pull-request-creation
description: "Commits staged changes using Conventional Commits, pushes branch, and opens a GitHub Pull Request with structured template."
---

# Pull Request Creation Skill

## Purpose
Automates clean git commits, branch pushing, and GitHub PR creation linked to the originating issue.

## Procedure
1. **Conventional Commit**:
   - Stage modified files: `git add <files>`.
   - Commit: `git commit -m "<type>(<scope>): <summary>"`.
2. **Push to Remote**:
   - `git push -u origin <branch_name>`
3. **Assemble PR Body**:
   - Populate `templates/pr-description.md` with:
     - Issue summary and rationale.
     - Linked issue tag (`Fixes #<id>` or `Closes #<id>`).
     - PostgreSQL schema changes summary (if applicable).
     - Completed verification matrix.
4. **Create PR**:
   ```bash
   gh pr create --title "<type>(<scope>): <summary>" --body-file .devpilot/<KEY>/pr-body.md --base main
   ```
5. **Save Artifact**:
   - Write `.devpilot/<KEY>/pull-request.json` with PR URL, branch name, and commit SHA.
