---
name: sub-agent-delegation
description: "Guidelines and protocols for orchestrator agents to delegate specialized tasks (like PostgreSQL architecture or PR review) to subagents."
---

# Sub-Agent Delegation Skill

## Purpose
Establishes clear guidelines when the main orchestrator (`devpilot`) delegates work to specialist subagents (e.g. `postgres-expert` or `pr-review`).

## Delegation Protocols
1. **Clear Context Framing**:
   - Always pass the full workspace path, target files, and specific objectives.
   - For database tasks: specify target table, database engine (PostgreSQL), and performance constraints.
2. **Subagent Execution Invariants**:
   - Subagents must not modify unrelated files.
   - Subagents must report results back with clear file links and concise summaries.
   - Subagents should return control back to the orchestrator once their designated task is complete.
