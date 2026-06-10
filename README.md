# 🚆 ObRail Europe — MSPR3 (DevOps / Intégration)

Application web d'analyse des trajets ferroviaires européens, conteneurisée et supervisée.
Tout l'environnement (base de données, API, frontend, monitoring) se lance avec **une seule commande** : `docker compose up`.

---

## 🏗️ Architecture

| Service | Rôle | Port (hôte) | Image / Build |
|---|---|---|---|
| **db** | Base PostgreSQL (données ferroviaires) | `5434` | `postgres:15` |
| **backend** | API REST FastAPI + `/metrics` Prometheus | `8002` | `./backend` |
| **frontend** | Interface React/Vite (servie par Nginx) | `3001` | `./frontend` |
| **prometheus** | Collecte des métriques de l'API | `9090` | `prom/prometheus` |
| **grafana** | Tableaux de bord (métriques **et** logs) | `3000` | `grafana/grafana` |
| **loki** | Stockage/indexation des logs | `3100` | `grafana/loki` |
| **promtail** | Envoie les logs du backend vers Loki | — | `grafana/promtail` |

> Les ports hôte sont **volontairement décalés** (8002, 3001, 5434, 3000) pour éviter les conflits avec les autres briques de la MSPR (ETL, modèle ML, app web) qui tournent en parallèle.

Les services démarrent dans le bon ordre (la base devient *healthy* avant le backend), communiquent via le réseau Docker nommé **`obrail-net`**, et les données sont persistées par des volumes Docker (`postgres_data`, `grafana_data`).

---

## ✅ Prérequis

- [Docker](https://docs.docker.com/get-docker/) **≥ 20.10**
- [Docker Compose](https://docs.docker.com/compose/) **v2** (intégré à Docker Desktop)

C'est tout : aucune installation de Python ou Node n'est nécessaire pour **lancer** le projet (tout est conteneurisé).

---

## 🚀 Installation depuis zéro (machine vierge)

```bash
# 1. Cloner le dépôt
git clone https://github.com/EPSI-Portfolio/OBRail-MSPR3.git
cd OBRail-MSPR3

# 2. Créer le fichier d'environnement à partir de l'exemple
cp .env.example .env
#    puis ouvrir .env et renseigner les mots de passe (DB, Grafana...)

# 3. Lancer toute la stack
docker compose up -d --build

# 4. Vérifier que tout tourne
docker compose ps
```

Au **premier démarrage**, la base est automatiquement initialisée avec le schéma et les données (`database/init/`).

### Arrêter / réinitialiser

```bash
docker compose down        # arrête les services (conserve les données)
docker compose down -v     # arrête ET supprime les volumes (remise à zéro complète)
```

---

## 🌐 Points d'accès

| Interface | URL |
|---|---|
| Frontend | http://localhost:3001 |
| API (Swagger) | http://localhost:8002/api/v1/docs |
| Health check API | http://localhost:8002/api/v1/health |
| Grafana | http://localhost:3000 |
| Prometheus | http://localhost:9090 |

Identifiants Grafana : ceux définis dans `.env` (`GRAFANA_USER` / `GRAFANA_PASSWORD`).

---

## 📊 Monitoring & logs

- **Métriques** : le backend expose `/metrics`, scrapé par Prometheus, visualisé dans Grafana (latence, taux d'erreurs, disponibilité).
- **Logs** : le backend produit des **logs JSON structurés**, collectés par Promtail et envoyés à Loki.
  Dans Grafana → **Explore** → source de données **Loki** → requête :
  ```
  {job="obrail-backend"}
  ```

---

## 🔄 Intégration continue (CI/CD)

À chaque push / pull request (`.github/workflows/ci.yml`), le pipeline exécute :

1. **Installation** des dépendances (backend + frontend)
2. **Tests Pytest** (backend, sur une base PostgreSQL éphémère)
3. **Tests E2E Playwright** (parcours frontend ↔ backend)
4. **Build** des images Docker
5. **Déploiement simulé** : `docker compose up` + vérification que la stack démarre et répond
6. **Rapport** de succès/échec (résumé dans GitHub)

---

## 🔐 Variables d'environnement

Toutes les variables sont décrites dans [`.env.example`](.env.example) : identifiants PostgreSQL, `API_KEY`, `SECRET_KEY`, identifiants Grafana. **Le fichier `.env` n'est jamais commité.**

---

## 🗂️ Structure du projet

```
OBRail-MSPR3/
├── backend/            # API FastAPI + Dockerfile
├── frontend/           # App React/Vite + Dockerfile
├── database/init/      # Scripts SQL d'initialisation
├── monitoring/
│   ├── prometheus/     # Config de scraping
│   ├── promtail/       # Collecte des logs -> Loki
│   └── grafana/        # Datasources + dashboards provisionnés
├── .github/workflows/  # Pipeline CI/CD
├── docker-compose.yml  # Orchestration de tous les services
└── .env.example        # Modèle de configuration
```
