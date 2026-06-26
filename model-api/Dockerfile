# =============================================================================
# Dockerfile — API de prédiction du modèle IA (ObRail MSPR 2)
#
# Conteneurise le service /predict qui expose le modèle LightGBM entraîné.
# Copie uniquement ce dont l'inférence a besoin : api/, src/, models/, et le
# scaler. Les dépendances de développement (jupyter, shap, plotly...) sont
# exclues via requirements-api.txt.
# =============================================================================

FROM python:3.12-slim

WORKDIR /app

# Dépendances système minimales pour LightGBM
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Dépendances Python (couche cache séparée)
COPY requirements-api.txt .
RUN pip install --no-cache-dir -r requirements-api.txt

# Code et artefacts nécessaires à l'inférence
COPY api/ ./api/
COPY src/ ./src/
COPY models/ ./models/
COPY data/processed/scaler.joblib ./data/processed/scaler.joblib

EXPOSE 8000

CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]