# CentralStore

Modular monolith warehouse management system with e-shop integration.

## Tech Stack
- .NET 10.0, ASP.NET Core, Blazor Server
- Radzen UI components
- PostgreSQL 17, Entity Framework Core
- MediatR, FluentValidation, Mapster, Serilog

## Quick Start

### Prerequisites
- .NET 10.0 SDK
- Docker (for PostgreSQL, RabbitMQ)

### 1. Start Infrastructure
```bash
cd docker
./start.sh
```

### 2. Run Backend
```bash
dotnet run --project CentralStore.Api
# Runs on http://localhost:5200
```

### 3. Run Frontend
```bash
dotnet run --project CentralStore.Web
# Runs on http://localhost:5201
```

## Architecture

Modular monolith with plug-in modules:

```
CentralStore.Api            -> REST API backend
CentralStore.Web            -> Blazor Server admin UI
CentralStore.Domain         -> Domain entities & interfaces
CentralStore.Infrastructure -> EF Core & services
CentralStore.SharedLibrary  -> Shared DTOs & validators
CentralStore.Modules.Core   -> Products, categories, inventory
```

## Documentation
- [Architecture](docs/architecture.md)
- [Docker Setup](docker/README.md)

## License
[Add license]
