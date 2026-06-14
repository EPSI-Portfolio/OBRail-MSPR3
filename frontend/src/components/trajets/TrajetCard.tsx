import { useNavigate } from 'react-router-dom'
import type { TrajetSummary } from '../../types/trajet'
import { formatDistance, formatDuration, formatPercent } from '../../utils/formatters'

// Map codes pays → drapeaux emoji
const FLAGS: Record<string, string> = {
  FR: '🇫🇷', DE: '🇩🇪', CH: '🇨🇭', IT: '🇮🇹', ES: '🇪🇸',
  BE: '🇧🇪', NL: '🇳🇱', AT: '🇦🇹', PT: '🇵🇹', PL: '🇵🇱',
  CZ: '🇨🇿', HU: '🇭🇺', RO: '🇷🇴', BG: '🇧🇬', HR: '🇭🇷',
  SK: '🇸🇰', SE: '🇸🇪', NO: '🇳🇴', DK: '🇩🇰', FI: '🇫🇮',
  GB: '🇬🇧', LU: '🇱🇺', MD: '🇲🇩', SI: '🇸🇮', RS: '🇷🇸',
}

const getFlag = (code: string) => FLAGS[code?.toUpperCase()] ?? '🏳️'

interface Props {
  trajet: TrajetSummary
}

export default function TrajetCard({ trajet }: Props) {
  const navigate = useNavigate()
  const isNight = trajet.service_type === 'night'

  const handleClick = () => navigate(`/trajets/${trajet.route_id}`)
  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' || e.key === ' ') handleClick()
  }

  return (
    <article
      className={`trajet-card tcard ${isNight ? 'night tcard--night' : 'day tcard--day'}`}
      id={`trajet-card-${trajet.route_id}`}
      onClick={handleClick}
      onKeyDown={handleKeyDown}
      tabIndex={0}
      role="button"
      aria-label={`Voir le trajet ${trajet.origin} vers ${trajet.destination}`}
    >
      {/* Barre dégradée haut */}
      <div className="tcard__stripe" aria-hidden="true" />

      <div className="tcard__body">
        {/* Header : badge + opérateur */}
        <div className="tcard__header">
          <span
            className="tcard__badge"
            aria-label={isNight ? 'Train de nuit' : 'Train de jour'}
          >
            {isNight ? '🌙 Nuit' : '☀️ Jour'}
          </span>
          <span className="tcard__operator" id={`operator-${trajet.route_id}`}>
            {trajet.operator}
          </span>
        </div>

        {/* Route avec drapeaux et ligne graphique */}
        <div className="tcard__route">
          <span className="tcard__flag" aria-hidden="true">
            {getFlag(trajet.origin_country)}
          </span>
          <span className="tcard__city" id={`origin-${trajet.route_id}`}>
            {trajet.origin}
          </span>
          <div className="tcard__route-line" aria-hidden="true">
            <div className="tcard__route-dot" />
            <div className="tcard__route-dashes" />
            <span className="tcard__train-icon">🚆</span>
            <div className="tcard__route-dashes" />
            <div className="tcard__route-dot" />
          </div>
          <span className="tcard__city" id={`destination-${trajet.route_id}`}>
            {trajet.destination}
          </span>
          <span className="tcard__flag" aria-hidden="true">
            {getFlag(trajet.destination_country)}
          </span>
        </div>

        {/* Pays */}
        <p className="tcard__countries">
          {trajet.origin_country} → {trajet.destination_country}
        </p>

        <div className="tcard__divider" aria-hidden="true" />

        {/* Métriques */}
        <div className="tcard__metrics">
          <div className="tcard__metric">
            <span className="tcard__metric-label">Distance</span>
            <span className="tcard__metric-value" id={`distance-${trajet.route_id}`}>
              {formatDistance(trajet.distance_km)}
            </span>
          </div>
          <div className="tcard__metric">
            <span className="tcard__metric-label">Durée</span>
            <span className="tcard__metric-value" id={`duration-${trajet.route_id}`}>
              {formatDuration(trajet.duration_minutes)}
            </span>
          </div>
          <div className="tcard__metric">
            <span className="tcard__metric-label">CO₂ économisé</span>
            <span
              className="tcard__metric-value tcard__metric-value--green"
              id={`co2-${trajet.route_id}`}
            >
              -{formatPercent(trajet.savings_percent)}
            </span>
          </div>
        </div>
      </div>
    </article>
  )
}