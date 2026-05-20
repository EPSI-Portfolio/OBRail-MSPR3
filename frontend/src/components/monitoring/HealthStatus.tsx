import { GRAFANA_URL } from '../../api/health'

interface Props {
  isOnline: boolean
  isLoading: boolean
  status: string | null
  lastChecked: string | null
  onRefresh: () => void
}

// Parse la réponse health en objet lisible
function parseHealthStatus(raw: string | null): Record<string, string> | null {
  if (!raw) return null
  try {
    const parsed = JSON.parse(raw)
    return {
      'Statut API': parsed.status ?? '—',
      'Base de données': parsed.database ?? '—',
      'Version': parsed.version ?? '—',
      'Uptime': parsed.uptime_seconds != null
        ? `${Math.floor(parsed.uptime_seconds / 60)} min`
        : '—',
      'Routes totales': parsed.data?.total_routes ?? '—',
      'Trains de nuit': parsed.data?.night_routes ?? '—',
      'Trains de jour': parsed.data?.day_routes ?? '—',
    }
  } catch {
    return { 'Réponse': raw }
  }
}

export default function HealthStatus({ isOnline, isLoading, status, lastChecked, onRefresh }: Props) {
  const stateClass = isLoading ? 'checking' : isOnline ? 'online' : 'offline'
  const stateLabel = isLoading
    ? 'Vérification en cours…'
    : isOnline ? '✅ Service en ligne' : '❌ Service hors ligne'

  const details = parseHealthStatus(status)

  return (
    <>
      <section aria-labelledby="status-indicator-title" id="status-section">
        <h2 id="status-indicator-title" className="sr-only">Statut de l'API</h2>

        <div
          className={`status-indicator ${stateClass}`}
          id="status-indicator"
          aria-live="polite"
          aria-label={stateLabel}
        >
          <span className="status-dot" id="status-dot" aria-hidden="true" />
          <div>
            <span className="status-label" id="status-label">{stateLabel}</span>
            {lastChecked && (
              <p className="last-checked" id="last-checked" style={{ marginBottom: 0, marginTop: '0.15rem' }}>
                Dernière vérification : {lastChecked}
              </p>
            )}
          </div>
          <button
            id="refresh-btn"
            className="btn-primary"
            onClick={onRefresh}
            aria-label="Actualiser le statut"
            style={{ marginLeft: 'auto' }}
          >
            🔄 Actualiser
          </button>
        </div>

        {/* Détails structurés */}
        {details && (
          <div className="status-details" id="status-details">
            <p className="status-details-title">Détails du service</p>
            <div className="status-details-grid">
              {Object.entries(details).map(([label, value]) => (
                <div className="status-detail-item" key={label}>
                  <span className="status-detail-label">{label}</span>
                  <span className={`status-detail-value ${
                    value === 'healthy' || value === 'connected' ? 'green' : ''
                  }`}>
                    {value}
                  </span>
                </div>
              ))}
            </div>
          </div>
        )}
      </section>

      <section aria-labelledby="grafana-title" id="grafana-section">
        <h2 id="grafana-title">Monitoring Grafana</h2>
        <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem' }}>
          Accédez au tableau de bord pour visualiser les métriques en temps réel.
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
      </section>
    </>
  )
}