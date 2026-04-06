# ObRail Europe — Backend API

A FastAPI-based REST API exposing European train route data with CO2 impact analysis.
Built with Python 3.12, PostgreSQL 15, and Docker as part of MSPR 3 — Bloc E6.3.

---

## Features

- **Train Routes** — paginated list with filters (country, service type, distance, operator)
- **CO2 Statistics** — savings analysis by country and service type
- **Health Monitoring** — database connectivity, uptime and route counts
- **API Security** — API key authentication via `X-API-Key` header
- **Monitoring** — Prometheus metrics exposed at `/metrics`, visualised in Grafana
- **Auto Documentation** — Swagger UI available in development

---

## Tech Stack

- **Framework** — FastAPI (Python 3.12)
- **Database** — PostgreSQL 15 with SQLAlchemy
- **Containerisation** — Docker
- **Testing** — Pytest (integration, security, unit, load)
- **Load Testing** — Locust
- **Monitoring** — Prometheus + Grafana

---

## Project Structure

```
backend/
├── app/
│   ├── main.py                   # Application entry point
│   ├── api/
│   │   ├── deps.py               # Shared dependencies (DB session)
│   │   └── v1/
│   │       ├── router.py         # Route registration with API key protection
│   │       └── endpoints/
│   │           ├── trajets.py    # GET /trajets and GET /trajets/{id}
│   │           ├── stats.py      # GET /stats/volumes and GET /stats/co2
│   │           └── health.py     # GET /health
│   ├── core/
│   │   ├── config.py             # All settings from environment variables
│   │   ├── logging.py            # Structured logging configuration
│   │   └── security.py          # API key auth and audit logging
│   ├── db/
│   │   ├── base.py               # SQLAlchemy declarative base
│   │   ├── session.py            # Database engine and connection pool
│   │   └── init_db.py            # Database connectivity check on startup
│   ├── models/
│   │   └── trajet.py             # SQLAlchemy ORM model for fact_routes
│   └── schemas/
│       └── trajet.py             # Pydantic schemas for validation and docs
├── tests/
│   ├── conftest.py               # Shared fixtures and test client setup
│   ├── integration/              # Full API endpoint tests
│   ├── security/                 # Input validation and security tests
│   ├── unit/                     # Pure business logic tests
│   └── load/
│       └── locustfile.py         # Locust load test scenarios
├── Dockerfile                    # Container build instructions
└── requirements.txt              # Python dependencies
```

---

## Getting Started

### With Docker (recommended)

From the project root:

```bash
docker compose up -d
```

| Service | URL |
|---|---|
| API | http://localhost:8002 |
| Swagger docs | http://localhost:8002/api/v1/docs |
| Prometheus | http://localhost:9090 |
| Grafana | http://localhost:3000 |

### Local Setup

```bash
cd backend
python -m venv venv
source venv/bin/activate        # Windows: venv\Scripts\activate
pip install -r requirements.txt
```

Make sure the Docker database is running, then:

```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

---

## API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/v1/health` | Health check — API status, DB connectivity, uptime |
| GET | `/api/v1/trajets` | List routes with filters and pagination |
| GET | `/api/v1/trajets/{id}` | Full detail of one route including CO2 data |
| GET | `/api/v1/stats/volumes` | Route counts by country and service type |
| GET | `/api/v1/stats/co2` | CO2 savings summary and breakdown by country |
| GET | `/metrics` | Prometheus metrics |

### Query Parameters for `/api/v1/trajets`

| Parameter | Type | Description |
|---|---|---|
| `service_type` | string | `day` or `night` |
| `origin_country` | string | Country code e.g. `FR`, `DE` |
| `destination_country` | string | Country code |
| `origin` | string | City name (partial match) |
| `destination` | string | City name (partial match) |
| `operator` | string | e.g. `SNCF`, `DB`, `ÖBB` |
| `min_distance` | float | Minimum distance in km |
| `max_distance` | float | Maximum distance in km |
| `limit` | int | Results per page (1-500, default 50) |
| `offset` | int | Pagination offset (default 0) |

### Authentication

All endpoints require an `X-API-Key` header when `API_KEY` is set in `.env`:

```bash
curl -H "X-API-Key: your_key" http://localhost:8002/api/v1/trajets
```

---

## Environment Variables

Copy `.env.example` from the project root to `.env` and fill in your values.

| Variable | Description |
|---|---|
| `POSTGRES_USER` | Database username |
| `POSTGRES_PASSWORD` | Database password |
| `POSTGRES_DB` | Database name |
| `POSTGRES_HOST` | Database host |
| `POSTGRES_PORT` | Database port (5434) |
| `ENVIRONMENT` | `development` or `production` |
| `API_KEY` | API key for endpoint protection |
| `SECRET_KEY` | Key for signing audit log entries |

---

## Running Tests

Make sure the Docker database is running:

```bash
docker compose up -d db
```

```bash
cd backend

# Run all tests
pytest tests/ -v

# Run by category
pytest tests/integration/ -v    # API endpoint tests
pytest tests/security/ -v       # Security and validation tests
pytest tests/unit/ -v           # Business logic tests
```

---

## Load Testing with Locust

Make sure the full stack is running:

```bash
docker compose up -d
```

Start Locust:

```bash
cd backend
locust -f tests/load/locustfile.py --host=http://localhost:8002
```

Then open `http://localhost:8089` in your browser.

Recommended settings:
- Number of users: **50**
- Spawn rate: **5 users/second**
- Duration: **60 seconds**

To run headless and generate an HTML report:

```bash
locust -f tests/load/locustfile.py --host=http://localhost:8002 \
    --headless -u 50 -r 5 -t 60s \
    --html=tests/load/report.html
```

Two user profiles are simulated:
- **ObRailAPIUser** — normal user, realistic browsing pattern, 1-3s between requests
- **ObRailHeavyUser** — data analyst, rapid requests, 0.1-0.5s between requests

---

## Monitoring

Prometheus scrapes `/metrics` every 15 seconds. Grafana displays:

- Total requests and request rate
- Error rate (4xx + 5xx)
- Average and p95 response times per endpoint
- Active requests

See `monitoring/README.md` for details.