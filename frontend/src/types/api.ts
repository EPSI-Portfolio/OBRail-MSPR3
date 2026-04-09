import type { TrajetSummary } from './trajet'

// Réponse paginée de GET /api/v1/trajets
export interface PaginatedTrajets {
  total: number
  limit: number
  offset: number
  trajets: TrajetSummary[]
}

// État générique d'un appel API dans les hooks
export interface ApiState<T> {
  data: T | null
  isLoading: boolean
  error: string | null
}

// Erreur de validation FastAPI (422)
export interface ValidationError {
  detail: Array<{
    loc: (string | number)[]
    msg: string
    type: string
  }>
}