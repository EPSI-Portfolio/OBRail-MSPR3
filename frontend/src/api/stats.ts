import client from './client'
import type { StatsVolumesResponse, StatsCO2Response } from '../types/stats'

/**
 * GET /api/v1/stats/volumes
 * Volumes par pays et type de service.
 */
export async function getStats(): Promise<StatsVolumesResponse> {
  const { data } = await client.get<StatsVolumesResponse>('/stats/volumes')
  return data
}

/**
 * GET /api/v1/stats/co2
 * Impact CO2 par pays.
 */
export async function getStatsCO2(): Promise<StatsCO2Response> {
  const { data } = await client.get<StatsCO2Response>('/stats/co2')
  return data
}