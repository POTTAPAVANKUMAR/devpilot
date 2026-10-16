---
name: postgres-analyzer
description: "Inspects PostgreSQL database schema, validates DDL migrations for locking risks, checks query parameterization, and audits indexing."
---

# PostgreSQL Analyzer Skill

## Purpose
Enables DevPilot to inspect live or local PostgreSQL databases, audit existing table structures, design zero-downtime migrations, and verify that all queries adhere to security and performance rules.

## Core Operations

### 1. Schema Introspection
- Connects using `DATABASE_URL` or configured parameters (`PGHOST`, `PGPORT`, `PGDATABASE`, `PGUSER`, `PGPASSWORD`).
- Inspect tables:
  ```bash
  ./skills/postgres-analyzer/scripts/inspect-schema.sh tables
  ```
- Inspect a specific table:
  ```bash
  ./skills/postgres-analyzer/scripts/inspect-schema.sh table <table_name>
  ```
- Inspect indexes:
  ```bash
  ./skills/postgres-analyzer/scripts/inspect-schema.sh indexes <table_name>
  ```

### 2. Migration Safety Checklist
Whenever generating or reviewing a SQL migration:
- [ ] **Transaction Block**: Migration is wrapped in `BEGIN; ... COMMIT;` (unless running concurrent index operations).
- [ ] **Idempotent**: Uses `IF NOT EXISTS` for tables/columns and `IF EXISTS` for drops.
- [ ] **Locking Assessment**: Avoids `ACCESS EXCLUSIVE` table lock on large production tables.
  - Adding nullable column: safe.
  - Adding column with constant default (Postgres 11+): safe.
  - Adding column with volatile default (e.g. `clock_timestamp()`): requires table rewrite.
  - Adding foreign key: use `ADD CONSTRAINT ... REFERENCES ... NOT VALID;` followed by `VALIDATE CONSTRAINT`.
- [ ] **Indexing**: New foreign keys must have corresponding B-Tree indexes.
- [ ] **Down Migration**: A corresponding rollback script is documented.

### 3. Query Parameterization Audit
- Search code for raw query strings (`SELECT ... FROM ... WHERE id = ' + id`).
- Enforce parameterized arguments (`$1`, `$2`, `:param`).

See [REFERENCE.md](./REFERENCE.md) for detailed PostgreSQL best practices and SQL templates.
