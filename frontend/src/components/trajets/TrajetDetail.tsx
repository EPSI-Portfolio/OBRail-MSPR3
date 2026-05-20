import type { Trajet } from '../../types/trajet'
import { formatDistance, formatDuration, formatCO2, formatPercent, formatDate, formatServiceType } from '../../utils/formatters'

interface Props {
  trajet: Trajet
}

export default function TrajetDetail({ trajet }: Props) {
  return (
    <article id="trajet-detail" aria-label={`Détail du trajet ${trajet.route_name}`}>
      <div className="detail-header">
        <span
          className={`badge-service ${trajet.service_type}`}
          id="detail-service-type"
          aria-label={trajet.service_type === 'night' ? 'Train de nuit' : 'Train de jour'}
        >
          {formatServiceType(trajet.service_type)}
        </span>
        <h1 id="detail-route-name">{trajet.route_name}</h1>
        <p id="detail-operator" className="detail-operator">{trajet.operator}</p>
      </div>

      <div className="detail-grid">
        {/* Itinéraire */}
        <section className="detail-section" aria-labelledby="section-trajet">
          <h2 id="section-trajet">Itinéraire</h2>
          <dl>
            <dt>Départ</dt>
            <dd id="detail-origin">{trajet.origin} ({trajet.origin_country})</dd>

            <dt>Arrivée</dt>
            <dd id="detail-destination">{trajet.destination} ({trajet.destination_country})</dd>

            <dt>Distance</dt>
            <dd id="detail-distance">{formatDistance(trajet.distance_km)}</dd>

            <dt>Durée estimée</dt>
            <dd id="detail-duration">{formatDuration(trajet.duration_minutes)}</dd>

            <dt>Type de train</dt>
            <dd id="detail-train-type">{trajet.train_type}</dd>

            <dt>Opérateur</dt>
            <dd id="detail-operator-info">{trajet.operator}</dd>
          </dl>
        </section>

        {/* Impact environnemental */}
        <section className="detail-section" aria-labelledby="section-co2">
          <h2 id="section-co2">Impact environnemental</h2>
          <dl>
            <dt>CO₂ train</dt>
            <dd id="detail-train-co2">{formatCO2(trajet.train_co2_kg)}</dd>

            <dt>CO₂ avion équivalent</dt>
            <dd id="detail-plane-co2">{formatCO2(trajet.plane_co2_kg)}</dd>

            <dt>Économie CO₂</dt>
            <dd id="detail-co2-savings" className="highlight-savings">
              {formatCO2(trajet.co2_savings_kg)} économisés ({formatPercent(trajet.savings_percent)})
            </dd>

            <dt>Source des données</dt>
            <dd id="detail-emission-source">{trajet.emission_source}</dd>

            <dt>Date de calcul</dt>
            <dd id="detail-calc-date">{formatDate(trajet.calculation_date)}</dd>
          </dl>
        </section>
      </div>
    </article>
  )
}