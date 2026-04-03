/* =========================================================
   OBRAIL EUROPE - DATABASE SCHEMA
   ========================================================= */

-- ========================================
-- DIMENSION TABLES
-- ========================================

CREATE TABLE IF NOT EXISTS dim_countries (
    country_code VARCHAR(5)   PRIMARY KEY,
    country_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS dim_transport_modes (
    mode_id      SERIAL       PRIMARY KEY,
    mode_name    VARCHAR(50)  NOT NULL UNIQUE,
    gco2_per_pkm DECIMAL(10,2),
    source       VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS dim_train_types (
    type_id   SERIAL      PRIMARY KEY,
    type_code VARCHAR(20) NOT NULL UNIQUE,
    type_name VARCHAR(50) NOT NULL
);

-- ========================================
-- FACT TABLE
-- ========================================

CREATE TABLE IF NOT EXISTS fact_routes (
    route_id SERIAL PRIMARY KEY,
    route_name        VARCHAR(200),
    route_name_simple VARCHAR(200),
    origin              VARCHAR(100) NOT NULL,
    destination         VARCHAR(100) NOT NULL,
    origin_country      VARCHAR(5),
    destination_country VARCHAR(5),
    distance_km  DECIMAL(10,2),
    service_type VARCHAR(20),
    train_type   VARCHAR(20),
    operator     VARCHAR(100),
    train_gco2_pkm DECIMAL(10,2),
    plane_gco2_pkm DECIMAL(10,2),
    train_co2_kg    DECIMAL(10,2),
    plane_co2_kg    DECIMAL(10,2),
    co2_savings_kg  DECIMAL(10,2),
    savings_percent DECIMAL(5,2),
    emission_source  VARCHAR(100),
    calculation_date DATE,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    duration_minutes INTEGER,

    CONSTRAINT fk_origin_country
        FOREIGN KEY (origin_country)
        REFERENCES dim_countries(country_code)
        ON DELETE SET NULL,

    CONSTRAINT fk_destination_country
        FOREIGN KEY (destination_country)
        REFERENCES dim_countries(country_code)
        ON DELETE SET NULL,

    CONSTRAINT fk_train_type
        FOREIGN KEY (train_type)
        REFERENCES dim_train_types(type_code)
        ON DELETE SET NULL
);

-- ========================================
-- INDEXES
-- ========================================

CREATE INDEX IF NOT EXISTS idx_routes_origin_country      ON fact_routes(origin_country);
CREATE INDEX IF NOT EXISTS idx_routes_destination_country ON fact_routes(destination_country);
CREATE INDEX IF NOT EXISTS idx_routes_train_type          ON fact_routes(train_type);
CREATE INDEX IF NOT EXISTS idx_routes_service_type        ON fact_routes(service_type);
CREATE INDEX IF NOT EXISTS idx_routes_co2_savings         ON fact_routes(co2_savings_kg DESC);
CREATE INDEX IF NOT EXISTS idx_routes_distance            ON fact_routes(distance_km);

-- ========================================
-- VIEWS
-- ========================================

CREATE OR REPLACE VIEW v_savings_by_country AS
SELECT
    origin_country,
    COUNT(*)                             AS route_count,
    ROUND(SUM(co2_savings_kg), 2)        AS total_savings_kg,
    ROUND(AVG(co2_savings_kg), 2)        AS avg_savings_per_route_kg,
    ROUND(SUM(co2_savings_kg) / 1000, 2) AS total_savings_tons
FROM fact_routes
WHERE origin_country IS NOT NULL
  AND co2_savings_kg IS NOT NULL
GROUP BY origin_country
ORDER BY total_savings_kg DESC;

CREATE OR REPLACE VIEW v_top_routes_savings AS
WITH deduped AS (
    SELECT *,
        CASE WHEN origin < destination THEN origin ELSE destination END AS o_norm,
        CASE WHEN origin < destination THEN destination ELSE origin END AS d_norm,
        ROUND(distance_km) AS dist_norm
    FROM fact_routes
    WHERE co2_savings_kg IS NOT NULL
),
ranked AS (
    SELECT
        route_name_simple, origin, destination,
        origin_country, destination_country,
        distance_km, train_type, co2_savings_kg, savings_percent,
        ROW_NUMBER() OVER (
            PARTITION BY o_norm, d_norm, dist_norm
            ORDER BY co2_savings_kg DESC
        ) AS rn
    FROM deduped
)
SELECT
    route_name_simple, origin, destination,
    origin_country, destination_country,
    distance_km, train_type, co2_savings_kg, savings_percent
FROM ranked
WHERE rn = 1
ORDER BY co2_savings_kg DESC
LIMIT 50;

CREATE OR REPLACE VIEW v_summary_stats AS
SELECT
    COUNT(*)                                       AS total_routes,
    COUNT(*) FILTER (WHERE service_type = 'night') AS night_routes,
    COUNT(*) FILTER (WHERE service_type = 'day')   AS day_routes,
    COUNT(DISTINCT origin_country)                 AS countries_covered,
    ROUND(AVG(distance_km), 2)                     AS avg_distance_km,
    ROUND(SUM(co2_savings_kg), 2)                  AS total_co2_saved_kg,
    ROUND(SUM(co2_savings_kg) / 1000, 2)           AS total_co2_saved_tons,
    ROUND(AVG(savings_percent), 2)                 AS avg_savings_percent
FROM fact_routes;

CREATE OR REPLACE VIEW v_routes_by_type AS
SELECT
    service_type,
    COUNT(*)                      AS route_count,
    ROUND(AVG(distance_km), 2)    AS avg_distance_km,
    ROUND(SUM(co2_savings_kg), 2) AS total_savings_kg
FROM fact_routes
WHERE service_type IS NOT NULL
GROUP BY service_type
ORDER BY route_count DESC;

CREATE OR REPLACE VIEW v_volumes_by_country AS
SELECT
    origin_country,
    service_type,
    COUNT(*)                   AS route_count,
    ROUND(AVG(distance_km), 2) AS avg_distance_km
FROM fact_routes
WHERE origin_country IS NOT NULL
    AND service_type IS NOT NULL
GROUP BY origin_country, service_type
ORDER BY origin_country, service_type;