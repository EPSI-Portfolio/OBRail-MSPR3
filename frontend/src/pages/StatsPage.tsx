// StatsPage.tsx
import { useStats } from '../hooks/useStats'
import StatsCard from '../components/stats/StatsCard'
import VolumeChart from '../components/stats/VolumeChart'
import DayNightChart from '../components/stats/DayNightChart'
import LoadingSpinner from '../components/common/LoadingSpinner'
import ErrorMessage from '../components/common/ErrorMessage'

export default function StatsPage() {
  const { data, isLoading, error, barChartData, pieChartData, uniqueCountries } = useStats()

  return (
    <main id="main-content" className="page-container">
      <h1 id="page-title-stats">Tableau de Bord Statistiques</h1>

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
            <h2 id="bar-chart-title">Volume de trajets par pays</h2>
            <VolumeChart data={barChartData} />
          </section>

          {/* Camembert */}
          <section aria-labelledby="pie-chart-title" id="pie-chart-section">
            <h2 id="pie-chart-title">Répartition Jour / Nuit</h2>
            <DayNightChart data={pieChartData} />
          </section>
        </>
      )}
    </main>
  )
}