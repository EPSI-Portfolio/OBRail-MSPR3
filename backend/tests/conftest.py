"""
Test Configuration
==================
Shared fixtures for all tests.
Sets up a test client that connects to the running Docker database.
The API key is loaded from the environment so it is never hardcoded.
"""

import os
import pytest
from fastapi.testclient import TestClient
from app.main import app


@pytest.fixture(scope="module")
def client():
    """Test client for making requests to the API.
    Includes the X-API-Key header if API_KEY is set in the environment.
    """
    api_key = os.getenv("API_KEY", "")
    headers = {"X-API-Key": api_key} if api_key else {}
    with TestClient(app, headers=headers) as c:
        yield c