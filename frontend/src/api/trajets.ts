// src/api/trajets.ts
import client from './client'
import type { Trajet, TrajetFilters } from '../types/trajet'
import type { PaginatedTrajets } from '../types/api'

/**
 * GET /api/v1/trajets
 * Liste paginée avec filtres optionnels.
 */
export async function getTrajets(filters: TrajetFilters = {}): Promise<PaginatedTrajets> {
  const { data } = await client.get<PaginatedTrajets>('/trajets', { params: filters })
  return data
}

/**
 * GET /api/v1/trajets/{id}
 * Détails complets d'un trajet.
 */
export async function getTrajetById(id: number | string): Promise<Trajet> {
  const { data } = await client.get<Trajet>(`/trajets/${id}`)
  return data
}