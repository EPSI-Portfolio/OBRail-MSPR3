// URL de base de l'API — injectée via variable d'environnement Vite
export const API_BASE_URL =
  import.meta.env.VITE_API_URL || 'http://localhost:8002/api/v1'

// URL du dashboard Grafana
export const GRAFANA_URL =
  import.meta.env.VITE_GRAFANA_URL || 'http://localhost:3000'

// Pagination
export const DEFAULT_PAGE_LIMIT = 20

// Intervalle de polling pour le health check (ms)
export const HEALTH_POLL_INTERVAL = 30_000

// Liste des opérateurs connus
export const OPERATORS = ['SNCF', 'DB', 'ÖBB', 'Trenitalia', 'Renfe', 'SBB']

// Couleurs pour les graphiques (jour / nuit)
export const CHART_COLORS = {
  day: '#f59e0b',
  night: '#6366f1',
}

// Couleurs pour les statuts de service
export const STATUS_COLORS = {
  online: '#16a34a',
  offline: '#dc2626',
  checking: '#64748b',
}