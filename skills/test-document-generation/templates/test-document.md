# Verification & Test Document - {{WORK_KEY}}

## Work Item Details
- **Title**: {{TITLE}}
- **Type**: {{TYPE}}
- **Date**: {{DATE}}

## Acceptance Criteria Matrix
| # | Acceptance Criterion | Test Method | Test Command / File | Result | Notes |
|---|---|---|---|---|---|
| 1 | {{AC_1}} | Automated Unit | `{{CMD_1}}` | Pass | Verified |
| 2 | {{AC_2}} | Integration | `{{CMD_2}}` | Pass | Verified |

## Database Migration Verification (PostgreSQL)
- **Migration**: `{{MIGRATION_FILE}}`
- **Execution Test**: `psql $DATABASE_URL -f {{MIGRATION_FILE}}` ➔ Passed
- **Rollback Test**: Down migration executed and verified clean.
- **Index Check**: All foreign keys and query lookups covered.

## Validation Suite Summary
- **Build**: Pass
- **Lint**: Pass
- **Full Test Suite**: Pass
