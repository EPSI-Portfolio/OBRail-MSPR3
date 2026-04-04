"""
ObRail Europe API
=================
Main FastAPI application entry point.

Endpoints:
    GET /api/v1/trajets           - list routes with filters
    GET /api/v1/trajets/{id}      - single route detail
    GET /api/v1/stats/volumes     - day/night volumes by country
    GET /api/v1/stats/co2         - CO2 savings statistics
    GET /api/v1/health            - health check for monitoring
    GET /api/v1/docs              - auto-generated Swagger UI (development only)
"""

from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from prometheus_fastapi_instrumentator import Instrumentator
from app.api.v1.router import router
from app.core.config import settings
from app.core.logging import setup_logging, logger
from app.db.init_db import check_database

setup_logging()


@asynccontextmanager
async def lifespan(app: FastAPI):
    check_database()
    logger.info("ObRail Europe API started")
    logger.info(f"Environment: {settings.ENVIRONMENT}")
    logger.info(f"Docs available at: {settings.API_PREFIX}/docs")
    yield
    logger.info("ObRail Europe API stopped")


app = FastAPI(
    lifespan=lifespan,
    title=settings.APP_NAME,
    description=(
        "REST API exposing European train route data with CO2 impact analysis. "
        "Built for ObRail Europe as part of MSPR 3 — Bloc E6.3."
    ),
    version=settings.APP_VERSION,
    # Docs are disabled in production so the API structure is not publicly visible.
    docs_url="/api/v1/docs" if not settings.is_production else None,
    redoc_url="/api/v1/redoc" if not settings.is_production else None,
    openapi_url="/api/v1/openapi.json" if not settings.is_production else None,
)

# Prometheus metrics — exposes /metrics endpoint for Grafana.
Instrumentator().instrument(app).expose(app)

# CORS — origins controlled by environment, see config.py.
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Register all routes under /api/v1.
app.include_router(router, prefix=settings.API_PREFIX)