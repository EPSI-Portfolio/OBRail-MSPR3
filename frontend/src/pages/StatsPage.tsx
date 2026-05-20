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
    <main id="main-content" className="page-container">
      <h1 id="page-title-stats">Tableau de Bord Statistiques</h1>

      {isLoading && <LoadingSpinner message="Chargement des statistiques..." />}
      {error && <ErrorMessage message={error} />}

      {!isLoading && !error && data && (
        <>
          <section aria-labelledby="kpi-title" id="kpi-section">
            <h2 id="kpi-title" className="sr-only">Chiffres clés</h2>
            <div className="kpi-grid">
              <StatsCard id="kpi-total" value={data.total} label="Trajets au total" icon="🚆" />
              <StatsCard id="kpi-day" value={pieChartData[0]?.value ?? 0} label="Trains de jour" icon="☀️" />
              <StatsCard id="kpi-night" value={pieChartData[1]?.value ?? 0} label="Trains de nuit" icon="🌙" />
              <StatsCard id="kpi-countries" value={uniqueCountries} label="Pays desservis" icon="🗺️" />
            </div>
          </section>

          <section aria-labelledby="bar-chart-title" id="bar-chart-section">
            <h2 id="bar-chart-title">Volume de trajets par pays</h2>
            <VolumeChart data={barChartData} />
          </section>

          <section aria-labelledby="pie-chart-title" id="pie-chart-section">
            <h2 id="pie-chart-title">Répartition Jour / Nuit</h2>
            <DayNightChart data={pieChartData} />
          </section>

          {co2Data && (
            <section aria-labelledby="co2-chart-title" id="co2-section">
              <h2 id="co2-chart-title">Impact CO₂ par pays</h2>
              <CO2Chart
                data={co2Data.by_country}
                totalSavedTons={co2Data.total_co2_saved_tons}
                avgSavingsPercent={co2Data.avg_savings_percent}
              />
            </section>
          )}
        </>
      )}
    </main>
  )
}