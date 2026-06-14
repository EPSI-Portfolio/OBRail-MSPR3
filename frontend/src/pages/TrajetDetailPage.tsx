import { useParams, useNavigate } from 'react-router-dom'
import { useTrajetDetail } from '../hooks/useTrajets'
import LoadingSpinner from '../components/common/LoadingSpinner'
import ErrorMessage from '../components/common/ErrorMessage'
import { formatDistance, formatDuration, formatCO2, formatPercent } from '../utils/formatters'

export default function TrajetDetailPage() {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()
  const { data: trajet, isLoading, error } = useTrajetDetail(id)

  const isNight = trajet?.service_type === 'night'

  // Barre de progression CO2 (train vs avion)
  const trainCO2  = trajet?.train_co2_kg  ?? 0
  const planeCO2  = trajet?.plane_co2_kg  ?? 1
  const trainPct  = Math.round((trainCO2 / planeCO2) * 100)
  const planePct  = 100

  return (
    <main id="main-content" className="page-container fade-in">
      <button
        id="back-btn"
        className="btn-back"
        onClick={() => navigate('/trajets')}
        aria-label="Retour à la liste des trajets"
      >
        ← Retour à la liste
      </button>

      {isLoading && <LoadingSpinner message="Chargement du trajet..." />}
      {error    && <ErrorMessage message={error} />}

      {!isLoading && !error && trajet && (
        <>
          {/* ── Hero Section ── */}
          <div className={`detail-hero ${isNight ? 'detail-hero--night' : ''}`} id="trajet-detail">
            <div className="detail-hero-top">
              <span
                className="detail-hero-badge"
                id="detail-service-type"
                aria-label={isNight ? 'Train de nuit' : 'Train de jour'}
              >
                {isNight ? '🌙 Train de nuit' : '☀️ Train de jour'}
              </span>
              <span className="detail-hero-operator" id="detail-operator">
                {trajet.operator}
              </span>
            </div>

            {/* Route visuelle */}
            <div className="detail-hero-route" id="detail-route-name">
              <div className="detail-hero-city">
                <span className="detail-hero-country">{trajet.origin_country}</span>
                <span className="detail-hero-cityname">{trajet.origin}</span>
              </div>
              <div className="detail-hero-line" aria-hidden="true">
                <div className="detail-hero-dot" />
                <div className="detail-hero-dashes" />
                <span className="detail-hero-train">🚆</span>
                <div className="detail-hero-dashes" />
                <div className="detail-hero-dot" />
              </div>
              <div className="detail-hero-city detail-hero-city--right">
                <span className="detail-hero-country">{trajet.destination_country}</span>
                <span className="detail-hero-cityname">{trajet.destination}</span>
              </div>
            </div>

            {/* KPI badges */}
            <div className="detail-hero-metrics">
              <div className="detail-hero-metric" id="detail-distance">
                <span className="detail-hero-metric-icon">📍</span>
                <div>
                  <span className="detail-hero-metric-value">{formatDistance(trajet.distance_km)}</span>
                  <span className="detail-hero-metric-label">Distance</span>
                </div>
              </div>
              <div className="detail-hero-metric" id="detail-duration">
                <span className="detail-hero-metric-icon">⏱</span>
                <div>
                  <span className="detail-hero-metric-value">{formatDuration(trajet.duration_minutes)}</span>
                  <span className="detail-hero-metric-label">Durée</span>
                </div>
              </div>
              <div className="detail-hero-metric detail-hero-metric--green" id="detail-co2-savings">
                <span className="detail-hero-metric-icon">🌱</span>
                <div>
                  <span className="detail-hero-metric-value">-{formatPercent(trajet.savings_percent)}</span>
                  <span className="detail-hero-metric-label">CO₂ économisé</span>
                </div>
              </div>
              <div className="detail-hero-metric" id="detail-train-type">
                <span className="detail-hero-metric-icon">🚆</span>
                <div>
                  <span className="detail-hero-metric-value">{trajet.train_type}</span>
                  <span className="detail-hero-metric-label">Type</span>
                </div>
              </div>
            </div>
          </div>

          {/* ── Grille info + CO2 ── */}
          <div className="detail-grid">
            {/* Itinéraire */}
            <section className="detail-section" aria-labelledby="section-trajet">
              <div className="detail-section-title" id="section-trajet">🗺️ Itinéraire</div>
              <dl>
                <dt>Départ</dt>
                <dd id="detail-origin">{trajet.origin} <span className="detail-country-code">({trajet.origin_country})</span></dd>

                <dt>Arrivée</dt>
                <dd id="detail-destination">{trajet.destination} <span className="detail-country-code">({trajet.destination_country})</span></dd>

                <dt>Distance</dt>
                <dd id="detail-distance-info">{formatDistance(trajet.distance_km)}</dd>

                <dt>Durée</dt>
                <dd id="detail-duration-info">{formatDuration(trajet.duration_minutes)}</dd>

                <dt>Type de train</dt>
                <dd id="detail-train-type-info">{trajet.train_type}</dd>

                <dt>Opérateur</dt>
                <dd id="detail-operator-info">{trajet.operator}</dd>
              </dl>
            </section>

            {/* Impact environnemental */}
            <section className="detail-section" aria-labelledby="section-co2">
              <div className="detail-section-title" id="section-co2">🌱 Impact environnemental</div>
              <dl>
                <dt>CO₂ train</dt>
                <dd id="detail-train-co2">{formatCO2(trajet.train_co2_kg)}</dd>

                <dt>CO₂ avion</dt>
                <dd id="detail-plane-co2">{formatCO2(trajet.plane_co2_kg)}</dd>

                <dt>Économie</dt>
                <dd id="detail-co2-savings-info" className="highlight-savings">
                  {formatCO2(trajet.co2_savings_kg)} économisés
                </dd>

                <dt>Réduction</dt>
                <dd className="highlight-savings">-{formatPercent(trajet.savings_percent)}</dd>

                <dt>Source</dt>
                <dd id="detail-emission-source">{trajet.emission_source}</dd>

                <dt>Date calcul</dt>
                <dd id="detail-calc-date">{trajet.calculation_date}</dd>
              </dl>
            </section>
          </div>

          {/* ── Comparaison Train / Avion ── */}
          <section className="co2-comparison" aria-labelledby="comparison-title">
            <h2 id="comparison-title" className="co2-comparison-title">
              ✈️ Comparaison Train / Avion
            </h2>

            <div className="co2-comparison-grid">
              <div className="co2-bar-item">
                <div className="co2-bar-header">
                  <span>🚆 Train — {trajet.operator}</span>
                  <span className="co2-bar-value co2-bar-value--green">{formatCO2(trajet.train_co2_kg)}</span>
                </div>
                <div className="co2-bar-track">
                  <div
                    className="co2-bar-fill co2-bar-fill--train"
                    style={{ width: `${trainPct}%` }}
                    role="progressbar"
                    aria-valuenow={trainPct}
                    aria-valuemin={0}
                    aria-valuemax={100}
                  />
                </div>
              </div>

              <div className="co2-bar-item">
                <div className="co2-bar-header">
                  <span>✈️ Avion (équivalent)</span>
                  <span className="co2-bar-value co2-bar-value--red">{formatCO2(trajet.plane_co2_kg)}</span>
                </div>
                <div className="co2-bar-track">
                  <div
                    className="co2-bar-fill co2-bar-fill--plane"
                    style={{ width: `${planePct}%` }}
                    role="progressbar"
                    aria-valuenow={planePct}
                    aria-valuemin={0}
                    aria-valuemax={100}
                  />
                </div>
              </div>
            </div>

            {/* Highlight économie */}
            <div className="co2-highlight">
              <span className="co2-highlight-value">{formatCO2(trajet.co2_savings_kg)}</span>
              <span className="co2-highlight-label">de CO₂ économisés en choisissant le train</span>
            </div>
          </section>
        </>
      )}
    </main>
  )
}