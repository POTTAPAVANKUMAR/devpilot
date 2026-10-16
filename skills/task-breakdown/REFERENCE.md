# Task Breakdown Reference

## Schema for `subtasks.json`

```json
{
  "workKey": "GH-14",
  "generatedAt": "2026-10-16T16:00:00Z",
  "tasks": [
    {
      "id": 1,
      "title": "PostgreSQL Schema & Migration Design",
      "category": "database",
      "status": "pending",
      "dependencies": []
    },
    {
      "id": 2,
      "title": "Repository / ORM Data Access Layer",
      "category": "backend",
      "status": "pending",
      "dependencies": [1]
    },
    {
      "id": 3,
      "title": "Core Business Logic / Service Layer",
      "category": "backend",
      "status": "pending",
      "dependencies": [2]
    },
    {
      "id": 4,
      "title": "Unit & Integration Testing",
      "category": "testing",
      "status": "pending",
      "dependencies": [3]
    }
  ]
}
```
