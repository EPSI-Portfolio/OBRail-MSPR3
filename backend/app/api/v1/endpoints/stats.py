"""
Stats Endpoints
===============
Aggregated statistics for the frontend dashboard.

GET /stats/volumes   - day/night route counts by country
GET /stats/co2       - CO2 savings summary and by country
"""

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
from app.api.deps import get_db
from app.schemas.trajet import VolumeStatsResponse, VolumeStats, Co2StatsResponse, Co2Stats
import logging

router = APIRouter()
logger = logging.getLogger("obrail")


@router.get(
    "/stats/volumes",
    response_model=VolumeStatsResponse,
    summary="Volumes par pays et type",
    description="Returns day/night route counts grouped by origin country."
)
async def get_volumes(db: Session = Depends(get_db)):
    logger.info("GET /stats/volumes")

    rows = db.execute(text("""
        SELECT
            origin_country,
            service_type,
            COUNT(*) as route_count,
            ROUND(AVG(distance_km)::numeric, 2) as avg_distance_km
        FROM fact_routes
        WHERE origin_country IS NOT NULL
            AND service_type IS NOT NULL
        GROUP BY origin_country, service_type
        ORDER BY origin_country, service_type
    """)).fetchall()

    data = [
        VolumeStats(
            origin_country=r[0],
            service_type=r[1],
            route_count=r[2],
            avg_distance_km=r[3]
        )
        for r in rows
    ]

    logger.info(f"GET /stats/volumes — {len(data)} rows returned")
    return VolumeStatsResponse(total=len(data), data=data)


@router.get(
    "/stats/co2",
    response_model=Co2StatsResponse,
    summary="Impact CO2 par pays",
    description="Returns global CO2 savings summary and breakdown by country."
)
async def get_co2_stats(db: Session = Depends(get_db)):
    logger.info("GET /stats/co2")

    # Global summary
    summary = db.execute(text("""
        SELECT
            COUNT(*) as total_routes,
            ROUND(SUM(co2_savings_kg)::numeric, 2) as total_savings_kg,
            ROUND(AVG(savings_percent)::numeric, 2) as avg_savings_pct
        FROM fact_routes
        WHERE co2_savings_kg IS NOT NULL
    """)).fetchone()

    # By country
    rows = db.execute(text("""
        SELECT
            origin_country,
            COUNT(*) as route_count,
            ROUND(SUM(co2_savings_kg)::numeric, 2) as total_savings_kg,
            ROUND(AVG(co2_savings_kg)::numeric, 2) as avg_savings_per_route_kg,
            ROUND(SUM(co2_savings_kg)::numeric / 1000, 2) as total_savings_tons
        FROM fact_routes
        WHERE origin_country IS NOT NULL
            AND co2_savings_kg IS NOT NULL
        GROUP BY origin_country
        ORDER BY total_savings_kg DESC
    """)).fetchall()

    by_country = [
        Co2Stats(
            origin_country=r[0],
            route_count=r[1],
            total_savings_kg=r[2],
            avg_savings_per_route_kg=r[3],
            total_savings_tons=r[4]
        )
        for r in rows
    ]

    total_kg = summary[1] or 0
    logger.info(f"GET /stats/co2 — {summary[0]} routes, {total_kg:.2f} kg saved total")

    return Co2StatsResponse(
        total_routes=summary[0],
        total_co2_saved_kg=total_kg,
        total_co2_saved_tons=round(total_kg / 1000, 2) if total_kg else 0,
        avg_savings_percent=summary[2],
        by_country=by_country
    )