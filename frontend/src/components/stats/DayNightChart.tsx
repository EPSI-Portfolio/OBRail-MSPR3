import {
  PieChart, Pie, Cell, Tooltip, Legend, ResponsiveContainer
} from 'recharts'
import type { PieChartEntry } from '../../types/stats'
import { CHART_COLORS } from '../../utils/constants'

interface Props {
  data: PieChartEntry[]
}

const COLORS = [CHART_COLORS.day, CHART_COLORS.night]

export default function DayNightChart({ data }: Props) {
  return (
    <div id="pie-chart" aria-label="Graphique circulaire : répartition trains de jour et de nuit">
      <ResponsiveContainer width="100%" height={280}>
        <PieChart>
          <Pie
            data={data}
            cx="50%"
            cy="50%"
            outerRadius={100}
            dataKey="value"
            label={({ name, percent }: { name?: string; percent?: number }) =>
              `${name ?? ''} — ${((percent ?? 0) * 100).toFixed(0)}%`
            }
          >
            {data.map((_, index) => (
              <Cell key={index} fill={COLORS[index % COLORS.length]} />
            ))}
          </Pie>
          <Tooltip formatter={(value) => [`${value} trajets`, '']} />
          <Legend />
        </PieChart>
      </ResponsiveContainer>
    </div>
  )
}