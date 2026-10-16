# PostgreSQL Best Practices & Migration Patterns Reference

## 1. Zero-Downtime Table Alterations

### Safe Index Creation
```sql
-- Cannot be run inside a transaction block
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_users_email ON users(email);
```

### Safe Foreign Key Addition (Two-step without locking table)
```sql
-- Step 1: Add constraint NOT VALID (acquires short lock)
ALTER TABLE orders
  ADD CONSTRAINT fk_orders_user_id
  FOREIGN KEY (user_id) REFERENCES users(id)
  NOT VALID;

-- Step 2: Validate constraint concurrently (scans without table lock)
ALTER TABLE orders
  VALIDATE CONSTRAINT fk_orders_user_id;
```

### Safe Column Renaming / Deprecation (Expand / Contract Pattern)
1. Add new column with new name.
2. Dual-write to both old and new columns in application code.
3. Backfill existing records in batches.
4. Switch application reads to new column.
5. Stop writing to old column.
6. Drop old column.

---

## 2. Parameterization Invariants

| Bad (Vulnerable) | Good (Parameterized) |
|---|---|
| `db.query("SELECT * FROM users WHERE id = '" + id + "'")` | `db.query("SELECT * FROM users WHERE id = $1", [id])` |
| `f"SELECT * FROM items WHERE type = '{item_type}'"` | `"SELECT * FROM items WHERE type = %s", (item_type,)` |
| `sql = f"INSERT INTO logs VALUES ('{msg}')"` | `sql = "INSERT INTO logs (message) VALUES ($1)"` |

---

## 3. Data Types Guide
- **IDs**: Use `BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY` or `UUID DEFAULT gen_random_uuid()`.
- **Timestamps**: Always use `TIMESTAMPTZ` (stored in UTC internally).
- **Decimals / Money**: Use `NUMERIC(12, 2)` or integer cents. Never `FLOAT` for financial data.
- **Enums**: Check constraint `CHECK (status IN ('pending', 'active', 'archived'))` is often easier to migrate than `CREATE TYPE status_enum`.
