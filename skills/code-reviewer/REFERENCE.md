# Code Review Rules Reference

## Severity Levels

- **CRITICAL**: Hard block. Must be resolved before opening a PR.
  - SQL injection vulnerabilities or unparameterized queries.
  - Hardcoded secrets, keys, or passwords.
  - Non-transactional destructive DDL in production migrations.
  - Broken imports or syntax errors.
- **WARNING**: Review flag. Address if feasible or document rationale.
  - Missing foreign key indexes in PostgreSQL.
  - Unhandled promise rejections / missing catch blocks.
  - Missing unit tests for newly added public functions.
- **INFO**: Style or minor improvements.
  - Naming convention improvements.
  - Documentation / comment clarity.
