"""
main.py
Rôle : Point d'entrée de l'API FastAPI (modèle de prédiction ObRail)
"""

from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator
from api.routes import predict, health

# CRÉATION DE L'APPLICATION
app = FastAPI(
    title="ObRail API",
    description="API de détection des lignes sous-desservies",
    version="1.0",
)

# AJOUT DES ROUTES
app.include_router(predict.router)
app.include_router(health.router)

# SUPERVISION — expose /metrics pour Prometheus
Instrumentator().instrument(app).expose(app)