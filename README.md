#  ObRail Europe — MSPR3 (Mise en production & supervision)

Application web d'analyse des trajets ferroviaires européens, **conteneurisée et
supervisée**, intégrant le **modèle d'IA** de détection des lignes sous-desservies
développé au Bloc E6.2.

Tout l'environnement (base de données, API, modèle IA, frontend, monitoring) se
lance avec **une seule commande** : `docker compose up`.

---

##  Architecture

| Service | Rôle | Port (hôte) | Image / Build |
|---|---|---|---|
| **db** | Base PostgreSQL (données ferroviaires) | `5434` | `postgres:15` |
| **backend** | API REST FastAPI + `/metrics` Prometheus | `8002` | `./backend` |
| **model-api** | API IA — modèle de prédiction (Bloc E6.2) | `8003` | `./model-api` |
| **frontend** | Interface React/Vite (servie par Nginx) | `3001` | `./frontend` |
| **prometheus** | Collecte des métriques (backend + modèle IA) | `9090` | `prom/prometheus` |
| **grafana** | Tableaux de bord (métriques **et** logs) | `3000` | `grafana/grafana` |
| **loki** | Stockage/indexation des logs | `3100` | `grafana/loki` |
| **promtail** | Envoie les logs du backend vers Loki | — | `grafana/promtail` |

> Les ports hôte sont **volontairement décalés** (8002, 8003, 3001, 5434, 3000)
> pour éviter les conflits avec les autres briques de la MSPR (ETL, modèle ML, app
> web) qui tournent en parallèle.

Les services démarrent dans le bon ordre (la base devient *healthy* avant le
backend), communiquent via le réseau Docker nommé **\`obrail-net\`**, et les données
sont persistées par des volumes Docker (\`postgres_data\`, \`grafana_data\`).

---

##  Solution IA déployée et supervisée

Le modèle de prédiction des lignes sous-desservies (LightGBM, développé au
**Bloc E6.2**) est ici **mis en production** sous forme d'un service conteneurisé
\`model-api\` :

- **Déployé** : endpoint \`POST /predict\` exposé sur le port \`8003\`, démarré avec
  la stack.
- **Supervisé** : endpoint \`/metrics\` scrapé par Prometheus et visualisé dans
  Grafana, au même titre que le backend.

Voir [\`model-api/README.md\`](model-api/README.md) pour le détail de l'API et des
exemples d'appel.

> L'harmonisation complète des schémas de données entre les Blocs E6.2 et E6.3,
> permettant d'alimenter le modèle directement depuis la base ObRail, constitue
> l'étape d'intégration applicative suivante.

---

##  Prérequis

- [Docker](https://docs.docker.com/get-docker/) **≥ 20.10**
- [Docker Compose](https://docs.docker.com/compose/) **v2** (intégré à Docker Desktop)

C'est tout : aucune installation de Python ou Node n'est nécessaire pour **lancer**
le projet (tout est conteneurisé).

---

##  Installation depuis zéro (machine vierge)

\`\`\`bash
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
\`\`\`

Au **premier démarrage**, la base est automatiquement initialisée avec le schéma
et les données (\`database/init/\`).

### Arrêter / réinitialiser

\`\`\`bash
docker compose down        # arrête les services (conserve les données)
docker compose down -v     # arrête ET supprime les volumes (remise à zéro complète)
\`\`\`

---

##  Points d'accès

| Interface | URL |
|---|---|
| Frontend | http://localhost:3001 |
| API backend (Swagger) | http://localhost:8002/api/v1/docs |
| Health check backend | http://localhost:8002/api/v1/health |
| API IA — prédiction (Swagger) | http://localhost:8003/docs |
| Grafana | http://localhost:3000 |
| Prometheus | http://localhost:9090 |

Identifiants Grafana : ceux définis dans \`.env\` (\`GRAFANA_USER\` / \`GRAFANA_PASSWORD\`).

---

##  Spécification OpenAPI

La spécification complète de l'API backend est disponible sous forme statique dans
\`docs/api/openapi.json\`. Elle est générée automatiquement par FastAPI.

Pour la régénérer après une modification de l'API (**le backend doit être
démarré**) :

\`\`\`bash
curl -s http://localhost:8002/api/v1/openapi.json > docs/api/openapi.json
\`\`\`

La spécification du service IA est, elle, disponible sur \`http://localhost:8003/openapi.json\`.

---

##  Monitoring & logs

- **Métriques** : le backend **et** le service IA exposent \`/metrics\`, scrapés par
  Prometheus (jobs \`obrail-api\` et \`model-api\`), visualisés dans Grafana (latence,
  taux d'erreurs, disponibilité). Cibles vérifiables sur
  \`http://localhost:9090/targets\`.
- **Logs** : le backend produit des **logs JSON structurés**, collectés par
  Promtail et envoyés à Loki.
  Dans Grafana → **Explore** → source de données **Loki** → requête :
  \`\`\`
  {job="obrail-backend"}
  \`\`\`

---

##  Tests

Le backend dispose d'un plan de tests structuré (voir \`backend/tests/README.md\`) :

- **Tests fonctionnels** (intégration des endpoints REST)
- **Tests structurels** (logique métier, unitaires)
- **Tests de sécurité** (injection SQL, validation des entrées)
- **Tests de charge** (Locust)

Le frontend est couvert par des **tests end-to-end Playwright**. L'ensemble est
exécuté automatiquement à chaque push via la CI, assurant la **non-régression**.

---

##  Accessibilité

L'interface est conçue selon le **RGAA / WCAG 2.1 (niveau AA) / EN 301 549**.
Scores Lighthouse mesurés : **91/100** (trajets), **95/100** (statistiques).
Détail dans [\`docs/accessibilite.md\`](docs/accessibilite.md).

---

##  Intégration continue (CI/CD)

À chaque push / pull request (\`.github/workflows/ci.yml\`), le pipeline exécute :

1. **Tests backend** (Pytest, sur une base PostgreSQL éphémère)
2. **Tests frontend** (lint, vérification des types, build)
3. **Tests E2E Playwright** (parcours frontend ↔ backend)
4. **Build** des images Docker
5. **Déploiement simulé** : \`docker compose up\` + vérification que la stack démarre et répond
6. **Rapport** de succès/échec (résumé dans GitHub)

Un workflow \`deploy.yml\` réalise un **déploiement simulé** lors d'un push sur
\`main\`.

---

##  Variables d'environnement

Toutes les variables sont décrites dans [\`.env.example\`](.env.example) :
identifiants PostgreSQL, \`API_KEY\`, \`SECRET_KEY\`, identifiants Grafana.
**Le fichier \`.env\` n'est jamais commité.**

---

##  Structure du projet

\`\`\`
OBRail-MSPR3/
├── backend/            # API FastAPI + tests + Dockerfile
├── model-api/          # Service IA — modèle de prédiction (Bloc E6.2)
├── frontend/           # App React/Vite + Dockerfile + nginx.conf
├── database/init/      # Scripts SQL d'initialisation
├── monitoring/
│   ├── prometheus/     # Config de scraping (backend + model-api)
│   ├── promtail/       # Collecte des logs -> Loki
│   └── grafana/        # Datasources + dashboards provisionnés
├── docs/               # Documentation : openapi.json, accessibilité, architecture, rapport
├── .github/workflows/  # Pipelines CI/CD (ci.yml, deploy.yml)
├── docker-compose.yml  # Orchestration de tous les services
└── .env.example        # Modèle de configuration
\`\`\`