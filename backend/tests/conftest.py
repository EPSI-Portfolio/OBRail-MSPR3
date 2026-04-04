"""
Test Configuration
==================
Shared fixtures for all tests.
Sets up a test client that connects to the running Docker database.
"""

import pytest
from fastapi.testclient import TestClient
from app.main import app


@pytest.fixture(scope="module")
def client():
    """Test client for making requests to the API."""
    with TestClient(app) as c:
        yield c