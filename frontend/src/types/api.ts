// Un enregistrement de stats — réponse de GET /api/v1/stats/volumes
export interface StatsVolumeItem {
  origin_country: string
  service_type: 'day' | 'night'
  route_count: number
  avg_distance_km: number
}

// Réponse complète de GET /api/v1/stats/volumes
export interface StatsVolumesResponse {
  total: number
  data: StatsVolumeItem[]
}

// Données formatées pour les graphiques Recharts
export interface BarChartEntry {
  country: string
  day: number
  night: number
}

export interface PieChartEntry {
  name: string
  value: number
}