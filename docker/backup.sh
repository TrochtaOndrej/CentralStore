#!/bin/bash
# ============================================================
# CentralStore - Backup vsech PostgreSQL databazi
# Vytvori timestamped dump do ./backups/
# ============================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="./backups/${TIMESTAMP}"
mkdir -p "$BACKUP_DIR"

echo "======================================="
echo " CentralStore - Backup databazi"
echo " Cas: $(date)"
echo " Cil: $BACKUP_DIR"
echo "======================================="

# Seznam databazi k zalohovani
DATABASES=(
    "centralstore_master"
    "centralstore_catalog"
    "centralstore_inventory"
    "centralstore_pos"
    "centralstore_identity"
    "centralstore_import"
)

for DB in "${DATABASES[@]}"; do
    echo -n "  Zalohuji $DB... "
    docker compose exec -T postgres pg_dump \
        -U centralstore \
        -d "$DB" \
        --format=custom \
        --compress=6 \
        > "${BACKUP_DIR}/${DB}.dump" 2>/dev/null

    if [ $? -eq 0 ]; then
        SIZE=$(du -h "${BACKUP_DIR}/${DB}.dump" | cut -f1)
        echo "OK (${SIZE})"
    else
        echo "CHYBA (databaze mozna neexistuje)"
        rm -f "${BACKUP_DIR}/${DB}.dump"
    fi
done

# Celkovy souhrn
echo ""
echo "======================================="
echo " Backup dokoncen: $BACKUP_DIR"
TOTAL_SIZE=$(du -sh "$BACKUP_DIR" | cut -f1)
echo " Celkova velikost: $TOTAL_SIZE"
echo ""
echo " Pro obnoveni pouzijte:"
echo "   docker compose exec -T postgres pg_restore \\"
echo "     -U centralstore -d <db_name> < backups/${TIMESTAMP}/<db_name>.dump"
echo "======================================="
