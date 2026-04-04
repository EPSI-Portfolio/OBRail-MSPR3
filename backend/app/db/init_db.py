"""
Database Initialisation
=======================
Verifies database connection and tables exist on startup.
"""

from sqlalchemy import text
from app.db.session import engine
import logging

logger = logging.getLogger("obrail")


def check_database():
    """Check database is reachable and fact_routes table exists."""
    try:
        with engine.connect() as conn:
            conn.execute(text("SELECT 1"))
            result = conn.execute(text(
                "SELECT COUNT(*) FROM fact_routes"
            ))
            count = result.fetchone()[0]
            logger.info(f"Database ready — {count} routes in fact_routes")
    except Exception as e:
        logger.error(f"Database check failed: {e}")
        raise