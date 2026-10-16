---
name: generate-report
description: "Compiles all workflow phase artifacts into a final executive SUMMARY.md document for the developer."
---

# Generate Report Skill

## Purpose
Collects data from all preceding phases (triage, workspace, planning, review, validation, PR) and creates a comprehensive, single-glance `.devpilot/<KEY>/SUMMARY.md`.

## Summary Document Content
1. **Work Item**: Key, Title, Type.
2. **Git Workspace**: Branch, Worktree path, Commit Hash, PR link.
3. **PostgreSQL Summary**: Migrations applied, tables changed, indexes added.
4. **Validation Metrics**: Build status, test counts, lint check.
5. **Code Review Audit**: Resolved findings, safety confirmations.
6. **Next Steps**: Link to live GitHub PR for merging.
