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

export interface CO2ByCountry {
  origin_country: string
  route_count: number
  total_savings_kg: number
  avg_savings_per_route_kg: number
  total_savings_tons: number
}

export interface StatsCO2Response {
  total_routes: number
  total_co2_saved_kg: number
  total_co2_saved_tons: number
  avg_savings_percent: number
  by_country: CO2ByCountry[]
}