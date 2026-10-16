---
name: work-item-discovery
description: "Discovers and normalizes a GitHub issue or free-form task into a structured work item JSON document."
---

# Work Item Discovery Skill

## Purpose
Fetches a GitHub issue by number (e.g. `#14`, `14`), full URL (`https://github.com/owner/repo/issues/14`), or parses an ad-hoc developer task description into a standardized `work-item.json`.

## Procedure
1. **GitHub Issue Fetch**:
   - If a GitHub issue key or URL is provided:
     ```bash
     gh issue view <ISSUE_NUMBER> --json number,title,body,labels,assignees,state
     ```
   - Alternatively, use the bundled helper script:
     ```bash
     ./skills/work-item-discovery/scripts/fetch-issue.sh <ISSUE_NUMBER>
     ```
2. **Ad-hoc / Prompt-based Intake**:
   - If the user provides a freeform task without a GitHub issue:
     - Generate a local identifier (e.g. `TASK-TIMESTAMP` or `FEAT-SHORTNAME`).
     - Extract title, goal, scope, and acceptance criteria from user instructions.
3. **Save Work Item**:
   - Write normalized JSON to `.devpilot/<KEY>/work-item.json`:
     ```json
     {
       "id": "14",
       "key": "GH-14",
       "title": "Add user authentication with PostgreSQL session store",
       "description": "...",
       "acceptanceCriteria": [
         "Users can log in with email/password",
         "Session stored in PostgreSQL session table"
       ],
       "labels": ["enhancement", "database"],
       "url": "https://github.com/owner/repo/issues/14"
     }
     ```
