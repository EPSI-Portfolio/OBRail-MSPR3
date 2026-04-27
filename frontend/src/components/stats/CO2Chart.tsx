import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts'
import type { CO2ByCountry } from '../../types/stats'

interface Props {
  data: CO2ByCountry[]
  totalSavedTons: number
  avgSavingsPercent: number
}

export default function CO2Chart({ data, totalSavedTons, avgSavingsPercent }: Props) {
  return (
    <div id="co2-chart-section">
      {/* KPIs CO2 */}
      <div className="kpi-grid" style={{ marginBottom: '1.5rem' }}>
        <div className="kpi-card" id="kpi-co2-total">
          <span className="kpi-icon" aria-hidden="true">🌿</span>
          <span className="kpi-value">{totalSavedTons.toFixed(1)} t</span>
          <span className="kpi-label">CO₂ économisé au total</span>
        </div>
        <div className="kpi-card" id="kpi-co2-avg">
          <span className="kpi-icon" aria-hidden="true">📉</span>
          <span className="kpi-value">{avgSavingsPercent.toFixed(1)}%</span>
          <span className="kpi-label">Économie moyenne vs avion</span>
        </div>
      </div>

      {/* Graphique CO2 par pays */}
      <div id="co2-chart" aria-label="Graphique CO2 économisé par pays">
        <ResponsiveContainer width="100%" height={320}>
          <BarChart data={data} margin={{ top: 10, right: 20, left: 0, bottom: 5 }}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="origin_country" />
            <YAxis unit=" t" />
            <Tooltip
              formatter={(value, name) => [
                `${value} t`,
                name === 'total_savings_tons' ? 'CO₂ économisé' : String(name),
              ]}
            />
            <Bar dataKey="total_savings_tons" name="total_savings_tons" fill="#16a34a" />
          </BarChart>
        </ResponsiveContainer>
      </div>
    </div>
  )
}