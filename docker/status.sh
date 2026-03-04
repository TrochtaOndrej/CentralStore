#!/bin/bash
# ============================================================
# CentralStore - Status vsech kontejneru
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "======================================="
echo " CentralStore - Status infrastruktury"
echo "======================================="
echo ""

# Status kontejneru
echo "--- Kontejnery ---"
docker compose ps
echo ""

# Volumes
echo "--- Docker Volumes ---"
docker volume ls --filter name=centralstore
echo ""

# DB check
echo "--- Databaze ---"
if docker compose exec -T postgres pg_isready -U centralstore -q 2>/dev/null; then
    echo "PostgreSQL: ONLINE"
    docker compose exec -T postgres psql -U centralstore -d centralstore_master -c "\l" 2>/dev/null | grep centralstore || true
else
    echo "PostgreSQL: OFFLINE"
fi
echo ""

# RabbitMQ check
echo "--- RabbitMQ ---"
if docker compose exec -T rabbitmq rabbitmq-diagnostics -q ping 2>/dev/null; then
    echo "RabbitMQ: ONLINE"
    docker compose exec -T rabbitmq rabbitmqctl list_vhosts 2>/dev/null || true
else
    echo "RabbitMQ: OFFLINE"
fi

echo ""
echo "======================================="
