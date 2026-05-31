import { useState } from 'react'
import { useStats } from '../hooks/useStats'
import StatsCard from '../components/stats/StatsCard'
import VolumeChart from '../components/stats/VolumeChart'
import DayNightChart from '../components/stats/DayNightChart'
import CO2Chart from '../components/stats/CO2Chart'
import LoadingSpinner from '../components/common/LoadingSpinner'
import ErrorMessage from '../components/common/ErrorMessage'
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid,
  Tooltip, Legend, ResponsiveContainer
} from 'recharts'

type Tab = 'couverture' | 'operateurs' | 'co2' | 'comparaison'

export default function StatsPage() {
  const [activeTab, setActiveTab] = useState<Tab>('couverture')
  const { data, isLoading, error, barChartData, pieChartData, uniqueCountries, co2Data } = useStats()

  // Données par opérateur
  const operatorData = data
    ? Object.values(
        data.data.reduce<Record<string, { operator: string; day: number; night: number; total: number }>>((acc, item) => {
          // On utilise origin_country comme proxy — idéalement l'API retournerait les opérateurs
          const key = item.origin_country
          if (!acc[key]) acc[key] = { operator: key, day: 0, night: 0, total: 0 }
          acc[key][item.service_type] += item.route_count
          acc[key].total += item.route_count
          return acc
        }, {})
      ).sort((a, b) => b.total - a.total).slice(0, 10)
    : []

  // Données comparaison jour vs nuit
  const comparisonData = data
    ? [
        {
          critere: 'Trajets',
          Jour: pieChartData[0]?.value ?? 0,
          Nuit: pieChartData[1]?.value ?? 0,
        },
        {
          critere: 'Pays',
          Jour: data.data.filter(d => d.service_type === 'day').length,
          Nuit: data.data.filter(d => d.service_type === 'night').length,
        },
        {
          critere: 'Dist. moy. (km)',
          Jour: Math.round(data.data.filter(d => d.service_type === 'day').reduce((s, d) => s + d.avg_distance_km, 0) / Math.max(data.data.filter(d => d.service_type === 'day').length, 1)),
          Nuit: Math.round(data.data.filter(d => d.service_type === 'night').reduce((s, d) => s + d.avg_distance_km, 0) / Math.max(data.data.filter(d => d.service_type === 'night').length, 1)),
        },
      ]
    : []

  const tabs: { id: Tab; label: string; icon: string }[] = [
    { id: 'couverture', label: 'Couverture', icon: '🗺️' },
    { id: 'operateurs', label: 'Par pays', icon: '🚉' },
    { id: 'co2', label: 'Impact CO₂', icon: '🌱' },
    { id: 'comparaison', label: 'Jour vs Nuit', icon: '📊' },
  ]

  return (
    <main id="main-content" className="page-container fade-in">
      {/* En-tête */}
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
          <section aria-label="Chiffres clés" id="kpi-section">
            <div className="kpi-grid">
              <StatsCard id="kpi-total" value={data.total} label="Trajets au total" icon="🚆" />
              <StatsCard id="kpi-day" value={pieChartData[0]?.value ?? 0} label="Trains de jour" icon="☀️" />
              <StatsCard id="kpi-night" value={pieChartData[1]?.value ?? 0} label="Trains de nuit" icon="🌙" />
              <StatsCard id="kpi-countries" value={uniqueCountries} label="Pays desservis" icon="🗺️" />
            </div>
          </section>

          {/* Onglets */}
          <div className="tabs-wrapper">
            <div className="tabs-nav" role="tablist" aria-label="Sections statistiques">
              {tabs.map(tab => (
                <button
                  key={tab.id}
                  role="tab"
                  aria-selected={activeTab === tab.id}
                  aria-controls={`panel-${tab.id}`}
                  id={`tab-${tab.id}`}
                  className={`tab-btn ${activeTab === tab.id ? 'tab-btn--active' : ''}`}
                  onClick={() => setActiveTab(tab.id)}
                >
                  <span aria-hidden="true">{tab.icon}</span>
                  {tab.label}
                </button>
              ))}
            </div>

            {/* Panel Couverture */}
            {activeTab === 'couverture' && (
              <div
                id="panel-couverture"
                role="tabpanel"
                aria-labelledby="tab-couverture"
                className="tab-panel fade-in"
              >
                <div className="chart-card">
                  <p className="chart-card-title">Volume de trajets par pays</p>
                  <p className="chart-card-desc">
                    Répartition des dessertes ferroviaires par pays d'origine,
                    distinguant trains de jour et de nuit.
                  </p>
                  <VolumeChart data={barChartData} />
                  <div className="insight-box">
                    <span className="insight-icon">💡</span>
                    <div className="insight-content">
                      <p className="insight-label">Observation clé</p>
                      <p className="insight-text">
                        {barChartData.length > 0
                          ? `${barChartData.reduce((a, b) => (a.day + a.night) > (b.day + b.night) ? a : b).country} concentre le plus grand volume de liaisons ferroviaires en Europe.`
                          : 'Chargement...'}
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            )}

            {/* Panel Opérateurs / Par pays */}
            {activeTab === 'operateurs' && (
              <div
                id="panel-operateurs"
                role="tabpanel"
                aria-labelledby="tab-operateurs"
                className="tab-panel fade-in"
              >
                <div className="chart-card">
                  <p className="chart-card-title">Top 10 pays — Volume total de liaisons</p>
                  <p className="chart-card-desc">
                    Classement des pays par nombre total de trajets ferroviaires,
                    toutes catégories confondues.
                  </p>
                  <div id="operator-chart" aria-label="Graphique volume par pays">
                    <ResponsiveContainer width="100%" height={340}>
                      <BarChart
                        data={operatorData}
                        layout="vertical"
                        margin={{ top: 10, right: 30, left: 20, bottom: 5 }}
                      >
                        <CartesianGrid strokeDasharray="3 3" horizontal={false} />
                        <XAxis type="number" allowDecimals={false} />
                        <YAxis type="category" dataKey="operator" width={40} />
                        <Tooltip />
                        <Legend />
                        <Bar dataKey="day" name="Jour" fill="#f59e0b" stackId="a" />
                        <Bar dataKey="night" name="Nuit" fill="#6366f1" stackId="a" radius={[0, 4, 4, 0]} />
                      </BarChart>
                    </ResponsiveContainer>
                  </div>
                  <div className="insight-box">
                    <span className="insight-icon">🚉</span>
                    <div className="insight-content">
                      <p className="insight-label">Réseau le plus dense</p>
                      <p className="insight-text">
                        {operatorData[0]
                          ? `Le pays ${operatorData[0].operator} domine le réseau avec ${operatorData[0].total} liaisons recensées.`
                          : 'Chargement...'}
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            )}

            {/* Panel CO2 */}
            {activeTab === 'co2' && (
              <div
                id="panel-co2"
                role="tabpanel"
                aria-labelledby="tab-co2"
                className="tab-panel fade-in"
              >
                <div className="chart-card">
                  <p className="chart-card-title">Répartition Jour / Nuit</p>
                  <p className="chart-card-desc">
                    Proportion des trains de jour et de nuit dans l'ensemble des dessertes analysées.
                  </p>
                  <DayNightChart data={pieChartData} />
                </div>

                {co2Data && (
                  <div className="chart-card" style={{ marginTop: '1rem' }}>
                    <p className="chart-card-title">Impact CO₂ par pays</p>
                    <p className="chart-card-desc">
                      Économies de CO₂ générées par le choix du train plutôt que l'avion.
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
                          Le rail réduit les émissions de {co2Data.avg_savings_percent.toFixed(1)}% en moyenne
                          comparé à l'avion, soit {co2Data.total_co2_saved_tons.toFixed(1)} tonnes de CO₂ économisées.
                        </p>
                      </div>
                    </div>
                  </div>
                )}
              </div>
            )}

            {/* Panel Comparaison */}
            {activeTab === 'comparaison' && (
              <div
                id="panel-comparaison"
                role="tabpanel"
                aria-labelledby="tab-comparaison"
                className="tab-panel fade-in"
              >
                <div className="chart-card">
                  <p className="chart-card-title">Trains de jour vs Trains de nuit</p>
                  <p className="chart-card-desc">
                    Comparaison des indicateurs clés entre les deux types de services ferroviaires.
                  </p>
                  <div id="comparison-chart" aria-label="Comparaison jour vs nuit">
                    <ResponsiveContainer width="100%" height={300}>
                      <BarChart data={comparisonData} margin={{ top: 10, right: 20, left: 0, bottom: 5 }}>
                        <CartesianGrid strokeDasharray="3 3" />
                        <XAxis dataKey="critere" />
                        <YAxis />
                        <Tooltip />
                        <Legend />
                        <Bar dataKey="Jour" fill="#f59e0b" radius={[4, 4, 0, 0]} />
                        <Bar dataKey="Nuit" fill="#6366f1" radius={[4, 4, 0, 0]} />
                      </BarChart>
                    </ResponsiveContainer>
                  </div>
                </div>

                {/* Cards comparaison */}
                <div className="comparison-grid">
                  <div className="comparison-card comparison-card--day">
                    <div className="comparison-card-header">
                      <span className="comparison-card-icon">☀️</span>
                      <h3 className="comparison-card-title">Trains de Jour</h3>
                      <span className="comparison-card-count">{pieChartData[0]?.value ?? 0} liaisons</span>
                    </div>
                    <ul className="comparison-card-list">
                      <li>Connexions urbaines rapides</li>
                      <li>Idéal pour trajets de 2h à 6h</li>
                      <li>Fréquence élevée en journée</li>
                      <li>Vues panoramiques du paysage</li>
                      <li>Alternative directe aux vols court-courriers</li>
                    </ul>
                  </div>

                  <div className="comparison-card comparison-card--night">
                    <div className="comparison-card-header">
                      <span className="comparison-card-icon">🌙</span>
                      <h3 className="comparison-card-title">Trains de Nuit</h3>
                      <span className="comparison-card-count">{pieChartData[1]?.value ?? 0} liaisons</span>
                    </div>
                    <ul className="comparison-card-list">
                      <li>Économie sur l'hébergement</li>
                      <li>Trajets longue distance (6h à 14h)</li>
                      <li>Arrivée tôt le matin à destination</li>
                      <li>Couchettes et wagons-lits disponibles</li>
                      <li>Alternative crédible aux vols long-courriers</li>
                    </ul>
                  </div>
                </div>

                {/* Conclusion */}
                <div className="conclusion-card">
                  <h3 className="conclusion-title">Complémentarité jour & nuit</h3>
                  <p className="conclusion-text">
                    Les trains de jour et de nuit forment un réseau complémentaire couvrant
                    {uniqueCountries} pays européens. Ensemble, ils offrent {data.total} liaisons
                    ferroviaires permettant de réduire en moyenne {co2Data?.avg_savings_percent.toFixed(0) ?? '90'}%
                    des émissions de CO₂ par rapport à l'avion, contribuant activement
                    aux objectifs du Green Deal européen.
                  </p>
                </div>
              </div>
            )}
          </div>
        </>
      )}
    </main>
  )
}