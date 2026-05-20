interface Props {
  value: number | string
  label: string
  id: string
  icon?: string
}

export default function StatsCard({ value, label, id, icon }: Props) {
  return (
    <div className="kpi-card" id={id}>
      {icon && <span className="kpi-icon" aria-hidden="true">{icon}</span>}
      <span className="kpi-value">{value}</span>
      <span className="kpi-label">{label}</span>
    </div>
  )
}