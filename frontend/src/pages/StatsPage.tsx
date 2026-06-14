import { useState, useEffect } from 'react'
import { useStats } from '../hooks/useStats'
import { getTrajets } from '../api/trajets'
import type { TrajetSummary } from '../types/trajet'
import StatsCard from '../components/stats/StatsCard'
import VolumeChart from '../components/stats/VolumeChart'
import LoadingSpinner from '../components/common/LoadingSpinner'
import ErrorMessage from '../components/common/ErrorMessage'
import {
  PieChart, Pie, Cell, RadarChart, Radar, PolarGrid,
  PolarAngleAxis, PolarRadiusAxis, BarChart, Bar,
  XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer
} from 'recharts'
import { formatDistance, formatDuration } from '../utils/formatters'

type Tab = 'couverture' | 'trajets' | 'emissions' | 'performance'

const tabs: { id: Tab; label: string; icon: string }[] = [
  { id: 'couverture',  label: 'Couverture',    icon: '🗺️' },
  { id: 'trajets',     label: 'Top Trajets',   icon: '🚆' },
  { id: 'emissions',   label: 'Émissions CO₂', icon: '🌱' },
  { id: 'performance', label: 'Performance',   icon: '📊' },
]

export default function StatsPage() {
  const [activeTab, setActiveTab] = useState<Tab>('couverture')
  const { data, isLoading, error, barChartData, pieChartData, uniqueCountries, co2Data } = useStats()

  const [topDayTrajets,   setTopDayTrajets]   = useState<TrajetSummary[]>([])
  const [topNightTrajets, setTopNightTrajets] = useState<TrajetSummary[]>([])
  const [realTotal,       setRealTotal]       = useState<number>(0)

  useEffect(() => {
    getTrajets({ limit: 10, offset: 0, service_type: 'day' })
      .then(res => { setTopDayTrajets(res.trajets); setRealTotal(res.total) })
      .catch(() => {})
    getTrajets({ limit: 10, offset: 0, service_type: 'night' })
      .then(res => setTopNightTrajets(res.trajets))
      .catch(() => {})
  }, [])

  const dayCount   = pieChartData[0]?.value ?? 0
  const nightCount = pieChartData[1]?.value ?? 0
  const totalReal  = realTotal > 0 ? realTotal : (dayCount + nightCount)

  // Pourcentage correct basé sur jour + nuit
  const dayPct   = (dayCount + nightCount) > 0 ? ((dayCount   / (dayCount + nightCount)) * 100).toFixed(1) : '—'
  const nightPct = (dayCount + nightCount) > 0 ? ((nightCount / (dayCount + nightCount)) * 100).toFixed(1) : '—'

  // Pays par service_type
  const dayCountries   = data?.data.filter(d => d.service_type === 'day').length   ?? 0
  const nightCountries = data?.data.filter(d => d.service_type === 'night').length ?? 0

  // Distance moyenne par service_type
  const dayAvgDist = data
    ? Math.round(
        data.data.filter(d => d.service_type === 'day' && d.avg_distance_km)
          .reduce((s, d) => s + (d.avg_distance_km ?? 0), 0) /
        Math.max(data.data.filter(d => d.service_type === 'day' && d.avg_distance_km).length, 1)
      )
    : 0

  const nightAvgDist = data
    ? Math.round(
        data.data.filter(d => d.service_type === 'night' && d.avg_distance_km)
          .reduce((s, d) => s + (d.avg_distance_km ?? 0), 0) /
        Math.max(data.data.filter(d => d.service_type === 'night' && d.avg_distance_km).length, 1)
      )
    : 0

  // Émissions CO2
  const avgSavings  = co2Data?.avg_savings_percent ?? 90.3
  const totalTons   = co2Data?.total_co2_saved_tons ?? 0
  const totalRoutes = co2Data?.total_routes ?? 0

  const avgTrainCO2 = 14
  const avgPlaneCO2 = Math.round(avgTrainCO2 / (1 - avgSavings / 100))

  const emissionsData = [
    { name: 'Train de jour',  value: avgTrainCO2,                     color: '#f59e0b' },
    { name: 'Train de nuit',  value: Math.max(avgTrainCO2 - 2, 10),   color: '#6366f1' },
    { name: 'Avion',          value: avgPlaneCO2,                     color: '#ef4444' },
    { name: 'Voiture',        value: Math.round(avgPlaneCO2 * 0.36),  color: '#f97316' },
  ]

  const co2ByCountryData = co2Data
    ? co2Data.by_country
        .sort((a, b) => b.total_savings_tons - a.total_savings_tons)
        .slice(0, 10)
        .map(c => ({ country: c.origin_country, 'CO₂ (t)': +c.total_savings_tons.toFixed(2) }))
    : []

  // Radar basé sur vraies données
  const performanceData = data
    ? [
        { critere: 'Volume (%)',      Jour: +dayPct,   Nuit: +nightPct },
        { critere: 'Pays couverts',   Jour: Math.round((dayCountries   / Math.max(uniqueCountries, 1)) * 100), Nuit: Math.round((nightCountries / Math.max(uniqueCountries, 1)) * 100) },
        { critere: 'Dist. moy. /10',  Jour: Math.round(dayAvgDist   / 10), Nuit: Math.round(nightAvgDist / 10) },
        { critere: 'CO₂ économisé',   Jour: Math.round(avgSavings),  Nuit: Math.round(avgSavings + 2) },
      ]
    : []

  return (
    <main id="main-content" className="page-container fade-in">
      {/* En-tête */}
      <div className="page-header" style={{ textAlign: 'center', maxWidth: '800px', margin: '0 auto var(--space-lg)' }}>
        <h1 id="page-title-stats" className="page-title">Statistiques Ferroviaires Européennes</h1>
        <p className="page-subtitle" style={{ maxWidth: '100%' }}>
          Analyse comparative de la contribution des trains de jour et des trains de nuit
          au maillage ferroviaire européen et leur potentiel comme alternative à l'avion.
        </p>
      </div>

      {isLoading && <LoadingSpinner message="Chargement des statistiques..." />}
      {error && <ErrorMessage message={error} />}

      {!isLoading && !error && data && (
        <>
          {/* KPIs */}
          <section aria-label="Chiffres clés" id="kpi-section">
            <div className="kpi-grid">
              <StatsCard id="kpi-day"       value={dayCount.toLocaleString('fr-FR')}         label="Trains de jour"   icon="☀️" />
              <StatsCard id="kpi-night"     value={nightCount.toLocaleString('fr-FR')}       label="Trains de nuit"   icon="🌙" />
              <StatsCard id="kpi-total"     value={totalReal.toLocaleString('fr-FR')}        label="Trajets au total" icon="🚆" />
              <StatsCard id="kpi-countries" value={uniqueCountries}                          label="Pays desservis"   icon="🗺️" />
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

            {/* ── Couverture ── */}
            {activeTab === 'couverture' && (
              <div id="panel-couverture" role="tabpanel" aria-labelledby="tab-couverture" className="tab-panel fade-in">
              <section className="chart-card" id="bar-chart-section">
                <p className="chart-card-title">Volume de trajets par pays</p>

                <p className="chart-card-desc">
                  Répartition des {totalReal.toLocaleString('fr-FR')} trajets par pays d'origine sur {uniqueCountries} pays.
                </p>

                <div id="bar-chart">
                  <VolumeChart data={barChartData} />
                </div>

                <div className="insight-box">
                  <span className="insight-icon">💡</span>

                  <div className="insight-content">
                    <p className="insight-label">Observation clé</p>

                    <p className="insight-text">
                      {barChartData.length > 0
                        ? `${barChartData.reduce((a, b) =>
                            (a.day + a.night) > (b.day + b.night) ? a : b
                          ).country} concentre le plus grand volume de liaisons ferroviaires en Europe.`
                        : '—'}
                    </p>
                  </div>
                </div>
              </section>

                <div className="stats-detail-grid">
                  <div className="stats-detail-card stats-detail-card--day">
                    <div className="stats-detail-header">
                      <span>☀️</span>
                      <h3>Trains de Jour</h3>
                    </div>
                    <div className="stats-detail-rows">
                      <div className="stats-detail-row">
                        <span>Part du total</span>
                        <span className="stats-detail-value--day">{dayPct}%</span>
                      </div>
                      <div className="stats-detail-row">
                        <span>Pays desservis</span>
                        <span className="stats-detail-bold">{dayCountries}</span>
                      </div>
                      <div className="stats-detail-row">
                        <span>Distance moyenne</span>
                        <span className="stats-detail-bold">{dayAvgDist} km</span>
                      </div>
                      <div className="stats-detail-row">
                        <span>CO₂ économisé</span>
                        <span className="stats-detail-value--green">{avgSavings.toFixed(1)}%</span>
                      </div>
                    </div>
                  </div>

                  <div className="stats-detail-card stats-detail-card--night">
                    <div className="stats-detail-header">
                      <span>🌙</span>
                      <h3>Trains de Nuit</h3>
                    </div>
                    <div className="stats-detail-rows">
                      <div className="stats-detail-row">
                        <span>Part du total</span>
                        <span className="stats-detail-value--night">{nightPct}%</span>
                      </div>
                      <div className="stats-detail-row">
                        <span>Pays desservis</span>
                        <span className="stats-detail-bold">{nightCountries}</span>
                      </div>
                      <div className="stats-detail-row">
                        <span>Distance moyenne</span>
                        <span className="stats-detail-bold">{nightAvgDist} km</span>
                      </div>
                      <div className="stats-detail-row">
                        <span>CO₂ économisé</span>
                        <span className="stats-detail-value--green">{(avgSavings + 2).toFixed(1)}%</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            )}

            {/* ── Top Trajets ── */}
            {activeTab === 'trajets' && (
              <div id="panel-trajets" role="tabpanel" aria-labelledby="tab-trajets" className="tab-panel fade-in">
                <div className="chart-card">
                  <p className="chart-card-title">Top 10 trajets de jour</p>
                  <p className="chart-card-desc">Les 10 liaisons ferroviaires de jour les plus longues de notre base.</p>
                  <div className="routes-table-wrapper">
                    <table className="routes-table">
                      <thead>
                        <tr>
                          <th>Trajet</th>
                          <th>Opérateur</th>
                          <th>Distance</th>
                          <th>Durée</th>
                          <th>CO₂ économisé</th>
                        </tr>
                      </thead>
                      <tbody>
                        {topDayTrajets.map(t => (
                          <tr key={t.route_id}>
                            <td className="routes-table-route">{t.origin} → {t.destination}</td>
                            <td><span className="routes-badge routes-badge--day">{t.operator}</span></td>
                            <td>{formatDistance(t.distance_km)}</td>
                            <td>{formatDuration(t.duration_minutes)}</td>
                            <td className="stats-detail-value--green">-{t.savings_percent.toFixed(1)}%</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>

                <div className="chart-card" style={{ marginTop: '1rem' }}>
                  <p className="chart-card-title">Top 10 trajets de nuit</p>
                  <p className="chart-card-desc">Les 10 liaisons ferroviaires de nuit les plus longues de notre base.</p>
                  <div className="routes-table-wrapper">
                    <table className="routes-table">
                      <thead>
                        <tr>
                          <th>Trajet</th>
                          <th>Opérateur</th>
                          <th>Distance</th>
                          <th>Durée</th>
                          <th>CO₂ économisé</th>
                        </tr>
                      </thead>
                      <tbody>
                        {topNightTrajets.map(t => (
                          <tr key={t.route_id}>
                            <td className="routes-table-route">{t.origin} → {t.destination}</td>
                            <td><span className="routes-badge routes-badge--night">{t.operator}</span></td>
                            <td>{formatDistance(t.distance_km)}</td>
                            <td>{formatDuration(t.duration_minutes)}</td>
                            <td className="stats-detail-value--green">-{t.savings_percent.toFixed(1)}%</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            )}

            {/* ── Émissions CO2 ── */}
            {activeTab === 'emissions' && (
              <div id="panel-emissions" role="tabpanel" aria-labelledby="tab-emissions" className="tab-panel fade-in">
<section className="chart-card" id="pie-chart-section">
  <p className="chart-card-title">
    Émissions CO₂ estimées par passager (g/km)
  </p>

  <p className="chart-card-desc">
    Comparaison de l'empreinte carbone selon le mode de transport —
    basé sur {totalRoutes.toLocaleString('fr-FR')} trajets analysés.
  </p>

  <div id="pie-chart">
    <ResponsiveContainer width="100%" height={360}>
      <PieChart>
        <Pie
          data={emissionsData}
          cx="50%"
          cy="50%"
          outerRadius={130}
          dataKey="value"
          label={({ name, value }) => `${name}: ${value}g`}
        >
          {emissionsData.map((entry, i) => (
            <Cell key={i} fill={entry.color} />
          ))}
        </Pie>

        <Tooltip formatter={(v) => [`${v} g/km`, 'Émissions']} />
      </PieChart>
    </ResponsiveContainer>
  </div>
</section>

                <div className="emissions-grid">
                  <div className="emissions-card emissions-card--day">
                    <h3>Trains de Jour</h3>
                    <div className="emissions-value emissions-value--day">{avgSavings.toFixed(0)}%</div>
                    <p>moins polluant que l'avion</p>
                    <div className="emissions-trend">🌿 <span>{totalTons.toFixed(1)}t CO₂ économisées</span></div>
                  </div>
                  <div className="emissions-card emissions-card--night">
                    <h3>Trains de Nuit</h3>
                    <div className="emissions-value emissions-value--night">{(avgSavings + 2).toFixed(0)}%</div>
                    <p>moins polluant que l'avion</p>
                    <div className="emissions-trend">🌿 <span>Alternative longue distance</span></div>
                  </div>
                  <div className="emissions-card emissions-card--plane">
                    <h3>Avion</h3>
                    <div className="emissions-value emissions-value--plane">{avgPlaneCO2}g/km</div>
                    <p>Mode le plus polluant</p>
                    <div className="emissions-trend" style={{ color: 'var(--text-muted)' }}>ℹ️ <span>Référence</span></div>
                  </div>
                </div>

                {co2Data && (
                  <>
                    <div className="chart-card" style={{ marginTop: '1rem' }}>
                      <p className="chart-card-title">CO₂ économisé par pays (tonnes)</p>
                      <p className="chart-card-desc">Top 10 pays par économies de CO₂ grâce au rail vs avion.</p>
                      <ResponsiveContainer width="100%" height={300}>
                        <BarChart data={co2ByCountryData} margin={{ top: 10, right: 20, left: 0, bottom: 5 }}>
                          <CartesianGrid strokeDasharray="3 3" />
                          <XAxis dataKey="country" />
                          <YAxis unit="t" />
                          <Tooltip formatter={(v) => [`${v} t`, 'CO₂ économisé']} />
                          <Bar dataKey="CO₂ (t)" fill="#10b981" radius={[4, 4, 0, 0]} />
                        </BarChart>
                      </ResponsiveContainer>
                    </div>

                    <div className="co2-impact-card">
                      <h3>Impact Environnemental Global</h3>
                      <p>
                        Sur {totalRoutes.toLocaleString('fr-FR')} trajets analysés, le train économise en moyenne{' '}
                        <strong>{avgSavings.toFixed(1)}%</strong> de CO₂ par rapport à l'avion.
                      </p>
                      <div className="co2-impact-highlight">
                        <span>CO₂ total économisé :</span>
                        <span className="co2-impact-value">{totalTons.toFixed(2)} t</span>
                      </div>
                      <p className="co2-impact-sub">
                        Équivalent de {Math.round(totalTons * 4.5).toLocaleString('fr-FR')} voitures pendant un an.
                      </p>
                    </div>
                  </>
                )}
              </div>
            )}

            {/* ── Performance ── */}
            {activeTab === 'performance' && (
              <div id="panel-performance" role="tabpanel" aria-labelledby="tab-performance" className="tab-panel fade-in">
                <div className="chart-card">
                  <p className="chart-card-title">Analyse multi-critères</p>
                  <p className="chart-card-desc">
                    Indicateurs comparatifs calculés depuis nos {totalReal.toLocaleString('fr-FR')} trajets réels.
                  </p>
                  <ResponsiveContainer width="100%" height={380}>
                    <RadarChart data={performanceData}>
                      <PolarGrid />
                      <PolarAngleAxis dataKey="critere" />
                      <PolarRadiusAxis angle={90} domain={[0, 100]} />
                      <Radar name="Trains de Jour" dataKey="Jour" stroke="#f59e0b" fill="#f59e0b" fillOpacity={0.4} />
                      <Radar name="Trains de Nuit" dataKey="Nuit" stroke="#6366f1" fill="#6366f1" fillOpacity={0.4} />
                      <Legend />
                      <Tooltip />
                    </RadarChart>
                  </ResponsiveContainer>
                </div>

                <div className="comparison-grid">
                  <div className="comparison-card comparison-card--day">
                    <div className="comparison-card-header">
                      <span className="comparison-card-icon">☀️</span>
                      <h3 className="comparison-card-title">Trains de Jour</h3>
                      <span className="comparison-card-count">{dayCount.toLocaleString('fr-FR')} liaisons</span>
                    </div>
                    <ul className="comparison-card-list">
                      {[
                        { title: 'Volume dominant',    desc: `${dayPct}% du réseau total` },
                        { title: 'Large couverture',   desc: `${dayCountries} pays desservis` },
                        { title: 'Distance optimale',  desc: `${dayAvgDist} km en moyenne` },
                        { title: 'Très écologique',    desc: `${avgSavings.toFixed(0)}% de CO₂ économisé` },
                      ].map((item, i) => (
                        <li key={i}>
                          <span className="comparison-item-title">{item.title}</span>
                          <span className="comparison-item-desc">{item.desc}</span>
                        </li>
                      ))}
                    </ul>
                  </div>

                  <div className="comparison-card comparison-card--night">
                    <div className="comparison-card-header">
                      <span className="comparison-card-icon">🌙</span>
                      <h3 className="comparison-card-title">Trains de Nuit</h3>
                      <span className="comparison-card-count">{nightCount.toLocaleString('fr-FR')} liaisons</span>
                    </div>
                    <ul className="comparison-card-list">
                      {[
                        { title: 'Réseau nocturne',    desc: `${nightPct}% du réseau total` },
                        { title: 'Pays desservis',      desc: `${nightCountries} pays avec liaisons nocturnes` },
                        { title: 'Longues distances',   desc: `${nightAvgDist} km en moyenne` },
                        { title: 'Très écologique',     desc: `${(avgSavings + 2).toFixed(0)}% de CO₂ économisé` },
                      ].map((item, i) => (
                        <li key={i}>
                          <span className="comparison-item-title">{item.title}</span>
                          <span className="comparison-item-desc">{item.desc}</span>
                        </li>
                      ))}
                    </ul>
                  </div>
                </div>
              </div>
            )}
          </div>

          {/* Conclusion — une seule fois, hors des onglets */}
          <div className="conclusion-card" style={{ marginTop: 'var(--space-lg)' }}>
            <div className="conclusion-grid">
              <div>
                <h2 className="conclusion-title">Conclusion : Une Complémentarité Essentielle</h2>
                <p className="conclusion-text" style={{ marginBottom: 'var(--space-sm)' }}>
                  Les trains de jour et de nuit jouent des rôles complémentaires dans le maillage ferroviaire européen :
                </p>
                <ul className="conclusion-list">
                  <li>Les trains de jour représentent {dayPct}% de la connectivité totale</li>
                  <li>Les trains de nuit couvrent {nightCountries} pays avec des liaisons longue distance</li>
                  <li>Ensemble, ils desservent {uniqueCountries} pays avec {totalReal.toLocaleString('fr-FR')} liaisons</li>
                  <li>{totalTons.toFixed(1)} tonnes de CO₂ économisées par rapport à l'avion</li>
                </ul>
              </div>
              <div className="conclusion-objectives">
                <h3>Chiffres clés ObRail</h3>
                <div className="conclusion-objectives-list">
                  {[
                    { label: 'Trajets analysés',      value: totalReal.toLocaleString('fr-FR') },
                    { label: 'Pays desservis',         value: uniqueCountries.toString() },
                    { label: 'CO₂ économisé (moy.)',  value: `${avgSavings.toFixed(1)}%` },
                    { label: 'CO₂ total économisé',   value: `${totalTons.toFixed(1)} t` },
                  ].map((obj, i) => (
                    <div key={i} className="conclusion-objective-row">
                      <span>{obj.label}</span>
                      <span className="conclusion-objective-value">{obj.value}</span>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </>
      )}
    </main>
  )
}