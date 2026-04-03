"""
Health Endpoint
===============
Verifies the API and database are running correctly.
Used by Grafana monitoring and the frontend status page.

GET /health   - returns API status, database connectivity and route counts
"""

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
from app.api.deps import get_db
from app.core.config import settings
import logging
import time

router = APIRouter()
logger = logging.getLogger("obrail")

START_TIME = time.time()


@router.get(
    "/health",
    summary="Health check",
    description="Returns API and database status. Used by monitoring tools."
)
async def health_check(db: Session = Depends(get_db)):
    try:
        result = db.execute(text("""
            SELECT
                COUNT(*) as total_routes,
                COUNT(*) FILTER (WHERE service_type = 'night') as night_routes,
                COUNT(*) FILTER (WHERE service_type = 'day') as day_routes
            FROM fact_routes
        """)).fetchone()

        uptime_seconds = round(time.time() - START_TIME)
        logger.info("Health check passed")

        return {
            "status": "healthy",
            "api": settings.APP_NAME,
            "version": settings.APP_VERSION,
            "database": "connected",
            "uptime_seconds": uptime_seconds,
            "data": {
                "total_routes": result[0],
                "night_routes": result[1],
                "day_routes":   result[2],
            }
        }

    except Exception as e:
        logger.error(f"Health check failed: {e}")
        return {
            "status": "unhealthy",
            "api": settings.APP_NAME,
            "version": settings.APP_VERSION,
            "database": "disconnected",
            "error": str(e)
        }