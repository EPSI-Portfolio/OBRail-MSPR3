import client from './client'
import { GRAFANA_URL } from '../utils/constants'

/**
 * GET /api/v1/health
 * Retourne le statut de l'API et de la base de données.
 */
export async function getHealth(): Promise<string> {
  const { data } = await client.get<string>('/health', { timeout: 5_000 })
  return data
}

export { GRAFANA_URL }