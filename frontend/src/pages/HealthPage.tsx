import { useHealth } from '../hooks/useHealth'
import HealthStatus from '../components/monitoring/HealthStatus'

export default function HealthPage() {
  const { isOnline, isLoading, status, lastChecked, refetch } = useHealth()

  return (
    <main id="main-content" className="page-container fade-in">
      <div className="page-header">
        <h1 className="page-title">État du Service</h1>
        <p className="page-subtitle">
          Supervision en temps réel de l'API, de la base de données et des services de monitoring.
          Rafraîchissement automatique toutes les 30 secondes.
        </p>
      </div>

      <HealthStatus
        isOnline={isOnline}
        isLoading={isLoading}
        status={status}
        lastChecked={lastChecked}
        onRefresh={refetch}
      />
    </main>
  )
}