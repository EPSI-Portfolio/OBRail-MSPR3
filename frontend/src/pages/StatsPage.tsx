import { useStats } from '../hooks/useStats'
import StatsCard from '../components/stats/StatsCard'
import VolumeChart from '../components/stats/VolumeChart'
import DayNightChart from '../components/stats/DayNightChart'
import CO2Chart from '../components/stats/CO2Chart'
import LoadingSpinner from '../components/common/LoadingSpinner'
import ErrorMessage from '../components/common/ErrorMessage'

export default function StatsPage() {
  const { data, isLoading, error, barChartData, pieChartData, uniqueCountries, co2Data } = useStats()

  return (
    <main id="main-content" className="page-container fade-in">
      <div className="page-header">
        <h1 className="page-title">Tableau de Bord Statistiques</h1>
        <p className="page-subtitle">
          Vue d'ensemble des dessertes ferroviaires européennes et de leur contribution
          à la réduction des émissions de CO₂ par rapport au transport aérien.
        </p>
      </div>

      {isLoading && <LoadingSpinner message="Chargement des statistiques..." />}
      {error && <ErrorMessage message={error} />}

      {!isLoading && !error && data && (
        <>
          {/* KPIs */}
          <section aria-labelledby="kpi-title" id="kpi-section">
            <h2 id="kpi-title" className="sr-only">Chiffres clés</h2>
            <div className="kpi-grid">
              <StatsCard id="kpi-total" value={data.total} label="Trajets au total" icon="🚆" />
              <StatsCard id="kpi-day" value={pieChartData[0]?.value ?? 0} label="Trains de jour" icon="☀️" />
              <StatsCard id="kpi-night" value={pieChartData[1]?.value ?? 0} label="Trains de nuit" icon="🌙" />
              <StatsCard id="kpi-countries" value={uniqueCountries} label="Pays desservis" icon="🗺️" />
            </div>
          </section>

          {/* Graphique en barres */}
          <section aria-labelledby="bar-chart-title" id="bar-chart-section">
            <div className="chart-card">
              <p className="chart-card-title" id="bar-chart-title">Volume de trajets par pays</p>
              <p className="chart-card-desc">
                Répartition des dessertes ferroviaires par pays d'origine, distinguant trains de jour et de nuit.
              </p>
              <VolumeChart data={barChartData} />
              <div className="insight-box">
                <span className="insight-icon">💡</span>
                <div className="insight-content">
                  <p className="insight-label">Observation clé</p>
                  <p className="insight-text">
                    {barChartData[0]
                      ? `${barChartData.reduce((a, b) => a.day + a.night > b.day + b.night ? a : b).country} concentre le plus grand volume de liaisons ferroviaires en Europe.`
                      : 'Chargement des insights...'}
                  </p>
                </div>
              </div>
            </div>
          </section>

          {/* Camembert */}
          <section aria-labelledby="pie-chart-title" id="pie-chart-section">
            <div className="chart-card">
              <p className="chart-card-title" id="pie-chart-title">Répartition Jour / Nuit</p>
              <p className="chart-card-desc">
                Proportion des trains de jour et de nuit dans l'ensemble des dessertes européennes analysées.
              </p>
              <DayNightChart data={pieChartData} />
              {pieChartData[1] && (
                <div className="insight-box">
                  <span className="insight-icon">🌙</span>
                  <div className="insight-content">
                    <p className="insight-label">Trains de nuit</p>
                    <p className="insight-text">
                      Les trains de nuit représentent {Math.round((pieChartData[1].value / (pieChartData[0].value + pieChartData[1].value)) * 100)}% des liaisons,
                      une alternative crédible à l'avion sur les longs trajets intra-européens.
                    </p>
                  </div>
                </div>
              )}
            </div>
          </section>

          {/* CO2 */}
          {co2Data && (
            <section aria-labelledby="co2-chart-title" id="co2-section">
              <div className="chart-card">
                <p className="chart-card-title" id="co2-chart-title">Impact CO₂ par pays</p>
                <p className="chart-card-desc">
                  Économies de CO₂ générées par le choix du train plutôt que l'avion, agrégées par pays d'origine.
                </p>
                <CO2Chart
                  data={co2Data.by_country}
                  totalSavedTons={co2Data.total_co2_saved_tons}
                  avgSavingsPercent={co2Data.avg_savings_percent}
                />
                <div className="insight-box">
                  <span className="insight-icon">🌱</span>
                  <div className="insight-content">
                    <p className="insight-label">Impact écologique</p>
                    <p className="insight-text">
                      Le rail réduit les émissions de {co2Data.avg_savings_percent.toFixed(1)}% en moyenne comparé à l'avion,
                      soit {co2Data.total_co2_saved_tons.toFixed(1)} tonnes de CO₂ économisées sur l'ensemble des trajets.
                    </p>
                  </div>
                </div>
              </div>
            </section>
          )}
        </>
      )}
    </main>
  )
}