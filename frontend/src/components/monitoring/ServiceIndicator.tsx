import { useHealth } from '../../hooks/useHealth'
import { STATUS_COLORS } from '../../utils/constants'

export default function ServiceIndicator() {
  const { isOnline, isLoading } = useHealth()

  const color = isLoading
    ? STATUS_COLORS.checking
    : isOnline
    ? STATUS_COLORS.online
    : STATUS_COLORS.offline

  const label = isLoading
    ? 'Vérification du service...'
    : isOnline
    ? 'Service en ligne'
    : 'Service hors ligne'

  return (
    <div
      className="service-indicator"
      id="service-indicator-navbar"
      aria-label={label}
      title={label}
    >
      <span
        className="service-dot"
        style={{ backgroundColor: color }}
        aria-hidden="true"
      />
      <span className="service-indicator-label">{isOnline && !isLoading ? 'En ligne' : isLoading ? '…' : 'Hors ligne'}</span>
    </div>
  )
}