"""
Health API Tests
================
Tests for GET /api/v1/health
"""


def test_health_returns_200(client):
    response = client.get("/api/v1/health")
    assert response.status_code == 200


def test_health_status_is_healthy(client):
    response = client.get("/api/v1/health")
    data = response.json()
    assert data["status"] == "healthy"


def test_health_database_connected(client):
    response = client.get("/api/v1/health")
    data = response.json()
    assert data["database"] == "connected"


def test_health_returns_route_counts(client):
    response = client.get("/api/v1/health")
    data = response.json()
    assert "data" in data
    assert data["data"]["total_routes"] > 0
    assert data["data"]["night_routes"] >= 0
    assert data["data"]["day_routes"] >= 0


def test_health_returns_version(client):
    response = client.get("/api/v1/health")
    data = response.json()
    assert "version" in data
    assert data["version"] == "2.0.0"