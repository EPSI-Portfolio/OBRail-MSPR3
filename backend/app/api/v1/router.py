"""
API Router
==========
Registers all v1 endpoints under /api/v1.
All routes are protected by optional API key authentication.
If API_KEY is set in .env, requests must include the X-API-Key header.
If API_KEY is empty (default), all requests are allowed — safe for development.
"""

from fastapi import APIRouter, Depends
from app.api.v1.endpoints import trajets, stats, health
from app.core.security import verify_api_key

router = APIRouter(dependencies=[Depends(verify_api_key)])

router.include_router(trajets.router, tags=["Trajets"])
router.include_router(stats.router,   tags=["Statistiques"])
router.include_router(health.router,  tags=["Monitoring"])