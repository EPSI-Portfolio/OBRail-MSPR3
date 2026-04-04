# Database

PostgreSQL database for ObRail Europe.

## Init scripts (run automatically by Docker on first startup)
- 01_create_schema.sql  — creates all tables, views and indexes
- 02_reference_data.sql — loads transport modes and train types  
- 03_dimensions_data.sql — loads country reference data
- 04_fact_routes_data.sql — loads 448 European train routes

## Manual validation (run after startup to confirm everything loaded)
- 03_test.sql — run this manually to verify all tables and data

## To reset the database
Delete the Docker volume and run docker compose up again:
docker compose down -v
docker compose up -d