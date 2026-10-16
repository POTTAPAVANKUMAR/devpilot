---
name: code-reviewer
description: "Audits git diff against security policies, PostgreSQL safety guidelines, layering rules, and naming conventions."
---

# Code Reviewer Skill

## Purpose
Performs an objective, automated audit of the staged git changes before running full validation and pushing a PR.

## Review Checkpoints
1. **Secrets & Hygiene**:
   - Zero hardcoded passwords, tokens, API keys, or connection strings with credentials.
   - No leftover debug `console.log`, `print()`, or debugger statements.
2. **PostgreSQL & Data Safety**:
   - Every raw query uses parameter bindings (`$1`, `$2`, `:var`).
   - Zero dynamic SQL concatenation.
   - All migrations have safe lock profiles and transaction wrappers.
   - New foreign keys have corresponding indexes.
3. **Architecture & Standards**:
   - Respects layering rules defined in `.devpilot/config/review-rules.json`.
   - Error handling: async calls wrapped in try/catch or checked error returns.
4. **Output**:
   - Write `.devpilot/<KEY>/review.md` with findings categorized by severity: `CRITICAL`, `WARNING`, `INFO`.
   - If `CRITICAL` issues exist, agent must return to execution and fix them before validation.
