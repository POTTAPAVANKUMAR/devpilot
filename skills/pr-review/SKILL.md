---
name: pr-review
description: "Orchestrates comprehensive review of a GitHub Pull Request against linked issue criteria, database migration safety, and architectural guidelines."
---

# Pull Request Review Skill

## Purpose
Fetches a GitHub PR's full context (metadata, diff, modified files) and runs an objective, staff-engineer-level review.

## Review Stages
1. **Context Acquisition**:
   - `gh pr view <PR_NUMBER> --json title,body,baseRefName,headRefName,commits,files`
   - `gh pr diff <PR_NUMBER>`
   - Extract linked GitHub Issue (e.g. `Fixes #14`) and fetch issue acceptance criteria.
2. **Deep Technical Review**:
   - Verify that all acceptance criteria from the issue are met.
   - If PostgreSQL migrations are included:
     - Verify transaction safety.
     - Verify index coverage.
     - Verify rollback safety.
   - Code cleanliness & test coverage.
3. **Artifact Generation**:
   - Write `.devpilot/pr-reviews/PR-<ID>-review.md`.
4. **Developer Approval**:
   - Display summary to developer.
   - On explicit approval, post review to GitHub:
     ```bash
     gh pr review <PR_NUMBER> --comment -F .devpilot/pr-reviews/PR-<ID>-review.md
     ```
