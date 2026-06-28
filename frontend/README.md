# ObRail Europe — Frontend

Application web monopage (SPA) de comparaison des liaisons ferroviaires
européennes et de visualisation de leurs économies de CO₂ par rapport à l'avion,
en mettant en avant la complémentarité des trains de jour et de nuit. Elle
consomme l'API FastAPI d'ObRail et présente les données à travers des tableaux de
bord et des graphiques interactifs.

---

## Stack technique

- **React 19** + **TypeScript**
- **Vite 8** (serveur de développement + build)
- **Tailwind CSS 4** (plugin `@tailwindcss/vite`)
- **React Router 7** (navigation entre les pages)
- **Recharts 3** (graphiques : camembert, radar, barres)
- **Axios** (appels HTTP vers l'API)
- **Playwright** (tests end-to-end)

---

## Prérequis

- Node.js 20+
- npm

---

## Démarrage

```bash
# depuis le dossier frontend/
npm install        # installe les dépendances
npm run dev        # démarre le serveur de dev (http://localhost:5173)
```

En développement, les appels à l'API sont automatiquement redirigés vers le
backend par le proxy de Vite (voir **Configuration de l'API**). Pour lancer
l'ensemble de la stack, utiliser `docker compose up -d` à la racine du projet.

---

## Scripts disponibles

| Script | Description |
|---|---|
| `npm run dev` | Serveur Vite avec rechargement à chaud |
| `npm run build` | Vérification des types (`tsc -b`) puis build de production |
| `npm run preview` | Sert le build de production en local |
| `npm run lint` | Analyse du code avec ESLint |
| `npx playwright test` | Lance la suite de tests end-to-end |

---

## Configuration de l'API

Les appels HTTP utilisent le chemin relatif `/api`. En développement, **Vite agit
comme proxy** et redirige ces requêtes vers le backend — configuré dans
`vite.config.ts` :

```ts
server: {
  host: '0.0.0.0',
  port: 5173,
  proxy: {
    '/api': {
      target: 'http://localhost:8002',
      changeOrigin: true,
    },
  },
}
```

Il n'y a donc **aucune variable d'environnement à définir en local** : le proxy
cible directement le backend sur le port `8002`. En production (image Docker), la
redirection du chemin `/api` est assurée par le reverse proxy du conteneur.

---

## Structure du projet

```
src/
├── api/
│   └── trajets.ts          # Appels à l'API backend (liaisons / trajets, via axios)
├── components/
│   ├── common/
│   │   ├── LoadingSpinner.tsx
│   │   └── ErrorMessage.tsx
│   └── stats/
│       ├── StatsCard.tsx   # Carte d'indicateur (KPI)
│       └── VolumeChart.tsx # Graphique du volume par pays
├── hooks/
│   └── useStats.ts         # Récupère et dérive les données statistiques
├── pages/
│   └── StatsPage.tsx       # Tableau de bord statistiques (à onglets)
├── types/
│   └── trajet.ts           # Types TypeScript partagés
└── utils/
    └── formatters.ts       # Helpers de formatage (distance / durée)
```

La navigation entre les pages est gérée par **React Router**.

---

## Fonctionnalités

### Tableau de bord statistiques (`StatsPage`)

Un tableau de bord à quatre onglets, chacun monté uniquement lorsque son onglet
est actif :

- **Couverture** — volume de trajets par pays (graphique en barres) et cartes de
  détail jour/nuit.
- **Top Trajets** — les liaisons de jour et de nuit les plus longues, en tableaux.
- **Émissions CO₂** — émissions par passager selon le mode de transport (camembert)
  et CO₂ économisé par pays, avec une synthèse de l'impact environnemental global.
- **Performance** — un radar multi-critères comparant trains de jour et de nuit.

Les indicateurs clés (trains de jour, trains de nuit, total des trajets, pays
desservis) sont affichés au-dessus des onglets, et une section de conclusion
récapitule les chiffres principaux.

### Accessibilité

La page s'appuie sur des repères sémantiques et des attributs ARIA : une région
principale `#main-content`, un système d'onglets `role="tablist"` / `role="tab"` /
`role="tabpanel"` avec `aria-selected` et `aria-controls`, des sections étiquetées,
et des icônes décoratives marquées `aria-hidden`.

---

## Tests

Les tests end-to-end sont écrits avec **Playwright**. Comme les graphiques se
trouvent dans des onglets montés à la demande, les tests cliquent sur l'onglet
concerné avant de vérifier son contenu (graphiques, KPI, etc., qui exposent des
identifiants `id` / `data-testid` stables).

```bash
npx playwright install --with-deps   # uniquement au premier lancement
npx playwright test                  # lance la suite
npx playwright test --ui             # mode interactif
```

Ces tests sont également exécutés automatiquement en CI (job `test-e2e`).

---

## Exécution avec Docker

Le frontend fait partie de la stack Docker Compose du projet. Depuis la racine du
dépôt :

```bash
docker compose up -d
```

Cette commande démarre le frontend aux côtés du backend, de la base de données et
de la stack de supervision. Voir le `README.md` à la racine et
`monitoring/README.md` pour la configuration complète.