#!/bin/bash
# Checks that all services in the ObRail stack are running and healthy.
# Run this script from the project root after docker compose up -d.
# Usage: bash scripts/healthcheck.sh

set -e

echo "🔍 ObRail Health Check"
echo "======================"

# Check the API health endpoint.
API_URL="http://localhost:8002/api/v1/health"
echo -n "Checking API ($API_URL)... "
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$API_URL")
if [ "$RESPONSE" == "200" ]; then
    echo "✅ OK (HTTP $RESPONSE)"
else
    echo "❌ FAILED (HTTP $RESPONSE)"
    exit 1
fi

# Check Prometheus is reachable.
PROM_URL="http://localhost:9090/-/healthy"
echo -n "Checking Prometheus ($PROM_URL)... "
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$PROM_URL")
if [ "$RESPONSE" == "200" ]; then
    echo "✅ OK (HTTP $RESPONSE)"
else
    echo "❌ FAILED (HTTP $RESPONSE)"
    exit 1
fi

# Check Grafana is reachable.
GRAFANA_URL="http://localhost:3000/api/health"
echo -n "Checking Grafana ($GRAFANA_URL)... "
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$GRAFANA_URL")
if [ "$RESPONSE" == "200" ]; then
    echo "✅ OK (HTTP $RESPONSE)"
else
    echo "❌ FAILED (HTTP $RESPONSE)"
    exit 1
fi

# Check the database is accepting connections.
echo -n "Checking PostgreSQL (port 5434)... "
if docker exec obrail-mspr3_postgres_db pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB" > /dev/null 2>&1; then
    echo "✅ OK"
else
    echo "❌ FAILED"
    exit 1
fi

echo ""
echo "✅ All services are healthy."