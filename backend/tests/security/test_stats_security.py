"""
Stats Security & Validation Tests
===================================
Tests for edge cases and security on:
GET /api/v1/stats/volumes
GET /api/v1/stats/co2
"""


# --- Non-regression: Response Structure Always Present ---

def test_get_volumes_always_returns_total_field(client):
    """total field must always be present even if 0"""
    response = client.get("/api/v1/stats/volumes")
    assert "total" in response.json()


def test_get_volumes_always_returns_data_list(client):
    """data field must always be a list"""
    response = client.get("/api/v1/stats/volumes")
    assert isinstance(response.json()["data"], list)


def test_get_co2_always_returns_required_fields(client):
    """All CO2 summary fields must always be present"""
    response = client.get("/api/v1/stats/co2")
    data = response.json()
    required_fields = [
        "total_routes",
        "total_co2_saved_kg",
        "total_co2_saved_tons",
        "avg_savings_percent",
        "by_country"
    ]
    for field in required_fields:
        assert field in data, f"Missing field: {field}"


def test_get_co2_by_country_always_returns_list(client):
    """by_country must always be a list"""
    response = client.get("/api/v1/stats/co2")
    assert isinstance(response.json()["by_country"], list)


# --- Data Integrity ---

def test_get_co2_tons_is_kg_divided_by_1000(client):
    """total_co2_saved_tons should equal total_co2_saved_kg / 1000"""
    response = client.get("/api/v1/stats/co2")
    data = response.json()
    expected_tons = round(data["total_co2_saved_kg"] / 1000, 2)
    assert abs(data["total_co2_saved_tons"] - expected_tons) < 0.01


def test_get_volumes_service_types_are_valid(client):
    """service_type in volumes should only be day or night"""
    response = client.get("/api/v1/stats/volumes")
    for row in response.json()["data"]:
        assert row["service_type"] in ("day", "night")


def test_get_volumes_route_count_positive(client):
    """All route counts in volumes should be positive"""
    response = client.get("/api/v1/stats/volumes")
    for row in response.json()["data"]:
        assert row["route_count"] > 0


def test_get_co2_savings_non_negative(client):
    """CO2 savings should never be negative"""
    response = client.get("/api/v1/stats/co2")
    data = response.json()
    assert data["total_co2_saved_kg"] >= 0
    assert data["total_co2_saved_tons"] >= 0


def test_get_co2_by_country_savings_non_negative(client):
    """Per-country CO2 savings should never be negative"""
    response = client.get("/api/v1/stats/co2")
    for country in response.json()["by_country"]:
        assert country["total_savings_kg"] >= 0


def test_get_co2_by_country_route_count_positive(client):
    """Per-country route counts should be positive"""
    response = client.get("/api/v1/stats/co2")
    for country in response.json()["by_country"]:
        assert country["route_count"] > 0


# --- Non-regression: Endpoints Always Respond ---

def test_volumes_endpoint_always_200(client):
    """Volumes endpoint must always return 200"""
    response = client.get("/api/v1/stats/volumes")
    assert response.status_code == 200


def test_co2_endpoint_always_200(client):
    """CO2 endpoint must always return 200"""
    response = client.get("/api/v1/stats/co2")
    assert response.status_code == 200


def test_unknown_stats_endpoint_returns_404(client):
    """Unknown stats endpoint should return 404"""
    response = client.get("/api/v1/stats/unknown")
    assert response.status_code == 404