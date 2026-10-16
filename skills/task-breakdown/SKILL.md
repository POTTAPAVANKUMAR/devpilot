---
name: task-breakdown
description: "Decomposes a triaged work item into a structured sequence of subtasks based on project configuration templates."
---

# Task Breakdown Skill

## Purpose
Breaks down the triaged work item into clear, bite-sized tasks spanning database changes, services, API endpoints, testing, and delivery.

## Subtask Templates (Configurable in `devpilot.config.json`)

### Feature Template:
1. PostgreSQL Schema & Migration Design
2. Repository / ORM Data Access Layer
3. Core Business Logic / Service Layer
4. API Route / Controller Implementation
5. Client / Frontend UI Integration (if applicable)
6. Unit & Integration Testing
7. Documentation & PR Preparation

### Bug Fix Template:
1. Root Cause Analysis & Reproduction Test
2. SQL / Code Fix Implementation
3. Regression & Integration Testing
4. Verification & PR Preparation

### Database-Migration Template:
1. PostgreSQL Schema Diff & DDL Migration Script
2. Forward Migration & Rollback Test
3. Data Migration Script (if data backfill needed)
4. Model / ORM Update
5. Performance & Index Verification

## Output
Write `.devpilot/<KEY>/subtasks.json` containing the status, dependencies, and owners of each task.
See [REFERENCE.md](./REFERENCE.md) for schema details.
