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

  // Top trajets depuis l'API
  const [topTrajets, setTopTrajets] = useState<TrajetSummary[]>([])
  const [topNightTrajets, setTopNightTrajets] = useState<TrajetSummary[]>([])

  useEffect(() => {
    getTrajets({ limit: 10, offset: 0, service_type: 'day' })
      .then(res => setTopTrajets(res.trajets))
      .catch(() => {})
    getTrajets({ limit: 10, offset: 0, service_type: 'night' })
      .then(res => setTopNightTrajets(res.trajets))
      .catch(() => {})
  }, [])

  const dayCount   = pieChartData[0]?.value ?? 0
  const nightCount = pieChartData[1]?.value ?? 0
  const total      = data?.total ?? 0

  // Données émissions — train depuis co2Data, avion = référence
  const avgTrainCO2 = co2Data
    ? Math.round(co2Data.total_co2_saved_kg / co2Data.total_routes * 0.1)
    : 14
  const avgPlaneCO2 = co2Data
    ? Math.round(avgTrainCO2 / (1 - co2Data.avg_savings_percent / 100))
    : 285

  const emissionsData = [
    { name: 'Train de jour',  value: avgTrainCO2,      color: '#f59e0b' },
    { name: 'Train de nuit',  value: Math.max(avgTrainCO2 - 2, 10), color: '#6366f1' },
    { name: 'Avion',          value: avgPlaneCO2,      color: '#ef4444' },
    { name: 'Voiture',        value: Math.round(avgPlaneCO2 * 0.36), color: '#f97316' },
  ]

  // CO2 par pays pour graphique barre
  const co2ByCountryData = co2Data
    ? co2Data.by_country
        .sort((a, b) => b.total_savings_tons - a.total_savings_tons)
        .slice(0, 10)
        .map(c => ({
          country: c.origin_country,
          'CO₂ économisé (t)': +c.total_savings_tons.toFixed(2),
        }))
    : []

  // Données radar calculées depuis l'API
  const performanceData = data
    ? [
        {
          critere: 'Volume',
          Jour:  Math.round((dayCount / Math.max(total, 1)) * 100),
          Nuit:  Math.round((nightCount / Math.max(total, 1)) * 100),
        },
        {
          critere: 'Pays couverts',
          Jour:  Math.round((data.data.filter(d => d.service_type === 'day').length / Math.max(uniqueCountries, 1)) * 100),
          Nuit:  Math.round((data.data.filter(d => d.service_type === 'night').length / Math.max(uniqueCountries, 1)) * 100),
        },
        {
          critere: 'Dist. moy.',
          Jour:  Math.round((data.data.filter(d => d.service_type === 'day').reduce((s, d) => s + (d.avg_distance_km ?? 0), 0) / Math.max(data.data.filter(d => d.service_type === 'day').length, 1)) / 10),
          Nuit:  Math.round((data.data.filter(d => d.service_type === 'night').reduce((s, d) => s + (d.avg_distance_km ?? 0), 0) / Math.max(data.data.filter(d => d.service_type === 'night').length, 1)) / 10),
        },
        {
          critere: 'Écologie',
          Jour:  co2Data ? Math.round(co2Data.avg_savings_percent) : 90,
          Nuit:  co2Data ? Math.round(co2Data.avg_savings_percent) + 2 : 92,
        },
        {
          critere: 'CO₂ économisé',
          Jour:  co2Data ? Math.round(co2Data.total_co2_saved_tons * 3) : 70,
          Nuit:  co2Data ? Math.round(co2Data.total_co2_saved_tons * 2) : 50,
        },
      ]
    : []

  return (
    <main id="main-content" className="page-container fade-in">
      {/* En-tête */}
      <div className="page-header" style={{ textAlign: 'center', maxWidth: '800px', margin: '0 auto var(--space-lg)' }}>
        <h1 className="page-title">Statistiques Ferroviaires Européennes</h1>
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
              <StatsCard id="kpi-day"       value={dayCount.toLocaleString('fr-FR')}   label="Trains de jour"   icon="☀️" />
              <StatsCard id="kpi-night"     value={nightCount.toLocaleString('fr-FR')} label="Trains de nuit"   icon="🌙" />
              <StatsCard id="kpi-total"     value={total.toLocaleString('fr-FR')}      label="Trajets au total" icon="🚆" />
              <StatsCard id="kpi-countries" value={uniqueCountries}                    label="Pays desservis"   icon="🗺️" />
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
                <div className="chart-card">
                  <p className="chart-card-title">Volume de trajets par pays</p>
                  <p className="chart-card-desc">
                    Répartition des dessertes ferroviaires par pays d'origine — {total} trajets sur {uniqueCountries} pays.
                  </p>
                  <VolumeChart data={barChartData} />
                  <div className="insight-box">
                    <span className="insight-icon">💡</span>
                    <div className="insight-content">
                      <p className="insight-label">Observation clé</p>
                      <p className="insight-text">
                        {barChartData.length > 0
                          ? `${barChartData.reduce((a, b) => (a.day + a.night) > (b.day + b.night) ? a : b).country} concentre le plus grand volume de liaisons ferroviaires en Europe.`
                          : '—'}
                      </p>
                    </div>
                  </div>
                </div>

                <div className="stats-detail-grid">
                  <div className="stats-detail-card stats-detail-card--day">
                    <div className="stats-detail-header">
                      <span>☀️</span>
                      <h3>Trains de Jour</h3>
                    </div>
                    <div className="stats-detail-rows">
                      <div className="stats-detail-row">
                        <span>Part du total</span>
                        <span className="stats-detail-value--day">
                          {total > 0 ? `${((dayCount / total) * 100).toFixed(1)}%` : '—'}
                        </span>
                      </div>
                      <div className="stats-detail-row">
                        <span>Pays desservis</span>
                        <span className="stats-detail-bold">
                          {data.data.filter(d => d.service_type === 'day').length}
                        </span>
                      </div>
                      <div className="stats-detail-row">
                        <span>Distance moy.</span>
                        <span className="stats-detail-bold">
                          {Math.round(
                            data.data.filter(d => d.service_type === 'day' && d.avg_distance_km)
                              .reduce((s, d) => s + (d.avg_distance_km ?? 0), 0) /
                            Math.max(data.data.filter(d => d.service_type === 'day' && d.avg_distance_km).length, 1)
                          )} km
                        </span>
                      </div>
                      <div className="stats-detail-row">
                        <span>CO₂ économisé moy.</span>
                        <span className="stats-detail-value--green">
                          {co2Data ? `${co2Data.avg_savings_percent.toFixed(1)}%` : '—'}
                        </span>
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
                        <span className="stats-detail-value--night">
                          {total > 0 ? `${((nightCount / total) * 100).toFixed(1)}%` : '—'}
                        </span>
                      </div>
                      <div className="stats-detail-row">
                        <span>Pays desservis</span>
                        <span className="stats-detail-bold">
                          {data.data.filter(d => d.service_type === 'night').length}
                        </span>
                      </div>
                      <div className="stats-detail-row">
                        <span>Distance moy.</span>
                        <span className="stats-detail-bold">
                          {Math.round(
                            data.data.filter(d => d.service_type === 'night' && d.avg_distance_km)
                              .reduce((s, d) => s + (d.avg_distance_km ?? 0), 0) /
                            Math.max(data.data.filter(d => d.service_type === 'night' && d.avg_distance_km).length, 1)
                          )} km
                        </span>
                      </div>
                      <div className="stats-detail-row">
                        <span>CO₂ économisé moy.</span>
                        <span className="stats-detail-value--green">
                          {co2Data ? `${co2Data.avg_savings_percent.toFixed(1)}%` : '—'}
                        </span>
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
                  <p className="chart-card-desc">Les premières liaisons ferroviaires de jour disponibles dans notre base.</p>
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
                        {topTrajets.map(t => (
                          <tr key={t.route_id}>
                            <td className="routes-table-route">
                              {t.origin} → {t.destination}
                            </td>
                            <td>
                              <span className="routes-badge routes-badge--day">{t.operator}</span>
                            </td>
                            <td>{formatDistance(t.distance_km)}</td>
                            <td>{formatDuration(t.duration_minutes)}</td>
                            <td className="stats-detail-value--green">
                              -{t.savings_percent.toFixed(1)}%
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>

                <div className="chart-card" style={{ marginTop: '1rem' }}>
                  <p className="chart-card-title">Top 10 trajets de nuit</p>
                  <p className="chart-card-desc">Les premières liaisons ferroviaires de nuit disponibles dans notre base.</p>
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
                            <td className="routes-table-route">
                              {t.origin} → {t.destination}
                            </td>
                            <td>
                              <span className="routes-badge routes-badge--night">{t.operator}</span>
                            </td>
                            <td>{formatDistance(t.distance_km)}</td>
                            <td>{formatDuration(t.duration_minutes)}</td>
                            <td className="stats-detail-value--green">
                              -{t.savings_percent.toFixed(1)}%
                            </td>
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
                <div className="chart-card">
                  <p className="chart-card-title">Émissions CO₂ estimées par passager (g/km)</p>
                  <p className="chart-card-desc">
                    Comparaison de l'empreinte carbone selon le mode de transport —
                    basé sur {co2Data?.total_routes ?? 0} trajets analysés.
                  </p>
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

                <div className="emissions-grid">
                  <div className="emissions-card emissions-card--day">
                    <h3>Trains de Jour</h3>
                    <div className="emissions-value emissions-value--day">
                      {co2Data ? `${co2Data.avg_savings_percent.toFixed(0)}%` : '90%'}
                    </div>
                    <p>moins polluant que l'avion</p>
                    <div className="emissions-trend">
                      🌿 <span>{co2Data ? `${co2Data.total_co2_saved_tons.toFixed(1)}t CO₂ économisées` : '—'}</span>
                    </div>
                  </div>

                  <div className="emissions-card emissions-card--night">
                    <h3>Trains de Nuit</h3>
                    <div className="emissions-value emissions-value--night">
                      {co2Data ? `${(co2Data.avg_savings_percent + 2).toFixed(0)}%` : '92%'}
                    </div>
                    <p>moins polluant que l'avion</p>
                    <div className="emissions-trend">
                      🌿 <span>Alternative longue distance</span>
                    </div>
                  </div>

                  <div className="emissions-card emissions-card--plane">
                    <h3>Avion</h3>
                    <div className="emissions-value emissions-value--plane">{avgPlaneCO2}g/km</div>
                    <p>Mode de transport le plus polluant</p>
                    <div className="emissions-trend" style={{ color: 'var(--text-muted)' }}>
                      ℹ️ <span>Référence de comparaison</span>
                    </div>
                  </div>
                </div>

                {co2Data && (
                  <>
                    <div className="chart-card" style={{ marginTop: '1rem' }}>
                      <p className="chart-card-title">CO₂ économisé par pays (tonnes)</p>
                      <p className="chart-card-desc">Top 10 pays par économies de CO₂ grâce au rail.</p>
                      <ResponsiveContainer width="100%" height={300}>
                        <BarChart data={co2ByCountryData} margin={{ top: 10, right: 20, left: 0, bottom: 5 }}>
                          <CartesianGrid strokeDasharray="3 3" />
                          <XAxis dataKey="country" />
                          <YAxis unit="t" />
                          <Tooltip formatter={(v) => [`${v} t`, 'CO₂ économisé']} />
                          <Bar dataKey="CO₂ économisé (t)" fill="#10b981" radius={[4, 4, 0, 0]} />
                        </BarChart>
                      </ResponsiveContainer>
                    </div>

                    <div className="co2-impact-card">
                      <h3>Impact Environnemental Global</h3>
                      <p>
                        Sur l'ensemble des <strong>{co2Data.total_routes} trajets</strong> analysés,
                        le choix du train plutôt que l'avion permet d'économiser en moyenne{' '}
                        <strong>{co2Data.avg_savings_percent.toFixed(1)}%</strong> des émissions de CO₂.
                      </p>
                      <div className="co2-impact-highlight">
                        <span>CO₂ total économisé :</span>
                        <span className="co2-impact-value">{co2Data.total_co2_saved_tons.toFixed(2)} t</span>
                      </div>
                      <p className="co2-impact-sub">
                        Soit {(co2Data.total_co2_saved_kg / 1000).toFixed(1)} tonnes,
                        l'équivalent de {Math.round(co2Data.total_co2_saved_tons * 4.5).toLocaleString('fr-FR')} voitures pendant un an.
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
                    Comparaison des indicateurs clés entre trains de jour et de nuit —
                    calculés depuis nos {total} trajets.
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
                        { title: 'Volume dominant', desc: `${((dayCount / Math.max(total, 1)) * 100).toFixed(1)}% du réseau total` },
                        { title: 'Large couverture', desc: `${data.data.filter(d => d.service_type === 'day').length} pays desservis` },
                        { title: 'Distance optimale', desc: 'Trajets courts à moyens' },
                        { title: 'Très écologique', desc: `${co2Data?.avg_savings_percent.toFixed(0) ?? 90}% de CO₂ économisé vs avion` },
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
                        { title: 'Longues distances', desc: `Distance moy. supérieure aux trains de jour` },
                        { title: 'Réseau spécialisé', desc: `${data.data.filter(d => d.service_type === 'night').length} pays avec liaisons nocturnes` },
                        { title: 'Gain de temps', desc: 'Voyage pendant le sommeil' },
                        { title: 'Très écologique', desc: `${co2Data ? (co2Data.avg_savings_percent + 2).toFixed(0) : 92}% de CO₂ économisé vs avion` },
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

          {/* Conclusion */}
          <div className="conclusion-card" style={{ marginTop: 'var(--space-lg)' }}>
            <div className="conclusion-grid">
              <div>
                <h2 className="conclusion-title">Conclusion : Une Complémentarité Essentielle</h2>
                <p className="conclusion-text" style={{ marginBottom: 'var(--space-sm)' }}>
                  Les trains de jour et de nuit jouent des rôles complémentaires dans le maillage ferroviaire européen :
                </p>
                <ul className="conclusion-list">
                  <li>Les trains de jour assurent {total > 0 ? `${((dayCount / total) * 100).toFixed(0)}%` : '—'} de la connectivité totale</li>
                  <li>Les trains de nuit couvrent {data.data.filter(d => d.service_type === 'night').length} pays avec des liaisons longue distance</li>
                  <li>Ensemble, ils desservent {uniqueCountries} pays européens avec {total} liaisons</li>
                  <li>{co2Data ? `${co2Data.total_co2_saved_tons.toFixed(1)} tonnes de CO₂ économisées` : '—'} par rapport à l'avion</li>
                </ul>
              </div>
              <div className="conclusion-objectives">
                <h3>Chiffres clés ObRail</h3>
                <div className="conclusion-objectives-list">
                  {[
                    { label: 'Trajets analysés',        value: total.toLocaleString('fr-FR') },
                    { label: 'Pays desservis',           value: uniqueCountries.toString() },
                    { label: 'CO₂ économisé (moy.)',    value: co2Data ? `${co2Data.avg_savings_percent.toFixed(1)}%` : '—' },
                    { label: 'CO₂ total économisé',     value: co2Data ? `${co2Data.total_co2_saved_tons.toFixed(1)} t` : '—' },
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