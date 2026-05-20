// Trajet complet — réponse de GET /api/v1/trajets/{id}
export interface Trajet {
  route_id: number
  route_name: string
  route_name_simple: string
  origin: string
  destination: string
  origin_country: string
  destination_country: string
  distance_km: number
  service_type: 'day' | 'night'
  train_type: string
  operator: string
  train_gco2_pkm: number
  plane_gco2_pkm: number
  train_co2_kg: number
  plane_co2_kg: number
  co2_savings_kg: number
  savings_percent: number
  emission_source: string
  calculation_date: string
  duration_minutes: number
}

// Trajet résumé — dans la liste GET /api/v1/trajets
export interface TrajetSummary {
  route_id: number
  route_name_simple: string
  origin: string
  destination: string
  origin_country: string
  destination_country: string
  distance_km: number
  service_type: 'day' | 'night'
  operator: string
  co2_savings_kg: number
  savings_percent: number
  duration_minutes: number
}

// Filtres disponibles pour GET /api/v1/trajets
export interface TrajetFilters {
  service_type?: 'day' | 'night' | ''
  origin_country?: string
  destination_country?: string
  origin?: string
  destination?: string
  operator?: string
  min_distance?: number
  max_distance?: number
  limit?: number
  offset?: number
}