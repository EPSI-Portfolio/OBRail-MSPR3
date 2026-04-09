// src/api/client.ts
import axios from 'axios'
import { API_BASE_URL } from '../utils/constants'

const client = axios.create({
  baseURL: API_BASE_URL,
  timeout: 10_000,
  headers: { 'Content-Type': 'application/json' },
})

// Intercepteur de réponse — gestion globale des erreurs
client.interceptors.response.use(
  (response) => response,
  (error) => {
    const status = error.response?.status
    const detail = error.response?.data?.detail

    if (status === 404) {
      return Promise.reject(new Error('Ressource introuvable (404)'))
    }
    if (status === 422) {
      const msg = Array.isArray(detail)
        ? detail.map((d: { msg: string }) => d.msg).join(', ')
        : 'Données invalides (422)'
      return Promise.reject(new Error(msg))
    }
    if (status === 500) {
      return Promise.reject(new Error('Erreur serveur interne (500)'))
    }

    return Promise.reject(error)
  }
)

export default client