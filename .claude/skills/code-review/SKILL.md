---
name: code-review
description: Performs thorough code review checking quality, security, patterns, and best practices for modular monolith architecture
---

# Code Review Skill

Performs comprehensive code review for the CentralStore modular monolith project.

## Trigger
When user asks to review code, check changes, or review a PR.

## Process

1. **Identify Changes**
   - Run `git diff` or `git diff main...HEAD`
   - List all changed files grouped by module

2. **Review Each File**
   - Read the full file for context
   - Check against project patterns in CLAUDE.md
   - Identify issues by severity

3. **Check Categories**
   - [ ] **Module Boundaries** - No direct cross-module database access
   - [ ] **MediatR Usage** - Commands/queries use MediatR handlers, not direct service calls
   - [ ] **FluentValidation** - All input DTOs have validators
   - [ ] **Mapster Mappings** - DTO <-> Entity mappings via Mapster, no manual mapping
   - [ ] **EF Core Patterns** - DbContextFactory, AsNoTracking() for reads, CancellationToken
   - [ ] **Repository Pattern** - Data access through repositories, not direct DbContext
   - [ ] **Naming Conventions** - PascalCase public, _camelCase private, async suffix
   - [ ] **Error Handling** - Domain exceptions, no empty catch blocks, structured logging
   - [ ] **Security** - Input validation, auth checks, no hardcoded credentials
   - [ ] **Async/Await** - No sync-over-async, proper CancellationToken propagation
   - [ ] **SOLID Principles** - Single responsibility, dependency inversion via DI

4. **Output Format**
   ```
   ## Code Review Summary

   **Files reviewed:** N
   **Issues found:** N (X critical, Y warnings, Z suggestions)
   **Recommendation:** Approve / Request Changes

   ### Issues

   **[CRITICAL] path/file.cs:42 - Brief title**
   Problem: Description of what's wrong
   Suggestion: How to fix it

   **[WARNING] path/file.cs:78 - Brief title**
   Problem: Description
   Suggestion: Fix
   ```

## Architecture Rules to Enforce
- Modules communicate via **MediatR** (IRequest/INotification), never direct references
- Each module owns its data - no cross-module database queries
- Domain events (INotification) for cross-module reactions
- Validators in SharedLibrary or module's own Validators/ folder
- DTOs in SharedLibrary, entities in Domain
