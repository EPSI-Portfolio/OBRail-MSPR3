# Tests — ObRail Europe API

This folder contains all tests for the ObRail Europe API backend.
Tests are organised into four categories that together cover the full testing methodology required for production-grade AI solutions.

---

## Structure

```
tests/
├── integration/          # API endpoint tests (HTTP level)
│   ├── test_health_api.py
│   ├── test_trajets_api.py
│   └── test_stats_api.py
├── security/             # Input validation and security tests
│   ├── test_health_security.py
│   ├── test_trajets_security.py
│   └── test_stats_security.py
├── unit/                 # Pure business logic tests (no DB, no HTTP)
│   └── test_business_logic.py
├── load/                 # Load and performance tests (Locust)
│   └── locustfile.py
├── conftest.py           # Shared fixtures (test client setup)
└── README.md             # This file
```

---

## Test Categories

### Integration Tests
Test the API endpoints end-to-end over HTTP using a real test database.
They verify that each endpoint returns the correct status code, response structure, and data.

Covers:
- `GET /api/v1/health` — health check and database connectivity
- `GET /api/v1/trajets` — listing, filtering, and pagination
- `GET /api/v1/trajets/{id}` — single route detail and 404 handling
- `GET /api/v1/stats/volumes` — route volume statistics
- `GET /api/v1/stats/co2` — CO2 savings statistics

### Security Tests
Test that the API handles malicious or invalid input safely without crashing or leaking data.

Covers:
- SQL injection attempts in query parameters
- Invalid parameter types (strings where integers are expected)
- Out-of-range values (negative IDs, limit=0, limit=9999)
- Wrong HTTP methods (POST/PUT/DELETE on GET-only endpoints)
- Non-existent endpoints and wrong API version prefixes
- Sensitive data not exposed in responses

### Unit Tests
Test pure business logic functions in isolation — no database connection or HTTP requests needed.
These run instantly and verify that calculations and transformations are correct.

Covers:
- CO2 savings calculations (kg, tons, percentage)
- Pagination offset logic
- Country code normalisation (uppercase)
- Service type validation (day/night)
- Distance filter validation

### Load Tests
Simulate concurrent users hitting the API to verify performance under stress.
Uses [Locust](https://locust.io) — see the [Load Testing section](#load-testing) below.

---

## Running the Tests

### Prerequisites
Make sure the Docker database is running:
```bash
docker compose up -d db
```

### Run all tests
```bash
cd backend
pytest tests/ -v
```

### Run by category
```bash
pytest tests/integration/ -v
pytest tests/security/ -v
pytest tests/unit/ -v
```

### Run a single file
```bash
pytest tests/integration/test_health_api.py -v
```

---

## Load Testing

Load tests use [Locust](https://locust.io) to simulate multiple concurrent users.

### Prerequisites
Make sure the full API is running:
```bash
docker compose up -d
```

### Run with web interface
```bash
cd backend
locust -f tests/load/locustfile.py --host=http://localhost:8002
```
Then open `http://localhost:8089` in your browser to control the test.

Recommended settings for a basic load test:
- Number of users: **50**
- Spawn rate: **5 users/second**
- Duration: **60 seconds**

### Run headless (no browser)
```bash
locust -f tests/load/locustfile.py --host=http://localhost:8002 \
       --headless -u 50 -r 5 -t 60s \
       --html=tests/load/report.html
```
This generates an HTML report at `tests/load/report.html`.

### User profiles simulated
| Profile | Behaviour | Weight |
|---|---|---|
| `ObRailAPIUser` | Normal user browsing trajets and stats, 1–3s between requests | 3 |
| `ObRailHeavyUser` | Data analyst making rapid requests, 0.1–0.5s between requests | 1 |

---

## Test Coverage Summary

| Category | Files | Tests |
|---|---|---|
| Integration | 3 | ~32 |
| Security | 3 | ~30 |
| Unit | 1 | ~16 |
| Load | 1 | Locust scenarios |
| **Total** | **8** | **~78** |

---

## Configuration

The test client is configured in `conftest.py`.
Database connection uses environment variables from `.env`:

```
POSTGRES_HOST=localhost
POSTGRES_PORT=5434
POSTGRES_USER=obrail_user
POSTGRES_PASSWORD=<your_password>
POSTGRES_DB=obrail_db
```

In CI (GitHub Actions), these are injected via GitHub Secrets.