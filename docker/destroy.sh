#!/bin/bash
# ============================================================
# CentralStore - SMAZANI vsech kontejneru A DAT
# POZOR: Toto smaze vsechna data v databazich!
# ============================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo " VAROVANI: Toto smaze VSECHNA DATA!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo ""
read -p "Opravdu chcete smazat vsechna data? (ano/ne): " confirm

if [ "$confirm" != "ano" ]; then
    echo "Zruseno."
    exit 0
fi

echo ""
echo "Zastavuji kontejnery a mazu volumes..."

docker compose down -v

echo ""
echo "======================================="
echo " Vsechna data byla smazana."
echo " Pro novy start: ./start.sh"
echo "======================================="
