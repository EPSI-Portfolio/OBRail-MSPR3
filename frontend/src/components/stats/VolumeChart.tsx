import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid,
  Tooltip, Legend, ResponsiveContainer
} from 'recharts'
import type { BarChartEntry } from '../../types/stats'
import { CHART_COLORS } from '../../utils/constants'

interface Props {
  data: BarChartEntry[]
}

export default function VolumeChart({ data }: Props) {
  return (
    <div id="bar-chart" aria-label="Graphique en barres : volume de trajets par pays">
      <ResponsiveContainer width="100%" height={320}>
        <BarChart data={data} margin={{ top: 10, right: 20, left: 0, bottom: 5 }}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="country" />
          <YAxis allowDecimals={false} />
          <Tooltip
            formatter={(value, name) => [
              value,
              name === 'day' ? 'Trains de jour' : 'Trains de nuit',
            ]}
          />
          <Legend
            formatter={(value) => value === 'day' ? '☀️ Jour' : '🌙 Nuit'}
          />
          <Bar dataKey="day" name="day" fill={CHART_COLORS.day} />
          <Bar dataKey="night" name="night" fill={CHART_COLORS.night} />
        </BarChart>
      </ResponsiveContainer>
    </div>
  )
}