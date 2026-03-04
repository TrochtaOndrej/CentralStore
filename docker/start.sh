#!/bin/bash
# ============================================================
# CentralStore - Start vsech Docker kontejneru
# ============================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "======================================="
echo " CentralStore - Spousteni infrastruktury"
echo "======================================="

# Spusteni kontejneru
docker compose up -d

echo ""
echo "Cekam na healthcheck..."
echo ""

# Cekani na PostgreSQL
echo -n "PostgreSQL: "
for i in $(seq 1 30); do
    if docker compose exec -T postgres pg_isready -U centralstore -q 2>/dev/null; then
        echo "OK"
        break
    fi
    echo -n "."
    sleep 2
done

# Cekani na RabbitMQ
echo -n "RabbitMQ:   "
for i in $(seq 1 30); do
    if docker compose exec -T rabbitmq rabbitmq-diagnostics -q ping 2>/dev/null; then
        echo "OK"
        break
    fi
    echo -n "."
    sleep 2
done

echo ""
echo "======================================="
echo " Infrastruktura bezi!"
echo "======================================="
echo ""
echo " PostgreSQL:   localhost:${POSTGRES_PORT:-5432}"
echo "   User:       centralstore"
echo "   Master DB:  centralstore_master"
echo ""
echo " pgAdmin:      http://localhost:${PGADMIN_PORT:-5050}"
echo "   Email:      admin@centralstore.local"
echo "   Password:   admin"
echo ""
echo " RabbitMQ UI:  http://localhost:${RABBITMQ_MGMT_PORT:-15672}"
echo "   User:       centralstore"
echo "   Password:   CentralStore2026!"
echo "   VHost:      centralstore"
echo ""
echo "======================================="
