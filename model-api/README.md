# Service IA — `model-api`

Ce service expose en production le **modèle de prédiction des lignes
ferroviaires sous-desservies**, développé au Bloc E6.2 (MSPR 2). Il constitue la
mise en production et la supervision de la solution d'intelligence artificielle
au sein de la stack ObRail industrialisée (Bloc E6.3).

Le modèle (LightGBM) prédit, pour une liaison ferroviaire donnée, si elle est
**sous-desservie** ou non, et renvoie une probabilité.

---

## Rôle dans l'architecture

`model-api` est un service conteneurisé indépendant, déployé aux côtés des autres
services ObRail sur le réseau Docker `obrail-net`. Il est :

- **Déployé** : démarré automatiquement avec `docker compose up`, il expose
  l'endpoint `/predict` sur le port hôte **8003**.
- **Supervisé** : il expose un endpoint `/metrics` scrapé par Prometheus
  (job `model-api`) et visualisable dans Grafana — au même titre que le backend.

> Le modèle a été entraîné sur le jeu de données du Bloc E6.2. L'harmonisation
> complète des schémas de données entre les deux blocs, permettant d'alimenter le
> modèle directement depuis la base ObRail, constitue l'étape d'intégration
> applicative suivante.

---

## Endpoints

| Endpoint | Méthode | Description |
|---|---|---|
| `/predict` | POST | Prédit si une liaison est sous-desservie |
| `/health` | GET | Vérifie que le service répond |
| `/metrics` | GET | Métriques Prometheus (supervision) |
| `/docs` | GET | Documentation interactive Swagger |

---

## Exemple d'appel

### Requête

```bash
curl -X POST http://localhost:8003/predict \
  -H "Content-Type: application/json" \
  -d '{
        "departure_country": "FR",
        "service_type": "night",
        "distance_km": 450.0,
        "co2_per_pkm": 28.3,
        "arrival_country": "DE"
      }'
```

### Réponse

```json
{
  "is_underserved": 1,
  "probability": 0.9984,
  "label": "sous-desservie",
  "inputs": {
    "departure_country": "FR",
    "arrival_country": "DE",
    "service_type": "night",
    "distance_km": 450.0,
    "co2_per_pkm": 28.3,
    "is_international": 1
  }
}
```

### Paramètres d'entrée

| Champ | Type | Obligatoire | Exemple |
|---|---|---|---|
| `departure_country` | string | Oui | `"FR"` |
| `service_type` | string | Oui | `"day"` / `"night"` |
| `distance_km` | float | Oui | `450.0` |
| `co2_per_pkm` | float | Oui | `28.3` |
| `arrival_country` | string | Non | `"DE"` |

---

## Structure du service

```
model-api/
├── Dockerfile             # Image du service (Python 3.12-slim)
├── requirements-api.txt   # Dépendances d'exécution (slim, sans outils de dev)
├── api/
│   ├── main.py            # Point d'entrée FastAPI + instrumentation Prometheus
│   ├── schemas.py         # Modèles Pydantic (entrée / sortie)
│   └── routes/
│       ├── predict.py     # Endpoint /predict
│       └── health.py      # Endpoint /health
├── src/
│   └── predict.py         # Pipeline d'inférence (chargement modèle + features)
├── models/
│   ├── best_model_optimized.joblib   # Modèle LightGBM retenu
│   └── model_metadata.json           # Métadonnées du modèle
└── data/processed/
    └── scaler.joblib      # Normalisation (StandardScaler) du training
```

---

## Supervision

Le service est scrapé par Prometheus (`monitoring/prometheus/prometheus.yml`,
job `model-api`, cible `model-api:8000`). Les métriques exposées permettent de
suivre, en production :

- le nombre de requêtes de prédiction,
- la latence de l'endpoint `/predict`,
- le taux d'erreurs.

Ces métriques sont visualisables dans Grafana, complétant la supervision de la
solution IA dans une démarche d'amélioration continue.

---

## Construction et lancement

Le service démarre avec l'ensemble de la stack :

```bash
docker compose up -d --build
```

Ou seul :

```bash
docker compose up -d --build model-api
```

Vérification rapide :

```bash
docker compose logs model-api | tail -n 20      # uvicorn doit être en écoute
curl -s http://localhost:8003/metrics | head     # métriques Prometheus
```