# CentralStore - Docker Infrastruktura

## Obsah
- PostgreSQL 17 (databaze)
- pgAdmin 4 (webove rozhrani pro DB)
- RabbitMQ 3.13 (message broker)

## Pozadavky
- Docker Engine 24+
- Docker Compose v2+

## Rychly start

```bash
# 1. Nastavte prava na skripty
chmod +x *.sh

# 2. (Volitelne) Upravte hesla v .env souboru
nano .env

# 3. Spustte infrastrukturu
./start.sh
```

## Pristupove udaje

### PostgreSQL
| Parametr | Hodnota |
|---|---|
| Host | localhost |
| Port | 5432 |
| User | centralstore |
| Password | CentralStore2026! |
| Master DB | centralstore_master |

### pgAdmin (webove rozhrani pro DB)
| Parametr | Hodnota |
|---|---|
| URL | http://localhost:5050 |
| Email | admin@centralstore.local |
| Password | admin |

### RabbitMQ
| Parametr | Hodnota |
|---|---|
| AMQP | localhost:5672 |
| Management UI | http://localhost:15672 |
| User | centralstore |
| Password | CentralStore2026! |
| VHost | centralstore |

## Skripty

| Skript | Popis |
|---|---|
| `start.sh` | Spusti vsechny kontejnery, ceka na healthcheck |
| `stop.sh` | Zastavi kontejnery (DATA ZUSTAVA zachovana) |
| `status.sh` | Zobrazi stav kontejneru a databazi |
| `backup.sh` | Zaloha vsech PostgreSQL databazi do `./backups/` |
| `destroy.sh` | SMAZE kontejnery i data (vyzaduje potvrzeni) |
| `create-tenant-db.sh <code>` | Vytvori databaze pro noveho tenanta |

## Databaze

### Zakladni (vytvoreny automaticky pri prvnim startu)
```
centralstore_master      - platforma (tenanty, plany, moduly)
centralstore_catalog     - produkty, kategorie, atributy (vychozi/dev)
centralstore_inventory   - zasoby, pohyby, dodavatele (vychozi/dev)
centralstore_pos         - pokladna, prodeje, smeny (vychozi/dev)
centralstore_identity    - uzivatele, autentizace (vychozi/dev)
centralstore_import      - import sessions, radky (vychozi/dev)
```

### Per-tenant (vytvoreny pres create-tenant-db.sh)
```
cs_{tenant}_catalog
cs_{tenant}_inventory
cs_{tenant}_identity
cs_{tenant}_import
(cs_{tenant}_pos - jen pokud ma POS modul)
```

Priklad: `./create-tenant-db.sh abc` vytvori `cs_abc_catalog`, `cs_abc_inventory` atd.

## Persistentni data

Data jsou ulozena v Docker named volumes:
- `centralstore-pgdata` - PostgreSQL data
- `centralstore-pgadmin-data` - pgAdmin konfigurace
- `centralstore-rabbitmq-data` - RabbitMQ fronty a zpravy

**Vypnuti kontejneru (`stop.sh`) DATA NESMAZE.**
Data se smazou pouze pri `destroy.sh` nebo `docker volume rm`.

## Connection strings pro .NET appsettings.json

```json
{
  "ConnectionStrings": {
    "MasterDb": "Host=localhost;Port=5432;Database=centralstore_master;Username=centralstore;Password=CentralStore2026!",
    "CatalogDb": "Host=localhost;Port=5432;Database=centralstore_catalog;Username=centralstore;Password=CentralStore2026!",
    "InventoryDb": "Host=localhost;Port=5432;Database=centralstore_inventory;Username=centralstore;Password=CentralStore2026!",
    "PosDb": "Host=localhost;Port=5432;Database=centralstore_pos;Username=centralstore;Password=CentralStore2026!",
    "IdentityDb": "Host=localhost;Port=5432;Database=centralstore_identity;Username=centralstore;Password=CentralStore2026!",
    "ImportDb": "Host=localhost;Port=5432;Database=centralstore_import;Username=centralstore;Password=CentralStore2026!"
  },
  "RabbitMQ": {
    "Host": "localhost",
    "Port": 5672,
    "Username": "centralstore",
    "Password": "CentralStore2026!",
    "VirtualHost": "centralstore"
  }
}
```

## Backup a obnova

### Zaloha
```bash
./backup.sh
# Vytvori ./backups/20260304_143000/
#   centralstore_master.dump
#   centralstore_catalog.dump
#   ...
```

### Obnova
```bash
# Obnova konkretni databaze
docker compose exec -T postgres pg_restore \
  -U centralstore -d centralstore_catalog --clean --if-exists \
  < backups/20260304_143000/centralstore_catalog.dump
```

## Troubleshooting

### Port uz je obsazeny
Zmente porty v `.env`:
```
POSTGRES_PORT=5433
PGADMIN_PORT=5051
RABBITMQ_MGMT_PORT=15673
```

### Kontejner se nespusti
```bash
docker compose logs postgres    # logy PostgreSQL
docker compose logs rabbitmq    # logy RabbitMQ
```

### Reset na cisto (smazat vse a zacit znovu)
```bash
./destroy.sh
./start.sh
```
