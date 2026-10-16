---
name: work-item-triage
description: "Classifies a work item into Feature, Bug, Database Migration, Refactor, or Spike with confidence scoring and risk evaluation."
---

# Work Item Triage Skill

## Purpose
Analyzes the work item's description, logs, error stacktraces, or feature requests and determines the taxonomy and risk level.

## Taxonomy
- **Feature**: New functionality or endpoint; expanding domain models.
- **Bug**: Regression, error, unexpected behavior, broken query, or unhandled exception.
- **Database-Migration**: DDL schema modifications, new tables, altered constraints, index additions.
- **Refactor**: Code restructuring, dependency upgrade, performance enhancement without functional change.
- **Spike**: Investigation, architecture feasibility check, or benchmark.

## Output
Write `.devpilot/<KEY>/triage.json`:
```json
{
  "type": "Feature",
  "confidence": 0.95,
  "requiresDbMigration": true,
  "impactedLayers": ["database", "backend-api", "frontend"],
  "riskLevel": "medium",
  "rationale": "Introduces new user sessions table in PostgreSQL and adds auth routes."
}
```
