# DevPilot - Personal SDLC Orchestrator for Antigravity CLI
> Autonomous software engineering and code review platform for solo developers, tailored for **GitHub** and **PostgreSQL**.

Inspired by enterprise SDLC orchestration platforms (such as WorkPilot), **DevPilot** adapts the comprehensive 13-phase lifecycle for your personal developer laptop and GitHub repositories—replacing heavy enterprise Jira and Datadog dependencies with lean, powerful **GitHub Issues**, **GitHub Pull Requests**, and a dedicated **PostgreSQL database architect**.

---

## ⚡ Highlights

- **End-to-End Orchestration**: Drives issues from intake to merged PR across 13 deterministic phases.
- **Tailored for GitHub**: Integrates natively with GitHub Issues and Pull Requests via `gh` CLI and the GitHub MCP server.
- **Deep PostgreSQL Intelligence**: Includes schema introspection, zero-downtime migration verification, SQL injection checks, and index auditing.
- **Autonomous PR Reviewer**: Staff-engineer-grade code review agent that audits diffs against acceptance criteria, security policies, and Postgres invariants.
- **Workspace Isolation**: Safely isolates code changes into dedicated Git worktrees or feature branches (`feature/gh-{id}-{desc}`)—never touching `main` directly.
- **Antigravity Native**: Ready to use in `agy` (Antigravity CLI) or Antigravity IDE with agents, skills, rules, and lifecycle hooks.

---

## 🏗️ Architecture & Directory Layout

```text
devpilot/
├── plugin.json                      # Antigravity plugin manifest
├── README.md                        # Complete documentation
├── hooks.json                       # Lifecycle hooks (SessionStart, etc.)
├── mcp_config.json                  # PostgreSQL & GitHub MCP servers
├── .mcp.json                        # Compatibility alias
├── rules/
│   └── AGENTS.md                    # Invariants: Git isolation, Postgres safety, Conv Commits
├── agents/
│   ├── devpilot.md                  # Main SDLC orchestrator agent (Phases 0-12)
│   ├── pr-review.md                 # Autonomous PR code review agent
│   └── postgres-expert.md           # PostgreSQL database specialist subagent
├── skills/
│   ├── scenario-initialization/     # Phase 0: Validate prerequisites & bootstrap config
│   ├── work-item-discovery/         # Phase 1: Fetch GitHub issue (#12) or freeform task
│   ├── work-item-triage/            # Phase 2: Classify Bug / Feature / Migration / Spike
│   ├── task-breakdown/              # Phase 3: Technical decomposition into subtasks
│   ├── codebase-analyst/            # Deep codebase exploration with exact file:line refs
│   ├── codebase-explorer/           # Lightweight structure and architecture scanner
│   ├── postgres-analyzer/           # Schema introspection & migration safety auditor
│   ├── planning/                    # Phase 6: Deterministic step-by-step implementation plan
│   ├── execution/                   # Phase 7: Step-by-step code and migration edits
│   ├── code-reviewer/               # Phase 8: Automated review against review-rules.json
│   ├── pr-review/                   # Pull request review orchestration
│   ├── pull-request-creation/       # Phase 11: Conventional Commits push & gh pr create
│   ├── test-document-generation/    # Phase 10: Acceptance criteria verification matrix
│   ├── generate-report/             # Phase 12: Final SUMMARY.md compiler
│   ├── sub-agent-delegation/        # Guidelines for delegating to specialist subagents
│   └── user-interaction/           # Interactive gates for guided vs automatic modes
└── config/
    ├── devpilot.config.example.json # Project configuration template
    └── review-rules.example.json    # Organization / personal code review rules
```

---

## 🔄 13-Phase Workflow Overview

```mermaid
flowchart TD
    P0(["Phase 0: scenario-initialization<br/>Verify git clean, config & Postgres"]) --> P1["Phase 1: work-item-discovery<br/>Fetch GitHub issue / prompt"]
    P1 --> P2["Phase 2: work-item-triage<br/>Classify: Feature / Bug / Migration / Spike"]
    P2 --> P3["Phase 3: task-breakdown<br/>Break down subtasks"]
    P3 --> P4["Phase 4: workspace-isolation<br/>Create git branch / worktree"]
    P4 --> P5["Phase 5: research<br/>Analyze codebase & Postgres schema"]
    P5 --> P6["Phase 6: planning<br/>Generate deterministic planning.md"]
    P6 --> P7["Phase 7: execution<br/>Implement code & SQL in isolation"]
    P7 --> P8["Phase 8: code-reviewer<br/>Self-review staged diff vs rules"]
    P8 --> P9{"Phase 9: validation<br/>Build, Lint, Tests, DB migrate pass?"}
    P9 -- "All Pass" --> P10["Phase 10: test-document-generation<br/>Generate test-document.md"]
    P9 -- "Failure (retry <= 2)" --> P7
    P10 --> P11["Phase 11: pull-request-creation<br/>Commit, push, and open GitHub PR"]
    P11 --> P12(["Phase 12: generate-report<br/>Compile final SUMMARY.md"])
```

### Runtime Phase Artifacts (`.devpilot/<KEY>/`)
Every phase generates traceable artifacts in `.devpilot/<KEY>/` (git-ignored):
- `work-item.json`: Normalized GitHub issue details.
- `triage.json`: Classification, confidence, and layers affected.
- `subtasks.json`: Ordered technical checklist.
- `workspace.json`: Branch name and worktree path.
- `research.md`: Codebase analysis and Postgres schema structure.
- `planning.md`: Deterministic step-by-step implementation plan.
- `review.md`: Code review findings (security, SQL parameters, layering).
- `validation.json`: Test, lint, build, and migration execution output.
- `test-document.md`: Acceptance criteria verification matrix.
- `pull-request.json`: PR URL, commit SHA, and branch.
- `SUMMARY.md`: Final completion report with links.

---

## 🤖 Agents Included

### 1. `@devpilot` (Main Orchestrator)
- **Role**: Drives the full SDLC pipeline from start to finish.
- **Trigger phrases**: `"devpilot: run issue #14"`, `"implement feature with postgres"`, `"fix bug #23"`.
- **Modes**:
  - `guided`: Prompts developer for confirmation before key phases (plan approval, PR opening).
  - `automatic`: Executes uninterrupted unless an unrecoverable failure occurs.

### 2. `@pr-review` (PR Reviewer)
- **Role**: Autonomous, senior staff-level code review for GitHub PRs.
- **Trigger phrases**: `"review PR #15"`, `"review pull request 15"`.
- **Key Capabilities**: Validates acceptance criteria from the linked GitHub issue, checks SQL query parameterization, verifies PostgreSQL migration locks and rollback scripts.

### 3. `@postgres-expert` (Database Specialist Subagent)
- **Role**: Deep relational data modeling, query optimization, and migration safety.
- **Key Capabilities**: Zero-downtime table alterations (`ADD CONSTRAINT ... NOT VALID`, `CREATE INDEX CONCURRENTLY`), EXPLAIN plan review, connection pooling, and JSONB index design.

---

## 🛠️ MCP Servers Configuration

Configured in `mcp_config.json`:
```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres", "${DATABASE_URL:-postgresql://postgres:postgres@localhost:5432/postgres}"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

---

## 🚀 Installation & Quick Start

### 1. Global Installation (Available Across All Projects in Antigravity)
Symlink or copy `devpilot` into your Antigravity plugins directory:
```bash
ln -s "/Users/pavankumarpotta/Library/CloudStorage/GoogleDrive-pavankumar.potta1998@gmail.com/My Drive/Plugins/devpilot" ~/.gemini/config/plugins/devpilot
```

### 2. Workspace Setup (In Your Project Repository)
1. Add `.devpilot/` to your project's `.gitignore`:
   ```bash
   echo ".devpilot/" >> .gitignore
   ```
2. Initialize configuration:
   ```bash
   mkdir -p .devpilot/config
   cp ~/.gemini/config/plugins/devpilot/config/devpilot.config.example.json .devpilot/config/devpilot.config.json
   cp ~/.gemini/config/plugins/devpilot/config/review-rules.example.json .devpilot/config/review-rules.json
   ```
3. Set your `DATABASE_URL` and `GITHUB_TOKEN` in your environment or `.env`.

### 3. Usage in Antigravity CLI (`agy`)
Start `agy` and trigger DevPilot:
```text
agy "Run devpilot for GitHub issue #12"
```
Or for PR review:
```text
agy "Review PR #15"
```
