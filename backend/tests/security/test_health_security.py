"""
Health API Security & Edge Case Tests
======================================
Tests for edge cases and wrong HTTP methods on:
GET /api/v1/health
"""


# --- Wrong HTTP Methods ---

def test_health_post_returns_405(client):
    """POST to health endpoint should return 405 Method Not Allowed"""
    response = client.post("/api/v1/health")
    assert response.status_code == 405


def test_health_put_returns_405(client):
    """PUT to health endpoint should return 405 Method Not Allowed"""
    response = client.put("/api/v1/health")
    assert response.status_code == 405


def test_health_delete_returns_405(client):
    """DELETE to health endpoint should return 405 Method Not Allowed"""
    response = client.delete("/api/v1/health")
    assert response.status_code == 405


def test_health_patch_returns_405(client):
    """PATCH to health endpoint should return 405 Method Not Allowed"""
    response = client.patch("/api/v1/health")
    assert response.status_code == 405


# --- Non-existent Endpoints ---

def test_unknown_endpoint_returns_404(client):
    """Completely unknown endpoint should return 404"""
    response = client.get("/api/v1/doesnotexist")
    assert response.status_code == 404


def test_unknown_nested_endpoint_returns_404(client):
    """Unknown nested endpoint should return 404"""
    response = client.get("/api/v1/trajets/extra/unknown")
    assert response.status_code == 404


def test_root_endpoint_returns_404(client):
    """Root endpoint with no prefix should return 404"""
    response = client.get("/")
    assert response.status_code == 404


def test_wrong_api_version_returns_404(client):
    """Wrong API version prefix should return 404"""
    response = client.get("/api/v2/health")
    assert response.status_code == 404


# --- Response Format ---

def test_health_response_is_json(client):
    """Health endpoint must return JSON"""
    response = client.get("/api/v1/health")
    assert response.headers["content-type"] == "application/json"


def test_health_response_has_no_extra_sensitive_fields(client):
    """Health response should not expose sensitive server info"""
    response = client.get("/api/v1/health")
    data = response.json()
    assert "password" not in str(data).lower()
    assert "secret" not in str(data).lower()
    assert "token" not in str(data).lower()