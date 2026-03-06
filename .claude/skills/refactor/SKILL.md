---
name: refactor
description: Analyzes code for refactoring opportunities and applies safe, incremental improvements following modular monolith patterns
---

# Refactor Skill

Identifies and applies safe refactoring patterns for the CentralStore codebase.

## Trigger
When user asks to refactor, clean up, improve code quality, or reduce technical debt.

## Process

1. **Analyze Current Code**
   - Read target files and understand current structure
   - Identify code smells:
     - Duplicate code across modules
     - Long methods (>30 lines)
     - God classes (>300 lines)
     - Missing abstractions
     - Tight coupling between modules
     - Inconsistent patterns

2. **Plan Refactoring**
   - List specific refactoring operations
   - Assess risk and impact of each change
   - Prioritize by value/risk ratio
   - Present plan to user for approval before starting

3. **Apply Changes (One at a Time)**
   - Make one logical refactoring per commit
   - Run `dotnet build` after each change to verify compilation
   - Run `dotnet test` to verify no regressions
   - Commit each refactoring separately with clear message

4. **Common Refactorings**

   ### Extract to MediatR Handler
   Move business logic from controller to a proper command/query handler:
   ```csharp
   // Before: Logic in controller
   [HttpPost]
   public async Task<IActionResult> Create(CreateProductDto dto) {
       var product = new Product { Name = dto.Name };
       _context.Products.Add(product);
       await _context.SaveChangesAsync();
       return Ok(product.Id);
   }

   // After: Via MediatR
   [HttpPost]
   public async Task<IActionResult> Create(CreateProductDto dto)
       => Ok(await _mediator.Send(new CreateProductCommand(dto)));
   ```

   ### Introduce FluentValidation
   Replace manual validation with FluentValidation rules:
   ```csharp
   public class CreateProductValidator : AbstractValidator<CreateProductDto>
   {
       public CreateProductValidator()
       {
           RuleFor(x => x.Name).NotEmpty().MaximumLength(200);
           RuleFor(x => x.Price).GreaterThan(0);
           RuleFor(x => x.CategoryId).GreaterThan(0);
       }
   }
   ```

   ### Extract Repository
   Move data access from service to repository with interface.

   ### Consolidate Duplicate Code
   Extract shared logic into SharedLibrary or base classes.

   ### Apply Modern C# Syntax
   - Primary constructors for DI
   - Records for DTOs
   - Pattern matching for conditionals
   - File-scoped namespaces

## Safety Rules
- Never refactor and add features in the same commit
- Always have tests before refactoring critical business logic
- Module boundaries must be preserved (don't merge modules)
- Keep backward compatibility for API contracts
