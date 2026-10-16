---
name: test-document-generation
description: "Generates structured test verification document mapping acceptance criteria to executed developer test cases and automated results."
---

# Test Document Generation Skill

## Purpose
Generates a formal test verification matrix in `.devpilot/<KEY>/test-document.md` to prove that all requirements and edge cases are validated prior to PR submission.

## Matrix Structure
- Acceptance Criterion description
- Test Type (Unit / Integration / DB Migration / E2E)
- Command / Test Path
- Result (`Pass` / `Fail`)
- Notes
