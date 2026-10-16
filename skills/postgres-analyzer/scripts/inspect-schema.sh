#!/usr/bin/env bash
# inspect-schema.sh - Introspect PostgreSQL schema and table structures
set -euo pipefail

MODE="${1:-tables}"
TARGET="${2:-}"

DB_URL="${DATABASE_URL:-}"

run_psql() {
  local query="$1"
  if [ -n "$DB_URL" ]; then
    psql "$DB_URL" -c "$query"
  else
    psql -c "$query"
  fi
}

case "$MODE" in
  tables)
    echo "=== Listing all public tables ==="
    run_psql "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' ORDER BY table_name;"
    ;;
  table)
    if [ -z "$TARGET" ]; then
      echo "Error: target table name required. Usage: $0 table <table_name>"
      exit 1
    fi
    echo "=== Columns for table: $TARGET ==="
    run_psql "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_schema = 'public' AND table_name = '$TARGET' ORDER BY ordinal_position;"
    ;;
  indexes)
    if [ -z "$TARGET" ]; then
      echo "Error: target table name required. Usage: $0 indexes <table_name>"
      exit 1
    fi
    echo "=== Indexes for table: $TARGET ==="
    run_psql "SELECT indexname, indexdef FROM pg_indexes WHERE schemaname = 'public' AND tablename = '$TARGET';"
    ;;
  foreign-keys)
    echo "=== Foreign Keys ==="
    run_psql "
      SELECT
        tc.table_name, kcu.column_name,
        ccu.table_name AS foreign_table_name,
        ccu.column_name AS foreign_column_name
      FROM information_schema.table_constraints AS tc
      JOIN information_schema.key_column_usage AS kcu
        ON tc.constraint_name = kcu.constraint_name
      JOIN information_schema.constraint_column_usage AS ccu
        ON ccu.constraint_name = tc.constraint_name
      WHERE tc.constraint_type = 'FOREIGN KEY' AND tc.table_schema = 'public';
    "
    ;;
  *)
    echo "Unknown mode: $MODE. Available modes: tables, table <name>, indexes <name>, foreign-keys"
    exit 1
    ;;
esac
