import { GRAFANA_URL } from '../../api/health'

interface Props {
  isOnline: boolean
  isLoading: boolean
  status: string | null
  lastChecked: string | null
  onRefresh: () => void
}

function parseHealthStatus(raw: string | null): Record<string, string> | null {
  if (!raw) return null
  try {
    const p = JSON.parse(raw)
    return {
      'API':        p.status ?? '—',
      'Base de données': p.database ?? '—',
      'Version':    p.version ?? '—',
      'Uptime':     p.uptime_seconds != null ? `${Math.floor(p.uptime_seconds / 60)} min` : '—',
      'Routes':     p.data?.total_routes?.toString() ?? '—',
      'Nuit':       p.data?.night_routes?.toString() ?? '—',
      'Jour':       p.data?.day_routes?.toString() ?? '—',
    }
  } catch {
    return { 'Réponse': raw }
  }
}

export default function HealthStatus({ isOnline, isLoading, status, lastChecked, onRefresh }: Props) {
  const stateClass = isLoading ? 'checking' : isOnline ? 'online' : 'offline'
  const details = parseHealthStatus(status)

  return (
    <>
      {/* Indicateur principal */}
      <section id="status-section" aria-labelledby="status-label">
        <div
          className={`status-indicator ${stateClass}`}
          id="status-indicator"
          aria-live="polite"
        >
          <span className="status-dot" id="status-dot" aria-hidden="true" />
          <div style={{ flex: 1 }}>
            <p className="status-label" id="status-label">
              {isLoading
                ? '⏳ Vérification en cours…'
                : isOnline
                ? '🟢 Tous les systèmes opérationnels'
                : '🔴 Service indisponible'}
            </p>
            <p className="status-sublabel">
              {isOnline
                ? 'API, base de données et monitoring actifs'
                : 'Impossible de joindre le backend'}
            </p>
          </div>
          <button
            id="refresh-btn"
            className="btn-primary"
            onClick={onRefresh}
            aria-label="Actualiser le statut du service"
          >
            🔄 Actualiser
          </button>
        </div>

        {lastChecked && (
          <p className="last-checked" id="last-checked">
            Dernière vérification : {lastChecked}
          </p>
        )}
      </section>

      {/* Métriques détaillées */}
      {details && (
        <section id="status-details-section" aria-labelledby="status-details-title">
          <div className="status-details" id="status-details">
            <p className="status-details-title" id="status-details-title">
              Métriques du service
            </p>
            <div className="status-details-grid">
              {Object.entries(details).map(([label, value]) => (
                <div className="status-detail-item" key={label}>
                  <span className="status-detail-label">{label}</span>
                  <span className={`status-detail-value ${
                    value === 'healthy' || value === 'connected' ? 'green' : ''
                  }`} id={`detail-${label.toLowerCase().replace(/\s/g, '-')}`}>
                    {value}
                  </span>
                </div>
              ))}
            </div>
          </div>
        </section>
      )}

      {/* Card Grafana */}
      <section id="grafana-section" aria-labelledby="grafana-title">
        <div className="grafana-card">
          <p className="grafana-card-title" id="grafana-title">
            Monitoring avancé
          </p>
          <p className="grafana-card-desc">
            Visualisation temps réel des performances système — latence, taux d'erreurs,
            disponibilité de l'API et métriques Prometheus.
          </p>
          <a
            href={GRAFANA_URL}
            target="_blank"
            rel="noopener noreferrer"
            className="btn-grafana"
            id="grafana-link"
            aria-label="Ouvrir le dashboard Grafana dans un nouvel onglet"
          >
            📊 Ouvrir Grafana
            <span className="sr-only">(s'ouvre dans un nouvel onglet)</span>
          </a>
        </div>
      </section>
    </>
  )
}