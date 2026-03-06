---
name: code-review
description: Performs thorough code review checking quality, security, patterns, and best practices
---

# Code Review Skill

Performs comprehensive code review for the CentralStore modular monolith.

## Trigger
When user asks to review code, check changes, or review a PR.

## Process
1. Identify changes with `git diff`
2. Review each file against patterns in CLAUDE.md
3. Check: module boundaries, MediatR patterns, FluentValidation, Mapster mappings, EF Core patterns, security, naming conventions
4. Output summary with severity-rated issues
