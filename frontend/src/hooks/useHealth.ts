import { useState, useEffect, useCallback } from 'react'
import { getHealth } from '../api/health'
import { HEALTH_POLL_INTERVAL } from '../utils/constants'

interface HealthState {
  status: string | null
  isOnline: boolean
  isLoading: boolean
  lastChecked: string | null
}

export function useHealth() {
  const [state, setState] = useState<HealthState>({
    status: null,
    isOnline: false,
    isLoading: true,
    lastChecked: null,
  })

  const check = useCallback(() => {
    setState((prev) => ({ ...prev, isLoading: true }))
    getHealth()
      .then((status) => {
        setState({
          status: typeof status === 'string' ? status : JSON.stringify(status),
          isOnline: true,
          isLoading: false,
          lastChecked: new Date().toLocaleTimeString('fr-FR'),
        })
      })
      .catch(() => {
        setState({
          status: null,
          isOnline: false,
          isLoading: false,
          lastChecked: new Date().toLocaleTimeString('fr-FR'),
        })
      })
  }, [])

  useEffect(() => {
    check()
    // Polling automatique toutes les 30 secondes
    const interval = setInterval(check, HEALTH_POLL_INTERVAL)
    return () => clearInterval(interval)
  }, [check])

  return { ...state, refetch: check }
}