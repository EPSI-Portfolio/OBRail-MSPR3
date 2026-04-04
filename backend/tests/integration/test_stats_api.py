"""
Stats API Tests
===============
Tests for GET /api/v1/stats/volumes and GET /api/v1/stats/co2
"""


def test_get_volumes_returns_200(client):
    response = client.get("/api/v1/stats/volumes")
    assert response.status_code == 200


def test_get_volumes_structure(client):
    response = client.get("/api/v1/stats/volumes")
    data = response.json()
    assert "total" in data
    assert "data" in data
    assert isinstance(data["data"], list)


def test_get_volumes_has_data(client):
    response = client.get("/api/v1/stats/volumes")
    data = response.json()
    assert data["total"] > 0
    assert len(data["data"]) > 0


def test_get_volumes_row_structure(client):
    response = client.get("/api/v1/stats/volumes")
    row = response.json()["data"][0]
    assert "origin_country" in row
    assert "service_type" in row
    assert "route_count" in row


def test_get_volumes_service_type_values(client):
    response = client.get("/api/v1/stats/volumes")
    service_types = {r["service_type"] for r in response.json()["data"]}
    assert service_types.issubset({"day", "night"})


def test_get_co2_returns_200(client):
    response = client.get("/api/v1/stats/co2")
    assert response.status_code == 200


def test_get_co2_structure(client):
    response = client.get("/api/v1/stats/co2")
    data = response.json()
    assert "total_routes" in data
    assert "total_co2_saved_kg" in data
    assert "total_co2_saved_tons" in data
    assert "avg_savings_percent" in data
    assert "by_country" in data


def test_get_co2_total_routes_positive(client):
    response = client.get("/api/v1/stats/co2")
    data = response.json()
    assert data["total_routes"] > 0


def test_get_co2_savings_positive(client):
    response = client.get("/api/v1/stats/co2")
    data = response.json()
    assert data["total_co2_saved_kg"] > 0


def test_get_co2_by_country_has_data(client):
    response = client.get("/api/v1/stats/co2")
    data = response.json()
    assert len(data["by_country"]) > 0


def test_get_co2_by_country_structure(client):
    response = client.get("/api/v1/stats/co2")
    country = response.json()["by_country"][0]
    assert "origin_country" in country
    assert "route_count" in country
    assert "total_savings_kg" in country