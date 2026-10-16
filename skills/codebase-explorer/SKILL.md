---
name: codebase-explorer
description: "Lightweight codebase exploration skill to scan repository structure, directory layout, framework detection, and configuration patterns."
---

# Codebase Explorer Skill

## Purpose
Quickly establishes high-level project orientation:
- Detect package managers (`package.json`, `go.mod`, `Cargo.toml`, `requirements.txt`, `pom.xml`, etc.).
- Identify project architecture (Monolith, Modular Monolith, Microservices, Clean Architecture, MVC).
- Identify database ORM / query tools (Prisma, Drizzle, TypeORM, Knex, SQLAlchemy, pgx, SQLx, EF Core, raw SQL migrations).
- Check configured linter and test runners (`jest`, `vitest`, `pytest`, `eslint`, `biome`).
