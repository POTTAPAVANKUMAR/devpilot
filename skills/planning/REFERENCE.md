# Planning Document Format Reference

The output `.devpilot/<KEY>/planning.md` must follow this structure:

```markdown
# Implementation Plan - [GH-14] Add User Auth with PostgreSQL Session Store

## 1. Architecture Overview
Summary of components, data flow, and technologies.

## 2. PostgreSQL Database Changes
- Migration: `migrations/20261016_create_sessions.sql`
- Tables:
  - `sessions` (`id UUID PRIMARY KEY`, `user_id BIGINT REFERENCES users(id)`, `expires_at TIMESTAMPTZ`, `data JSONB`)
- Indexes:
  - `idx_sessions_user_id` on `sessions(user_id)`
  - `idx_sessions_expires_at` on `sessions(expires_at)`
- Rollback: `DROP TABLE IF EXISTS sessions;`

## 3. Step-by-Step Implementation Sequence
1. Step 1: Create DB Migration (`migrations/20261016_create_sessions.sql`)
2. Step 2: Implement Session Model / Repository (`src/db/sessionRepository.ts`)
3. Step 3: Implement Auth Service (`src/services/authService.ts`)
4. Step 4: Add Auth Middleware & Controller Routes (`src/routes/auth.ts`)
5. Step 5: Write Integration Tests (`tests/auth.test.ts`)

## 4. Verification & Testing Commands
- `npm run db:migrate`
- `npm test tests/auth.test.ts`
- `npm run lint`
- `npm run build`
```
