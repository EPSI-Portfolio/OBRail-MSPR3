/**
 * Formate une durée en minutes → "3h 45min" ou "45min"
 */
export function formatDuration(minutes: number): string {
  if (!minutes || minutes <= 0) return '—'
  const h = Math.floor(minutes / 60)
  const m = minutes % 60
  if (h === 0) return `${m}min`
  if (m === 0) return `${h}h`
  return `${h}h ${m}min`
}

/**
 * Formate un nombre de km → "1 234 km"
 */
export function formatDistance(km: number): string {
  return `${km.toLocaleString('fr-FR')} km`
}

/**
 * Formate un poids CO2 en kg → "12,5 kg" ou "1,2 t" si > 1000
 */
export function formatCO2(kg: number): string {
  if (kg >= 1000) return `${(kg / 1000).toFixed(1)} t`
  return `${kg.toFixed(1)} kg`
}

/**
 * Formate un pourcentage → "87%"
 */
export function formatPercent(value: number): string {
  return `${Math.round(value)}%`
}

/**
 * Formate une date ISO → "8 avril 2026"
 */
export function formatDate(isoDate: string): string {
  if (!isoDate) return '—'
  return new Date(isoDate).toLocaleDateString('fr-FR', {
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  })
}

/**
 * Retourne le label lisible du type de service
 */
export function formatServiceType(type: 'day' | 'night'): string {
  return type === 'night' ? '🌙 Train de nuit' : '☀️ Train de jour'
}