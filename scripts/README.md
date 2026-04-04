# Scripts — ObRail Europe

This folder contains utility scripts for managing and verifying the ObRail stack.
All scripts should be run from the **project root** directory.

---

## Scripts

### `healthcheck.sh`
Checks that all four services are running and responding correctly.
Run this after `docker compose up -d` to confirm the stack is healthy.

```bash
bash scripts/healthcheck.sh
```

Checks performed:
- API responds with HTTP 200 at `/api/v1/health`
- Prometheus responds at `/-/healthy`
- Grafana responds at `/api/health`
- PostgreSQL is accepting connections

---

### `seed_db.py`
Verifies that the database has been seeded correctly by checking row counts in each table.
Run this after a fresh start or database reset to confirm the init scripts executed successfully.

```bash
backend/venv/bin/python scripts/seed_db.py
```

Tables checked:
| Table | Expected minimum rows |
|---|---|
| dim_countries | 33 |
| dim_transport_modes | 8 |
| dim_train_types | 2 |
| fact_routes | 100 |

---

### `reset_db.sh`
Resets the database by removing the Docker volume and reinitialising it from scratch.
Use this during development when the schema or seed data changes.

⚠️ **This will delete all data.** You will be asked to confirm before anything is deleted.

```bash
bash scripts/reset_db.sh
```

---

## Notes

- All scripts read credentials from the `.env` file at the project root.
- Make sure Docker is running before executing any script.
- The Python scripts require the backend virtual environment: `backend/venv/bin/python`.
