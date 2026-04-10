import { useHealth } from '../hooks/useHealth'
import HealthStatus from '../components/monitoring/HealthStatus'

export default function HealthPage() {
  const { isOnline, isLoading, status, lastChecked, refetch } = useHealth()

  return (
    <main id="main-content" className="page-container">
      <h1 id="page-title-health">État du Service</h1>

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