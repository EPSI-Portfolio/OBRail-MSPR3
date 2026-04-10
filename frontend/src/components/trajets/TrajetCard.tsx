import { useNavigate } from 'react-router-dom'
import type { TrajetSummary } from '../../types/trajet'
import { formatDistance, formatDuration, formatPercent } from '../../utils/formatters'

interface Props {
  trajet: TrajetSummary
}

export default function TrajetCard({ trajet }: Props) {
  const navigate = useNavigate()

  const handleClick = () => navigate(`/trajets/${trajet.route_id}`)
  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' || e.key === ' ') handleClick()
  }

  return (
    <article
      className={`trajet-card ${trajet.service_type}`}
      id={`trajet-card-${trajet.route_id}`}
      onClick={handleClick}
      onKeyDown={handleKeyDown}
      tabIndex={0}
      role="button"
      aria-label={`Voir le trajet ${trajet.route_name_simple} — ${trajet.origin} vers ${trajet.destination}`}
    >
      <div className="trajet-card-header">
        <span
          className={`badge-service ${trajet.service_type}`}
          aria-label={trajet.service_type === 'night' ? 'Train de nuit' : 'Train de jour'}
        >
          {trajet.service_type === 'night' ? '🌙 Nuit' : '☀️ Jour'}
        </span>
        <span className="trajet-operator" id={`operator-${trajet.route_id}`}>
          {trajet.operator}
        </span>
      </div>

      <h2 className="trajet-route" id={`route-name-${trajet.route_id}`}>
        {trajet.origin} → {trajet.destination}
      </h2>

      <p className="trajet-countries">
        {trajet.origin_country} → {trajet.destination_country}
      </p>

      <div className="trajet-card-footer">
        <span id={`distance-${trajet.route_id}`}>
          {formatDistance(trajet.distance_km)}
        </span>
        <span id={`duration-${trajet.route_id}`}>
          {formatDuration(trajet.duration_minutes)}
        </span>
        <span className="co2-savings" id={`co2-${trajet.route_id}`}>
          🌿 -{formatPercent(trajet.savings_percent)} CO₂
        </span>
      </div>
    </article>
  )
}