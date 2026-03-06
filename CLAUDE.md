# CentralStore - Project Memory

## Overview
CentralStore is a warehouse management system with e-shop integration. Built as a **modular monolith** (core + plug-in modules).

## Tech Stack
| Layer | Technology |
|-------|-----------|
| Frontend | Blazor Server, Radzen UI |
| Backend API | ASP.NET Core 10.0 |
| Database | PostgreSQL 17, EF Core |
| Messaging | MediatR (in-process), RabbitMQ (future) |
| Validation | FluentValidation |
| Mapping | Mapster |
| Logging | Serilog |

## Architecture (Modular Monolith)

```
CentralStore.Api           - ASP.NET Core REST backend
CentralStore.Web           - Blazor Server admin UI (Radzen)
CentralStore.Domain        - Domain entities, interfaces, enums, events
CentralStore.Infrastructure - EF Core, repository impl, services
CentralStore.SharedLibrary - DTOs, contracts, validators
CentralStore.Modules.Core  - Base module (products, categories, inventory, suppliers, import, users)
CentralStore.Modules.*     - Future modules (Discounts, Payments, Expiry...)
tests/                     - xUnit + Moq tests
```

## MVP Scope
Warehouse admin (web) - products, categories, inventory, suppliers, import

## Communication
- MediatR for in-process events
- RabbitMQ for future inter-module messaging

## Database
- PostgreSQL (single DB for MVP)
- Optimistic concurrency (xmin)
- Multi-tenant support (per-tenant databases)

## Ports
| Service | Port |
|---------|------|
| Api | 5200 |
| Web | 5201 |
| PostgreSQL | 5432 |
| pgAdmin | 5050 |
| RabbitMQ AMQP | 5672 |
| RabbitMQ Management | 15672 |

## Docker Infrastructure
All containers run on **192.168.1.32** (NTB-INTEL):
- PostgreSQL 17 (centralstore user)
- pgAdmin 4
- RabbitMQ 3.13

See `docker/README.md` for details.

## Git
- Repository: `git@github.com:TrochtaOndrej/CentralStore.git`
- Branch: `main`
