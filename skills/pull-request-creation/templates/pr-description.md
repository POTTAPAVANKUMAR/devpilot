## Summary
<!-- What changed and why it matters -->
{{SUMMARY}}

## Motivation & Linked Issue
Fixes #{{ISSUE_NUMBER}}
<!-- Link to issue, discussion, or specification -->
{{MOTIVATION}}

## 🐘 Database Changes (PostgreSQL)
<!-- Detail schema additions, migrations, or table alterations -->
- **Migration File**: `{{MIGRATION_FILE}}`
- **Tables Modified / Added**: `{{TABLES}}`
- **Zero-downtime / Lock considerations**: Verified safe

## 🧪 Verification Matrix
- [x] Build passes
- [x] Lint passes
- [x] Unit / Integration tests pass
- [x] Database migration executes and rolls back cleanly

## Checklist
- [x] Code adheres to repository style guides
- [x] No credentials or unparameterized queries
- [x] Documentation updated where appropriate
