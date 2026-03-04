#!/bin/bash
# ============================================================
# CentralStore - Stop vsech Docker kontejneru
# Data zustanou zachovana v Docker volumes!
# ============================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "======================================="
echo " CentralStore - Zastavuji infrastrukturu"
echo "======================================="

docker compose down

echo ""
echo "Kontejnery zastaveny."
echo "Data jsou ZACHOVANA v Docker volumes:"
echo "  - centralstore-pgdata"
echo "  - centralstore-pgadmin-data"
echo "  - centralstore-rabbitmq-data"
echo ""
echo "Pro smazani dat pouzijte: ./destroy.sh"
echo "======================================="
