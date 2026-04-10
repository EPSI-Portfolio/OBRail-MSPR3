import { GRAFANA_URL } from '../../api/health'

interface Props {
  isOnline: boolean
  isLoading: boolean
  status: string | null
  lastChecked: string | null
  onRefresh: () => void
}

export default function HealthStatus({ isOnline, isLoading, status, lastChecked, onRefresh }: Props) {
  const stateClass = isLoading ? 'checking' : isOnline ? 'online' : 'offline'
  const stateLabel = isLoading
    ? 'Vérification en cours…'
    : isOnline
    ? '✅ Service en ligne'
    : '❌ Service hors ligne'

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
          <span className="status-label" id="status-label">{stateLabel}</span>
        </div>

        {lastChecked && (
          <p className="last-checked" id="last-checked">
            Dernière vérification : {lastChecked}
          </p>
        )}

        {status && (
          <div className="status-details" id="status-details">
            <p>
              <strong>Réponse API : </strong>
              <span id="api-response">{status}</span>
            </p>
          </div>
        )}

        <button
          id="refresh-btn"
          className="btn-primary"
          onClick={onRefresh}
          aria-label="Actualiser le statut du service"
        >
          🔄 Actualiser
        </button>
      </section>

      <section aria-labelledby="grafana-title" id="grafana-section">
        <h2 id="grafana-title">Monitoring Grafana</h2>
        <p>Accédez au tableau de bord pour visualiser les métriques en temps réel.</p>
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