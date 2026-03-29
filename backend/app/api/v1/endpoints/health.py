"""
Health Endpoint
===============
Verifies the API and database are running correctly.
Required by MSPR 3 for monitoring integration.
"""

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
from app.api.deps import get_db
import logging

router = APIRouter()
logger = logging.getLogger("obrail")


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

        logger.info("Health check passed")
        return {
            "status": "healthy",
            "database": "connected",
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
            "database": "disconnected",
            "error": str(e)
        }