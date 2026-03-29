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
from app.core.config import settings
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
    service_type: Optional[str]   = Query(None, description="day or night"),
    origin_country: Optional[str] = Query(None, description="Origin country code e.g. FR"),
    destination_country: Optional[str] = Query(None, description="Destination country code"),
    origin: Optional[str]         = Query(None, description="Origin city name (partial match)"),
    destination: Optional[str]    = Query(None, description="Destination city name (partial match)"),
    operator: Optional[str]       = Query(None, description="Operator e.g. DB, SNCF, ÖBB"),
    min_distance: Optional[float] = Query(None, description="Minimum distance in km"),
    max_distance: Optional[float] = Query(None, description="Maximum distance in km"),
    limit: int  = Query(50,  ge=1, le=500, description="Results per page"),
    offset: int = Query(0,   ge=0,         description="Pagination offset"),
    db: Session = Depends(get_db)
):
    logger.info(
        f"GET /trajets — service_type={service_type}, origin_country={origin_country}, "
        f"limit={limit}, offset={offset}"
    )

    # Build query dynamically
    conditions = ["1=1"]
    params = {}

    if service_type:
        conditions.append("service_type = :service_type")
        params["service_type"] = service_type

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

    # Count total for pagination
    count_result = db.execute(
        text(f"SELECT COUNT(*) FROM fact_routes WHERE {where}"),
        params
    ).fetchone()
    total = count_result[0]

    # Fetch results
    params["limit"]  = limit
    params["offset"] = offset
    rows = db.execute(text(f"""
        SELECT
            route_id, route_name_simple, origin, destination,
            origin_country, destination_country, distance_km,
            service_type, operator, co2_savings_kg, savings_percent
        FROM fact_routes
        WHERE {where}
        ORDER BY co2_savings_kg DESC NULLS LAST
        LIMIT :limit OFFSET :offset
    """), params).fetchall()

    trajets = [
        TrajetSummary(
            route_id=r[0],
            route_name_simple=r[1],
            origin=r[2],
            destination=r[3],
            origin_country=r[4],
            destination_country=r[5],
            distance_km=r[6],
            service_type=r[7],
            operator=r[8],
            co2_savings_kg=r[9],
            savings_percent=r[10]
        )
        for r in rows
    ]

    logger.info(f"GET /trajets — {len(trajets)} returned (total: {total})")
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
        text("SELECT * FROM fact_routes WHERE route_id = :id"),
        {"id": route_id}
    ).fetchone()

    if not row:
        logger.warning(f"Route {route_id} not found")
        raise HTTPException(status_code=404, detail=f"Trajet {route_id} introuvable")

    return TrajetBase(
        route_id=row[0],
        route_name=row[1],
        route_name_simple=row[2],
        origin=row[3],
        destination=row[4],
        origin_country=row[5],
        destination_country=row[6],
        distance_km=row[7],
        service_type=row[8],
        train_type=row[9],
        operator=row[10],
        train_gco2_pkm=row[11],
        plane_gco2_pkm=row[12],
        train_co2_kg=row[13],
        plane_co2_kg=row[14],
        co2_savings_kg=row[15],
        savings_percent=row[16],
        emission_source=row[17],
        calculation_date=row[18]
    )