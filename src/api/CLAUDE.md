# CentralStore.Api - REST API Layer

## Purpose
ASP.NET Core 10.0 REST backend for the CentralStore warehouse management system.

## Planned Structure
```
CentralStore.Api/
├── Program.cs              - Startup, DI, middleware
├── Controllers/
│   ├── Products/           - Product CRUD endpoints
│   ├── Categories/         - Category management
│   ├── Inventory/          - Stock management
│   ├── Suppliers/          - Supplier management
│   └── Import/             - Data import endpoints
└── appsettings.json        - Configuration
```

## Patterns
- Controllers are thin - delegate to MediatR handlers
- FluentValidation for request validation
- Mapster for DTO mapping
- Swagger/OpenAPI documentation

## Port: 5200
