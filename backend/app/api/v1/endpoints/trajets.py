"""
Trajets Endpoints
=================
Routes for querying train routes (trajets).

GET /trajets         - list with filters and pagination
GET /trajets/{id}    - single route by ID
"""

from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from sqlalchemy import text
from typing import Optional
from app.api.deps import get_db
from app.schemas.trajet import TrajetBase, TrajetSummary, TrajetsResponse
import logging

router = APIRouter()
logger = logging.getLogger("obrail")


@router.get(
    "/trajets",
    response_model=TrajetsResponse,
    summary="Liste des trajets",
    description="Returns paginated list of train routes with optional filters."
)
async def get_trajets(
    service_type: Optional[str]        = Query(None, description="day or night"),
    origin_country: Optional[str]      = Query(None, description="Origin country code e.g. FR"),
    destination_country: Optional[str] = Query(None, description="Destination country code"),
    origin: Optional[str]              = Query(None, description="Origin city name (partial match)"),
    destination: Optional[str]         = Query(None, description="Destination city name (partial match)"),
    operator: Optional[str]            = Query(None, description="Operator e.g. DB, SNCF, ÖBB"),
    min_distance: Optional[float]      = Query(None, description="Minimum distance in km"),
    max_distance: Optional[float]      = Query(None, description="Maximum distance in km"),
    limit: int  = Query(50,  ge=1, le=500, description="Results per page"),
    offset: int = Query(0,   ge=0,         description="Pagination offset"),
    db: Session = Depends(get_db)
):
    logger.info(
        f"GET /trajets — service_type={service_type}, "
        f"origin_country={origin_country}, limit={limit}, offset={offset}"
    )

    conditions = ["1=1"]
    params = {}

    if service_type:
        conditions.append("service_type = :service_type")
        params["service_type"] = service_type.lower()

    if origin_country:
        conditions.append("origin_country = :origin_country")
        params["origin_country"] = origin_country.upper()

    if destination_country:
        conditions.append("destination_country = :destination_country")
        params["destination_country"] = destination_country.upper()

    if origin:
        conditions.append("LOWER(origin) LIKE LOWER(:origin)")
        params["origin"] = f"%{origin}%"

    if destination:
        conditions.append("LOWER(destination) LIKE LOWER(:destination)")
        params["destination"] = f"%{destination}%"

    if operator:
        conditions.append("LOWER(operator) LIKE LOWER(:operator)")
        params["operator"] = f"%{operator}%"

    if min_distance is not None:
        conditions.append("distance_km >= :min_distance")
        params["min_distance"] = min_distance

    if max_distance is not None:
        conditions.append("distance_km <= :max_distance")
        params["max_distance"] = max_distance

    where = " AND ".join(conditions)

    # Total count for pagination
    count_result = db.execute(
        text(f"SELECT COUNT(*) FROM fact_routes WHERE {where}"),
        params
    ).fetchone()
    total = count_result[0]

    # Fetch page
    params["limit"]  = limit
    params["offset"] = offset

    rows = db.execute(text(f"""
        SELECT
            route_id,
            route_name_simple,
            origin,
            destination,
            origin_country,
            destination_country,
            distance_km,
            service_type,
            operator,
            co2_savings_kg,
            savings_percent,
            duration_minutes
        FROM fact_routes
        WHERE {where}
        ORDER BY co2_savings_kg DESC NULLS LAST
        LIMIT :limit OFFSET :offset
    """), params).fetchall()

    trajets = [
        TrajetSummary(
            route_id=r.route_id,
            route_name_simple=r.route_name_simple,
            origin=r.origin,
            destination=r.destination,
            origin_country=r.origin_country,
            destination_country=r.destination_country,
            distance_km=r.distance_km,
            service_type=r.service_type,
            operator=r.operator,
            co2_savings_kg=r.co2_savings_kg,
            savings_percent=r.savings_percent,
            duration_minutes=r.duration_minutes
        )
        for r in rows
    ]

    logger.info(f"GET /trajets — returned {len(trajets)} of {total} total")
    return TrajetsResponse(total=total, limit=limit, offset=offset, trajets=trajets)


@router.get(
    "/trajets/{route_id}",
    response_model=TrajetBase,
    summary="Détail d'un trajet",
    description="Returns full details of a single route including all CO2 data."
)
async def get_trajet_by_id(route_id: int, db: Session = Depends(get_db)):
    logger.info(f"GET /trajets/{route_id}")

    row = db.execute(
        text("""
            SELECT
                route_id, route_name, route_name_simple,
                origin, destination, origin_country, destination_country,
                distance_km, service_type, train_type, operator,
                train_gco2_pkm, plane_gco2_pkm, train_co2_kg, plane_co2_kg,
                co2_savings_kg, savings_percent, emission_source,
                calculation_date, duration_minutes
            FROM fact_routes
            WHERE route_id = :id
        """),
        {"id": route_id}
    ).fetchone()

    if not row:
        logger.warning(f"Route {route_id} not found")
        raise HTTPException(
            status_code=404,
            detail=f"Trajet {route_id} introuvable"
        )

    logger.info(f"GET /trajets/{route_id} — found: {row.origin} → {row.destination}")

    return TrajetBase(
        route_id=row.route_id,
        route_name=row.route_name,
        route_name_simple=row.route_name_simple,
        origin=row.origin,
        destination=row.destination,
        origin_country=row.origin_country,
        destination_country=row.destination_country,
        distance_km=row.distance_km,
        service_type=row.service_type,
        train_type=row.train_type,
        operator=row.operator,
        train_gco2_pkm=row.train_gco2_pkm,
        plane_gco2_pkm=row.plane_gco2_pkm,
        train_co2_kg=row.train_co2_kg,
        plane_co2_kg=row.plane_co2_kg,
        co2_savings_kg=row.co2_savings_kg,
        savings_percent=row.savings_percent,
        emission_source=row.emission_source,
        calculation_date=row.calculation_date,
        duration_minutes=row.duration_minutes
    )