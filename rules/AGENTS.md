# DevPilot Workspace Rules

When the DevPilot plugin is active, the agent must adhere to the following operational invariants:

## 1. Git & Workspace Isolation Invariants
- **Never Modify Main Directly**: Never commit or push directly to `main`, `master`, or the configured default branch.
- **Branch / Worktree Isolation**: All code changes, spikes, and implementations must occur in a dedicated git branch or isolated worktree (`feature/gh-{id}-{slug}` or `bugfix/gh-{id}-{slug}`).
- **Clean Workspace**: Any temporary artifacts, diff tests, or scratch notes must reside in `.devpilot/<WORK_ITEM_KEY>/` which must be kept git-ignored.

## 2. PostgreSQL Architectural & Security Invariants
- **Strict Parameterization**: No dynamic SQL concatenation or unescaped string interpolation. All queries must use parameterized placeholders (`$1`, `$2`, or ORM-bound parameters) to prevent SQL injection.
- **Migration Idempotency & Safety**:
  - Always wrap schema changes in explicit transactions (`BEGIN; ... COMMIT;`) unless executing non-transactional statements like `CREATE INDEX CONCURRENTLY`.
  - Use defensive clauses (`IF NOT EXISTS`, `IF EXISTS`).
  - Never run un-gated table locks (`ALTER TABLE ... ADD COLUMN ... DEFAULT <expression>` in older Postgres versions or blocking locks during peak traffic).
  - Always provide a rollback / down migration plan.
- **Indexing & Performance**:
  - Foreign key columns must have supporting indexes to avoid table locks during parent deletion/updates.
  - Ensure queries use appropriate indexes and avoid full sequential scans (`Seq Scan`) on growing tables.
- **Connection Hygiene**:
  - Code must properly release connections back to the pool or use connection pooling (e.g., PgBouncer / pool limits).

## 3. GitHub & Code Standards
- **Conventional Commits**: Commit messages must adhere to `type(scope): description` (e.g., `feat(auth): add postgres session store`).
- **Traceable PRs**: Pull requests must explicitly link to their originating GitHub Issue using keywords (`Fixes #12`, `Closes #12`).
- **Review Gate**: No automated PR post without user verification. Review findings must be recorded and evaluated prior to PR opening.
