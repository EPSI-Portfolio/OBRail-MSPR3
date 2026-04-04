"""
Trajets API Tests
=================
Tests for GET /api/v1/trajets and GET /api/v1/trajets/{id}
"""


def test_get_trajets_returns_200(client):
    response = client.get("/api/v1/trajets")
    assert response.status_code == 200


def test_get_trajets_returns_correct_structure(client):
    response = client.get("/api/v1/trajets")
    data = response.json()
    assert "total" in data
    assert "limit" in data
    assert "offset" in data
    assert "trajets" in data
    assert isinstance(data["trajets"], list)


def test_get_trajets_total_is_positive(client):
    response = client.get("/api/v1/trajets")
    data = response.json()
    assert data["total"] > 0


def test_get_trajets_default_limit(client):
    response = client.get("/api/v1/trajets")
    data = response.json()
    assert len(data["trajets"]) <= 50


def test_get_trajets_custom_limit(client):
    response = client.get("/api/v1/trajets?limit=5")
    data = response.json()
    assert len(data["trajets"]) <= 5


def test_get_trajets_filter_by_service_type_night(client):
    response = client.get("/api/v1/trajets?service_type=night&limit=100")
    data = response.json()
    for trajet in data["trajets"]:
        assert trajet["service_type"] == "night"


def test_get_trajets_filter_by_service_type_day(client):
    response = client.get("/api/v1/trajets?service_type=day&limit=100")
    data = response.json()
    for trajet in data["trajets"]:
        assert trajet["service_type"] == "day"


def test_get_trajets_filter_by_country(client):
    response = client.get("/api/v1/trajets?origin_country=FR&limit=100")
    data = response.json()
    for trajet in data["trajets"]:
        assert trajet["origin_country"] == "FR"


def test_get_trajets_required_fields_present(client):
    response = client.get("/api/v1/trajets?limit=1")
    data = response.json()
    trajet = data["trajets"][0]
    assert "route_id" in trajet
    assert "origin" in trajet
    assert "destination" in trajet
    assert "service_type" in trajet


def test_get_trajet_by_valid_id(client):
    # Get a valid ID first
    list_response = client.get("/api/v1/trajets?limit=1")
    route_id = list_response.json()["trajets"][0]["route_id"]

    response = client.get(f"/api/v1/trajets/{route_id}")
    assert response.status_code == 200


def test_get_trajet_by_valid_id_returns_full_detail(client):
    list_response = client.get("/api/v1/trajets?limit=1")
    route_id = list_response.json()["trajets"][0]["route_id"]

    response = client.get(f"/api/v1/trajets/{route_id}")
    data = response.json()
    assert "train_co2_kg" in data
    assert "plane_co2_kg" in data
    assert "co2_savings_kg" in data
    assert "duration_minutes" in data


def test_get_trajet_invalid_id_returns_404(client):
    response = client.get("/api/v1/trajets/999999")
    assert response.status_code == 404


def test_get_trajet_invalid_id_error_message(client):
    response = client.get("/api/v1/trajets/999999")
    data = response.json()
    assert "detail" in data


def test_get_trajets_pagination_offset(client):
    response_page1 = client.get("/api/v1/trajets?limit=5&offset=0")
    response_page2 = client.get("/api/v1/trajets?limit=5&offset=5")
    ids_page1 = [t["route_id"] for t in response_page1.json()["trajets"]]
    ids_page2 = [t["route_id"] for t in response_page2.json()["trajets"]]
    assert ids_page1 != ids_page2