# Monitoring & Observability — ObRail Europe API

This folder contains the configuration for the ObRail observability stack.
The stack provides two complementary views of the running system:

- **Metrics** — Prometheus collects numeric measurements (request counts, rates,
  durations) from the API and Grafana visualises them in real time.
- **Logs** — the backend writes structured JSON logs that Promtail ships to Loki,
  which Grafana queries alongside the metrics.

Together they cover the **"Superviser le fonctionnement de la solution IA"**
competency: metrics tell you *that* something happened, logs tell you *what*.

---

## Architecture

```
Metrics:  backend (/metrics) ──► Prometheus (scrapes) ──► Grafana (visualises)

Logs:     backend (JSON → logs/api.log) ──► Promtail (tails) ──► Loki (stores) ──► Grafana (queries)
```

- The FastAPI backend exposes a `/metrics` endpoint via `prometheus-fastapi-instrumentator`.
- Prometheus scrapes that endpoint every 15 seconds and stores the data.
- The backend also writes JSON logs to `logs/api.log` (configured in `app/core/logging.py`).
- That file lives on a shared Docker volume (`backend_logs`) which Promtail also mounts.
- Promtail tails the file, parses each JSON line, and pushes it to Loki with labels.
- Grafana reads from both Prometheus and Loki as provisioned data sources.

---

## Structure

```
monitoring/
├── prometheus/
│   └── prometheus.yml          # What Prometheus scrapes and how often
├── promtail/
│   └── promtail-config.yml      # What logs Promtail tails and how it parses them
└── grafana/
    ├── grafana.ini              # Grafana server configuration
    └── provisioning/
        ├── datasources/
        │   ├── prometheus.yml   # Registers Prometheus as a data source
        │   └── loki.yml         # Registers Loki as a data source
        └── dashboards/
            ├── dashboard.yml    # Tells Grafana where to find dashboard files
            └── obrail.json      # The ObRail dashboard definition
```

> **Note:** Loki itself runs with the default configuration baked into its image
> (`-config.file=/etc/loki/local-config.yaml`), so there is no `loki/` folder here.

---

## Services

The whole stack starts with Docker Compose:

```bash
docker compose up -d
```

| Service | URL | Description |
|---|---|---|
| Prometheus | http://localhost:9090 | Metrics collection and querying |
| Grafana | http://localhost:3000 | Dashboards + log exploration |
| Loki | http://localhost:3100 | Log storage and querying |
| Promtail | (internal) | Tails backend logs and ships them to Loki |
| API Metrics | http://localhost:8002/metrics | Raw metrics exposed by the backend |

Grafana login credentials are set via environment variables in your `.env` file:

```dotenv
GRAFANA_USER=admin
GRAFANA_PASSWORD=your_chosen_password
```

> The Grafana admin password is only applied the **first time** the `grafana_data`
> volume is created. To change it on an existing volume, either reset it with
> `docker compose exec grafana grafana cli admin reset-admin-password '<new>'`
> or remove the volume (`docker volume rm <project>_grafana_data`) and recreate.

---

## Metrics — Dashboard Panels

The ObRail dashboard at `http://localhost:3000` shows:

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

### Verifying Prometheus is Scraping

Go to `http://localhost:9090/targets` — you should see `obrail-api` with status **UP**
in green. If it's DOWN, make sure the backend is running (`docker compose ps`).

### Useful Prometheus Queries

Run these in the Prometheus query interface at `http://localhost:9090`:

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

### How Metrics are Exposed

The backend uses `prometheus-fastapi-instrumentator`, set up once in `main.py`:

```python
Instrumentator().instrument(app).expose(app)
```

No per-endpoint code is needed — it automatically tracks request counts by
endpoint/method/status, request-duration histograms, and in-progress requests.

---

## Logs — Structured JSON via Loki

### How logs are produced

Logging is configured centrally in `app/core/logging.py`. A custom `JsonFormatter`
emits every log record as a single-line JSON object:

```json
{"timestamp": "2026-06-15T20:48:02.388979Z", "level": "INFO", "logger": "obrail", "message": "Health check passed"}
```

`setup_logging()` (called once at startup in `main.py`) attaches this formatter to:

- a **stream handler** → stdout, so logs appear in `docker compose logs backend`
- a **file handler** → `logs/api.log`, which Promtail tails

The `logs/` directory is mounted on the shared `backend_logs` Docker volume, so the
same file is visible to both the backend (writing) and Promtail (reading).

### How logs reach Loki

`promtail/promtail-config.yml` tails `/var/log/backend/*.log` and, for each line:

1. Parses the JSON to extract `timestamp`, `level`, `logger`, `message`.
2. Promotes `level` to a Loki **label** (so it can be filtered).
3. Uses the log's own `timestamp` instead of the ingestion time.

Logs are pushed to Loki under the label `job="obrail-backend"`.

### Querying logs in Grafana

Open `http://localhost:3000` → **Explore** → select the **Loki** data source, then:

```logql
# All backend logs
{job="obrail-backend"}

# Only errors
{job="obrail-backend", level="ERROR"}

# Logs containing a specific word
{job="obrail-backend"} |= "health"
```

### Verifying the log pipeline

```bash
# Promtail is running and tailing the file
docker compose ps promtail
docker compose logs promtail | tail -n 20

# Loki knows about the backend job
curl -s "http://localhost:3100/loki/api/v1/label/job/values"

# The log file is valid JSON
docker compose exec backend cat logs/api.log | tail -n 3
```

> **Important:** the backend image must contain the current `logging.py`. If logs
> appear as plain text instead of JSON, rebuild the image so it picks up the latest
> code: `docker compose up -d --build backend`.

---

## Continuous Improvement

The observability stack provides:

- Real-time visibility into API performance (metrics)
- Searchable, structured logs for debugging and audit (logs)
- Detection of error spikes, slow endpoints, and failure patterns
- Historical data to identify trends over time
- A foundation for alerting when thresholds are exceeded