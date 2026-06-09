import { useState, useEffect, useCallback } from 'react'
import { getTrajets, getTrajetById } from '../api/trajets'
import type { TrajetFilters, Trajet } from '../types/trajet'
import type { PaginatedTrajets, ApiState } from '../types/api'
import { DEFAULT_PAGE_LIMIT } from '../utils/constants'

export function useTrajets(initialFilters: TrajetFilters = {}) {
  const [state, setState] = useState<ApiState<PaginatedTrajets>>({
    data: null,
    isLoading: true,
    error: null,
  })
  const [filters, setFilters] = useState<TrajetFilters>({
    limit: DEFAULT_PAGE_LIMIT,
    offset: 0,
    ...initialFilters,
  })

  const fetchTrajets = useCallback(async () => {
    setState((prev) => ({ ...prev, isLoading: true, error: null }))
    try {
      const data = await getTrajets(filters)
      setState({ data, isLoading: false, error: null })
    } catch (err) {
      setState({
        data: null,
        isLoading: false,
        error: err instanceof Error ? err.message : 'Erreur inconnue',
      })
    }
  }, [filters])

  useEffect(() => {
    // eslint-disable-next-line react-hooks/set-state-in-effect
    fetchTrajets()
  }, [fetchTrajets])

  const updateFilters = (newFilters: Partial<TrajetFilters>) => {
    setFilters((prev) => ({ ...prev, ...newFilters, offset: 0 }))
  }

  const goToPage = (offset: number) => {
    setFilters((prev) => ({ ...prev, offset }))
  }

  return {
    ...state,
    filters,
    updateFilters,
    goToPage,
    refetch: fetchTrajets,
  }
}

export function useTrajetDetail(id: string | undefined) {
  const [state, setState] = useState<ApiState<Trajet>>({
    data: null,
    isLoading: true,
    error: null,
  })

  useEffect(() => {
    if (!id) return
    // eslint-disable-next-line react-hooks/set-state-in-effect
    setState({ data: null, isLoading: true, error: null })
    getTrajetById(id)
      .then((data) => setState({ data, isLoading: false, error: null }))
      .catch((err) =>
        setState({
          data: null,
          isLoading: false,
          error: err instanceof Error ? err.message : 'Trajet introuvable',
        })
      )
  }, [id])

  return state
}