#!/bin/bash
# Resets the database by removing the Docker volume and re-initialising it.
# This will DELETE ALL DATA and re-run the init scripts from scratch.
# Use this during development when the schema or seed data changes.
# Usage: bash scripts/reset_db.sh

set -e

echo "⚠️  ObRail Database Reset"
echo "========================="
echo "This will DELETE all data and recreate the database from scratch."
read -p "Are you sure? (yes/no): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "Aborted."
    exit 0
fi

echo ""
echo "Stopping containers..."
docker compose down

echo "Removing postgres volume..."
docker volume rm obrail-mspr3_postgres_data 2>/dev/null || echo "Volume not found, skipping."

echo "Restarting stack..."
docker compose up -d

echo ""
echo "Waiting for database to initialise..."
sleep 5

echo ""
echo "✅ Database reset complete. Init scripts have been re-applied."
echo "   Run: bash scripts/healthcheck.sh to verify all services are healthy."