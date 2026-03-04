#!/bin/bash
# ============================================================
# CentralStore - Vytvoreni databazi pro noveho tenanta
# Pouziti: ./create-tenant-db.sh <tenant_code>
# Priklad: ./create-tenant-db.sh abc
# ============================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

if [ -z "$1" ]; then
    echo "Pouziti: $0 <tenant_code>"
    echo "Priklad: $0 abc"
    echo ""
    echo "Vytvori databaze:"
    echo "  cs_<tenant_code>_catalog"
    echo "  cs_<tenant_code>_inventory"
    echo "  cs_<tenant_code>_identity"
    echo "  cs_<tenant_code>_import"
    exit 1
fi

TENANT="$1"
# Validace: jen male pismena a cisla
if [[ ! "$TENANT" =~ ^[a-z0-9]+$ ]]; then
    echo "CHYBA: Tenant code muze obsahovat jen male pismena a cisla."
    exit 1
fi

echo "======================================="
echo " Vytvareni DB pro tenanta: $TENANT"
echo "======================================="

DATABASES=(
    "cs_${TENANT}_catalog"
    "cs_${TENANT}_inventory"
    "cs_${TENANT}_identity"
    "cs_${TENANT}_import"
)

for DB in "${DATABASES[@]}"; do
    echo -n "  Vytvarim $DB... "
    docker compose exec -T postgres psql -U centralstore -d centralstore_master -c \
        "CREATE DATABASE ${DB} OWNER centralstore ENCODING 'UTF8';" 2>/dev/null

    # Aktivace extensions
    docker compose exec -T postgres psql -U centralstore -d "$DB" -c \
        "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";" 2>/dev/null

    echo "OK"
done

echo ""
echo "======================================="
echo " Databaze pro tenanta '$TENANT' vytvoreny."
echo " Connection strings pro appsettings.json:"
echo ""
for DB in "${DATABASES[@]}"; do
    echo "  Host=localhost;Port=5432;Database=${DB};Username=centralstore;Password=CentralStore2026!"
done
echo "======================================="
