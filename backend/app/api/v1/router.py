"""
API Router
==========
Registers all v1 endpoints under /api/v1
"""

from fastapi import APIRouter
from app.api.v1.endpoints import trajets, stats, health

router = APIRouter()

router.include_router(trajets.router, tags=["Trajets"])
router.include_router(stats.router,   tags=["Statistiques"])
router.include_router(health.router,  tags=["Monitoring"])