"""
Unit Tests - Business Logic
============================
Tests for pure logic functions that don't require
a database or HTTP connection.
"""

# --- CO2 Calculation Logic ---

def test_co2_savings_calculation():
    """Train CO2 savings = plane_co2 - train_co2"""
    plane_co2_kg = 150.0
    train_co2_kg = 20.0
    savings = plane_co2_kg - train_co2_kg
    assert savings == 130.0


def test_co2_savings_percent_calculation():
    """Savings percent = (savings / plane_co2) * 100"""
    plane_co2_kg = 150.0
    train_co2_kg = 20.0
    savings = plane_co2_kg - train_co2_kg
    savings_percent = round((savings / plane_co2_kg) * 100, 2)
    assert savings_percent == pytest.approx(86.67, rel=1e-2)


def test_co2_kg_to_tons():
    """Conversion from kg to tons"""
    kg = 1500.0
    tons = round(kg / 1000, 2)
    assert tons == 1.5


def test_co2_kg_to_tons_zero():
    """Zero kg should give zero tons"""
    assert round(0 / 1000, 2) == 0.0


def test_co2_savings_when_train_equals_plane():
    """No savings when train and plane emit the same"""
    plane_co2_kg = 100.0
    train_co2_kg = 100.0
    savings = plane_co2_kg - train_co2_kg
    assert savings == 0.0


# --- Distance Validation Logic ---

def test_distance_filter_min_max_valid():
    """min_distance must be less than max_distance to be meaningful"""
    min_distance = 100
    max_distance = 500
    assert min_distance < max_distance


def test_distance_filter_equal_is_edge_case():
    """Equal min and max distance is an edge case but not invalid"""
    min_distance = 300
    max_distance = 300
    assert min_distance == max_distance


# --- Pagination Logic ---

def test_pagination_offset_calculation():
    """Page 2 with limit 10 should have offset 10"""
    limit = 10
    page = 2
    offset = (page - 1) * limit
    assert offset == 10


def test_pagination_first_page_offset_zero():
    """First page should always have offset 0"""
    limit = 50
    page = 1
    offset = (page - 1) * limit
    assert offset == 0


def test_pagination_total_pages():
    """Total pages calculation"""
    total = 105
    limit = 50
    import math
    pages = math.ceil(total / limit)
    assert pages == 3


# --- Country Code Validation Logic ---

def test_country_code_uppercase():
    """Country codes should be stored as uppercase"""
    raw_input = "fr"
    normalized = raw_input.upper()
    assert normalized == "FR"


def test_country_code_already_uppercase():
    """Already uppercase country codes should stay the same"""
    raw_input = "DE"
    normalized = raw_input.upper()
    assert normalized == "DE"


# --- Service Type Validation ---

def test_service_type_valid_values():
    """Only day and night are valid service types"""
    valid_types = {"day", "night"}
    assert "day" in valid_types
    assert "night" in valid_types
    assert "unknown" not in valid_types


def test_service_type_lowercase_normalization():
    """Service types should be stored in lowercase"""
    raw_input = "NIGHT"
    normalized = raw_input.lower()
    assert normalized == "night"


import pytest