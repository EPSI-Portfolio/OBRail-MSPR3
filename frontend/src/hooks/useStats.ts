import { useState, useEffect } from 'react'
import { getStats, getStatsCO2 } from '../api/stats'
import type { StatsVolumesResponse, BarChartEntry, PieChartEntry, StatsCO2Response } from '../types/stats'
import type { ApiState } from '../types/api'
import { CHART_COLORS } from '../utils/constants'

export function useStats() {
  const [state, setState] = useState<ApiState<StatsVolumesResponse>>({
    data: null,
    isLoading: true,
    error: null,
  })
  const [co2Data, setCo2Data] = useState<StatsCO2Response | null>(null)

  const fetchStats = () => {
    setState((prev) => ({ ...prev, isLoading: true, error: null }))
    Promise.all([getStats(), getStatsCO2()])
      .then(([volumes, co2]) => {
        setState({ data: volumes, isLoading: false, error: null })
        setCo2Data(co2)
      })
      .catch((err) =>
        setState({
          data: null,
          isLoading: false,
          error: err instanceof Error ? err.message : 'Erreur statistiques',
        })
      )
  }

  useEffect(() => { fetchStats() }, [])

  const barChartData: BarChartEntry[] = state.data
    ? Object.values(
        state.data.data.reduce<Record<string, BarChartEntry>>((acc, item) => {
          if (!acc[item.origin_country]) {
            acc[item.origin_country] = { country: item.origin_country, day: 0, night: 0 }
          }
          acc[item.origin_country][item.service_type] += item.route_count
          return acc
        }, {})
      )
    : []

  const pieChartData: PieChartEntry[] = state.data
    ? [
        {
          name: 'Trains de jour',
          value: state.data.data
            .filter((d) => d.service_type === 'day')
            .reduce((s, d) => s + d.route_count, 0),
        },
        {
          name: 'Trains de nuit',
          value: state.data.data
            .filter((d) => d.service_type === 'night')
            .reduce((s, d) => s + d.route_count, 0),
        },
      ]
    : []

  const uniqueCountries = state.data
    ? new Set(state.data.data.map((d) => d.origin_country)).size
    : 0

  return {
    ...state,
    barChartData,
    pieChartData,
    uniqueCountries,
    chartColors: CHART_COLORS,
    co2Data,
    refetch: fetchStats,
  }
}