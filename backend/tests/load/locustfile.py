"""
Load Tests - ObRail Europe API
================================
Uses Locust to simulate concurrent users hitting the API.
The API key is loaded automatically from the project root .env file.

Run (with API running on localhost:8002):
    locust -f tests/load/locustfile.py --host=http://localhost:8002

Then open http://localhost:8089 to control the test.

For CI/headless mode (50 users, 5 spawn rate, 60s duration):
    locust -f tests/load/locustfile.py --host=http://localhost:8002 \
        --headless -u 50 -r 5 -t 60s \
        --html=tests/load/report.html
"""

import os
from dotenv import load_dotenv
from locust import HttpUser, task, between

# Load .env from the project root so API_KEY is available.
load_dotenv(os.path.join(os.path.dirname(__file__), '..', '..', '..', '.env'))


class ObRailAPIUser(HttpUser):
    """
    Simulates a typical frontend user browsing the ObRail API.
    Waits between 1 and 3 seconds between requests (realistic usage).
    """
    wait_time = between(1, 3)
    weight = 3  # 3 normal users for every 1 heavy user

    def on_start(self):
        """Adds the API key header to all requests if configured."""
        api_key = os.getenv("API_KEY", "")
        if api_key:
            self.client.headers.update({"X-API-Key": api_key})

    # --- Health Check ---

    @task(1)
    def health_check(self):
        """Low frequency — monitoring ping."""
        self.client.get("/api/v1/health")

    # --- Trajets ---

    @task(5)
    def list_trajets(self):
        """Most common request — list all trajets."""
        self.client.get("/api/v1/trajets")

    @task(3)
    def list_trajets_day(self):
        """Filter by day service."""
        self.client.get("/api/v1/trajets?service_type=day&limit=20")

    @task(3)
    def list_trajets_night(self):
        """Filter by night service."""
        self.client.get("/api/v1/trajets?service_type=night&limit=20")

    @task(2)
    def list_trajets_by_country(self):
        """Filter by French routes."""
        self.client.get("/api/v1/trajets?origin_country=FR&limit=20")

    @task(2)
    def list_trajets_paginated(self):
        """Pagination — second page."""
        self.client.get("/api/v1/trajets?limit=10&offset=10")

    @task(2)
    def get_single_trajet(self):
        """Get a specific trajet by ID."""
        self.client.get("/api/v1/trajets/1")

    @task(1)
    def get_nonexistent_trajet(self):
        """404 handling under load — expected to return 404, not a failure."""
        with self.client.get(
            "/api/v1/trajets/999999",
            catch_response=True
        ) as response:
            if response.status_code == 404:
                response.success()

    # --- Stats ---

    @task(3)
    def get_volumes_stats(self):
        """Volume stats for dashboard."""
        self.client.get("/api/v1/stats/volumes")

    @task(3)
    def get_co2_stats(self):
        """CO2 stats for dashboard."""
        self.client.get("/api/v1/stats/co2")


class ObRailHeavyUser(HttpUser):
    """
    Simulates a data analyst making rapid successive requests.
    Shorter wait time to stress test the API under higher load.
    """
    wait_time = between(0.1, 0.5)
    weight = 1  # 1 heavy user for every 3 normal users

    def on_start(self):
        """Adds the API key header to all requests if configured."""
        api_key = os.getenv("API_KEY", "")
        if api_key:
            self.client.headers.update({"X-API-Key": api_key})

    @task(3)
    def rapid_trajets(self):
        """Rapid listing of all trajets."""
        self.client.get("/api/v1/trajets?limit=100")

    @task(2)
    def rapid_co2(self):
        """Rapid CO2 stats requests."""
        self.client.get("/api/v1/stats/co2")

    @task(1)
    def rapid_volumes(self):
        """Rapid volume stats requests."""
        self.client.get("/api/v1/stats/volumes")