# PR Review Output Template Reference

When reviewing a PR, format `.devpilot/pr-reviews/PR-<ID>-review.md` as follows:

```markdown
# Pull Request Review - #{{PR_NUMBER}}: {{PR_TITLE}}

## 📋 Executive Summary
Brief evaluation of the PR quality, purpose, and overall recommendation (`APPROVE`, `REQUEST_CHANGES`, `COMMENT`).

## 🎯 Acceptance Criteria Verification (Linked Issue #{{ISSUE_NUMBER}})
- [x] AC 1: Description — Verified in `path/to/file:L10-L25`
- [x] AC 2: Description — Verified in `path/to/file:L40-L60`

## 🐘 PostgreSQL & Data Layer Audit
- Migrations Included: `migrations/xxx.sql`
- Transaction Wrapper: Verified (`BEGIN; ... COMMIT;`)
- Foreign Key Indexes: Verified
- Parameterization: Verified, no raw string concatenation found.

## 🔍 Findings & Recommendations
| Severity | File:Line | Issue | Suggestion |
|---|---|---|---|
| INFO | `src/auth.ts:42` | Explicit return type omitted | Add `: Promise<Session>` |

## 🧪 Verification
- Unit Tests: Passing
- Lint: Passing
```
