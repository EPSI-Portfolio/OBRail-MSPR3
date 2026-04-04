# Monitoring — ObRail Europe API

This folder contains the configuration for the ObRail monitoring stack.
The stack uses Prometheus to collect metrics from the API and Grafana to visualise them in real time.

---

## Architecture

```
backend (/metrics) → Prometheus (collects) → Grafana (visualises)
```

- The FastAPI backend exposes a `/metrics` endpoint automatically via `prometheus-fastapi-instrumentator`.
- Prometheus scrapes this endpoint every 15 seconds and stores the data.
- Grafana reads from Prometheus and displays the data on a live dashboard.

---

## Structure

```
monitoring/
├── prometheus/
│   └── prometheus.yml        # Defines what Prometheus scrapes and how often
└── grafana/
    ├── grafana.ini            # Grafana server configuration
    └── provisioning/
        ├── datasources/
        │   └── prometheus.yml # Tells Grafana to use Prometheus as its data source
        └── dashboards/
            ├── dashboard.yml  # Tells Grafana where to find dashboard files
            └── obrail.json    # The ObRail dashboard definition
```

---

## Dashboard Panels

The ObRail dashboard at `http://localhost:3000` shows the following panels:

| Panel | Description |
|---|---|
| Total HTTP Requests | Cumulative number of requests received since startup |
| Request Rate (req/s) | Current number of requests per second |
| Error Rate (4xx + 5xx) | Number of failed requests per second |
| Average Response Time (ms) | Mean response time across all endpoints |
| Requests per Endpoint | Request rate broken down by each API endpoint |
| Response Time by Endpoint (p95) | 95th percentile response time per endpoint |
| HTTP Status Codes | Request rate grouped by HTTP status code |
| Active Requests | Number of requests currently being processed |

---

## Running the Monitoring Stack

The monitoring stack starts automatically with Docker Compose.

```bash
docker compose up -d
```

| Service | URL | Description |
|---|---|---|
| Prometheus | http://localhost:9090 | Metrics collection and querying |
| Grafana | http://localhost:3000 | Dashboard visualisation |
| API Metrics | http://localhost:8002/metrics | Raw metrics exposed by the backend |

Grafana login credentials are set via environment variables in your `.env` file:

```dotenv
GRAFANA_USER=admin
GRAFANA_PASSWORD=your_chosen_password
```

---

## Verifying Prometheus is Scraping

Go to `http://localhost:9090/targets` — you should see `obrail-api` with status **UP** in green.
If the status is DOWN, make sure the backend container is running with `docker compose ps`.

---

## Useful Prometheus Queries

You can run these directly in the Prometheus query interface at `http://localhost:9090`:

```promql
# Total number of HTTP requests
sum(http_requests_total{job="obrail-api"})

# Request rate per second over the last minute
sum(rate(http_requests_total{job="obrail-api"}[1m]))

# Error rate (4xx and 5xx) per second
sum(rate(http_requests_total{job="obrail-api", status=~"4..|5.."}[1m]))

# Average response time in milliseconds
sum(rate(http_request_duration_seconds_sum{job="obrail-api"}[1m]))
/ sum(rate(http_request_duration_seconds_count{job="obrail-api"}[1m])) * 1000

# 95th percentile response time per endpoint
histogram_quantile(0.95, sum by (handler, le) (
  rate(http_request_duration_seconds_bucket{job="obrail-api"}[1m])
)) * 1000
```

---

## How Metrics are Exposed

The backend uses `prometheus-fastapi-instrumentator` which automatically tracks:

- Number of HTTP requests by endpoint, method and status code
- Request duration histograms
- Number of requests currently in progress

No additional code is needed in the endpoints — instrumentation is set up once in `main.py`:

```python
Instrumentator().instrument(app).expose(app)
```
---

## Continuous Improvement

The monitoring stack supports the **"Superviser le fonctionnement de la solution IA"** competency by providing:

- Real-time visibility into API performance
- Detection of error spikes and slow endpoints
- Historical data to identify trends over time
- A foundation for setting up alerts if thresholds are exceeded