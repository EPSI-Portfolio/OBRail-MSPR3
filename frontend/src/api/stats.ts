// src/api/stats.ts
import client from './client'
import type { StatsVolumesResponse } from '../types/stats'

/**
 * GET /api/v1/stats/volumes
 * Volumes par pays et type de service.
 */
export async function getStats(): Promise<StatsVolumesResponse> {
  const { data } = await client.get<StatsVolumesResponse>('/stats/volumes')
  return data
}