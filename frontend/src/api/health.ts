// src/api/health.ts

import axios from 'axios'
import { GRAFANA_URL } from '../utils/constants'

// Note : /health est à la racine, pas sous /api/v1
const HEALTH_URL = import.meta.env.VITE_API_URL
  ? import.meta.env.VITE_API_URL.replace('/api/v1', '/health')
  : 'http://localhost:8002/health'

/**
 * GET /health
 * Retourne le statut de l'API et de la base de données.
 */
export async function getHealth(): Promise<string> {
  const { data } = await axios.get<string>(HEALTH_URL, { timeout: 5_000 })
  return data
}

export { GRAFANA_URL }