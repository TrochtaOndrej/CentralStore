# CentralStore - Architecture

## Modular Monolith Pattern

CentralStore uses a modular monolith architecture where the application is structured as independent modules within a single deployment unit.

### Module Structure
Each module follows this internal structure:
```
CentralStore.Modules.Core/
├── Products/
│   ├── Commands/       (MediatR command handlers)
│   ├── Queries/        (MediatR query handlers)
│   ├── Events/         (Domain events)
│   └── Validators/     (FluentValidation)
├── Categories/
├── Inventory/
├── Suppliers/
├── Import/
└── Users/
```

### Communication Between Modules
- **In-process**: MediatR for request/response and notifications
- **Future**: RabbitMQ for async events between modules

### Data Access
- Each module can have its own DbContext or share one
- Repository pattern with EF Core
- Optimistic concurrency using PostgreSQL xmin

## Database Design

### Multi-tenant Architecture
```
centralstore_master     - Platform (tenants, plans, modules)
centralstore_catalog    - Products, categories, attributes
centralstore_inventory  - Stock, movements, suppliers
centralstore_pos        - POS, sales, shifts
centralstore_identity   - Users, authentication
centralstore_import     - Import sessions, rows
```

### Per-tenant Databases
```
cs_{tenant}_catalog
cs_{tenant}_inventory
cs_{tenant}_identity
cs_{tenant}_import
```

## Infrastructure
- PostgreSQL 17 on Docker (192.168.1.32:5432)
- pgAdmin 4 (192.168.1.32:5050)
- RabbitMQ 3.13 (192.168.1.32:5672, Management: 15672)

See `docker/README.md` for setup details.
