"""
Trajets Security & Validation Tests
=====================================
Tests for input validation, edge cases, and security on:
GET /api/v1/trajets
GET /api/v1/trajets/{id}
"""


# --- Input Validation ---

def test_get_trajets_invalid_limit_too_low(client):
    """limit must be >= 1"""
    response = client.get("/api/v1/trajets?limit=0")
    assert response.status_code == 422


def test_get_trajets_invalid_limit_too_high(client):
    """limit must be <= 500"""
    response = client.get("/api/v1/trajets?limit=9999")
    assert response.status_code == 422


def test_get_trajets_invalid_offset_negative(client):
    """offset must be >= 0"""
    response = client.get("/api/v1/trajets?offset=-1")
    assert response.status_code == 422


def test_get_trajets_invalid_limit_string(client):
    """limit must be an integer"""
    response = client.get("/api/v1/trajets?limit=abc")
    assert response.status_code == 422


def test_get_trajets_invalid_offset_string(client):
    """offset must be an integer"""
    response = client.get("/api/v1/trajets?offset=abc")
    assert response.status_code == 422


# --- Security: SQL Injection Attempts ---

def test_get_trajets_sql_injection_service_type(client):
    """SQL injection in service_type should not crash the API"""
    response = client.get("/api/v1/trajets?service_type=' OR '1'='1")
    assert response.status_code == 200
    assert response.json()["total"] == 0


def test_get_trajets_sql_injection_origin_country(client):
    """SQL injection in origin_country should not crash the API"""
    response = client.get("/api/v1/trajets?origin_country='; DROP TABLE fact_routes;--")
    assert response.status_code == 200


def test_get_trajets_sql_injection_origin_city(client):
    """SQL injection in origin city should not crash the API"""
    response = client.get("/api/v1/trajets?origin=' OR 1=1--")
    assert response.status_code == 200


# --- Security: Invalid ID Types ---

def test_get_trajet_string_id_returns_422(client):
    """String ID should return 422 unprocessable"""
    response = client.get("/api/v1/trajets/abc")
    assert response.status_code == 422


def test_get_trajet_negative_id_returns_404(client):
    """Negative ID should return 404"""
    response = client.get("/api/v1/trajets/-1")
    assert response.status_code == 404


def test_get_trajet_zero_id_returns_404(client):
    """Zero ID should return 404"""
    response = client.get("/api/v1/trajets/0")
    assert response.status_code == 404


def test_get_trajet_very_large_id_returns_404(client):
    """Very large ID should return 404, not crash"""
    response = client.get("/api/v1/trajets/999999999")
    assert response.status_code == 404


# --- Edge Cases: Filters ---

def test_get_trajets_unknown_service_type_returns_empty(client):
    """Unknown service_type should return empty results, not an error"""
    response = client.get("/api/v1/trajets?service_type=unknown")
    assert response.status_code == 200
    assert response.json()["total"] == 0


def test_get_trajets_unknown_country_returns_empty(client):
    """Unknown country code should return empty results"""
    response = client.get("/api/v1/trajets?origin_country=ZZ")
    assert response.status_code == 200
    assert response.json()["total"] == 0


def test_get_trajets_min_distance_filter(client):
    """min_distance filter should only return routes above threshold"""
    response = client.get("/api/v1/trajets?min_distance=100&limit=100")
    data = response.json()
    for trajet in data["trajets"]:
        assert trajet["distance_km"] >= 100


def test_get_trajets_max_distance_filter(client):
    """max_distance filter should only return routes below threshold"""
    response = client.get("/api/v1/trajets?max_distance=500&limit=100")
    data = response.json()
    for trajet in data["trajets"]:
        assert trajet["distance_km"] <= 500


def test_get_trajets_combined_filters(client):
    """Combined filters should all apply"""
    response = client.get(
        "/api/v1/trajets?service_type=day&min_distance=100&max_distance=1000&limit=50"
    )
    data = response.json()
    assert response.status_code == 200
    for trajet in data["trajets"]:
        assert trajet["service_type"] == "day"
        assert trajet["distance_km"] >= 100
        assert trajet["distance_km"] <= 1000