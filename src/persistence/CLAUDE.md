# CentralStore.Infrastructure - Data Access Layer

## Purpose
Entity Framework Core data access layer for the CentralStore modular monolith.

## Planned Structure
```
CentralStore.Infrastructure/
├── Data/
│   ├── CentralStoreDbContext.cs
│   └── Configurations/          - EF Core entity configurations
├── Repositories/
│   ├── ProductRepository.cs
│   ├── CategoryRepository.cs
│   └── ...
└── Migrations/
```

## Patterns
- Repository pattern with EF Core
- DbContextFactory for thread-safe access
- Optimistic concurrency with PostgreSQL xmin
- Multi-tenant database support

## Database
- PostgreSQL 17 (port 5432)
- User: centralstore
- Master DB: centralstore_master
