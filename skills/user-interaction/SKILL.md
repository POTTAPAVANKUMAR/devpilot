---
name: user-interaction
description: "Standards and interactive gating conventions for communicating with the developer during guided workflow mode."
---

# User Interaction Skill

## Purpose
Defines when and how the agent interacts with the developer to confirm decisions, approve plans, or resolve ambiguities.

## Interaction Flow
1. **Flow Modes**:
   - `guided` (default): Asks developer approval at key gates:
     - After planning (`planning.md`) before executing code edits.
     - After code review (`review.md`) before running validation.
     - Before pushing branch and opening GitHub PR.
   - `automatic`: Runs continuously from start to finish without pausing unless a fatal error occurs or human input is strictly needed.
2. **Options Presentation**:
   - Present options clearly using structured questions or interactive tools.
   - Always state the recommended default option.
