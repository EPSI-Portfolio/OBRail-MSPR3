import { useState } from 'react'
import type { TrajetFilters } from '../../types/trajet'
import { OPERATORS } from '../../utils/constants'

interface Props {
  onFilter: (filters: Partial<TrajetFilters>) => void
}

export default function TrajetFilter({ onFilter }: Props) {
  const [search, setSearch] = useState('')
  const [serviceType, setServiceType] = useState<'' | 'day' | 'night'>('')
  const [operator, setOperator] = useState('')

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    onFilter({
      origin: search || undefined,
      service_type: serviceType || undefined,
      operator: operator || undefined,
    })
  }

  return (
    <form
      className="filters-form"
      onSubmit={handleSubmit}
      role="search"
      aria-label="Filtrer les trajets"
      id="filters-form"
    >
      <div className="filter-group">
        <label htmlFor="search-input">Ville de départ</label>
        <input
          id="search-input"
          type="search"
          placeholder="Ex : Paris, Berlin…"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          aria-label="Rechercher par ville d'origine"
        />
      </div>

      <div className="filter-group">
        <label htmlFor="service-type-filter">Type de train</label>
        <select
          id="service-type-filter"
          value={serviceType}
          onChange={(e) => setServiceType(e.target.value as '' | 'day' | 'night')}
          aria-label="Filtrer par type de service"
        >
          <option value="">Tous</option>
          <option value="day">☀️ Trains de jour</option>
          <option value="night">🌙 Trains de nuit</option>
        </select>
      </div>

      <div className="filter-group">
        <label htmlFor="operator-filter">Opérateur</label>
        <select
          id="operator-filter"
          value={operator}
          onChange={(e) => setOperator(e.target.value)}
          aria-label="Filtrer par opérateur"
        >
          <option value="">Tous</option>
          {OPERATORS.map((op) => (
            <option key={op} value={op}>{op}</option>
          ))}
        </select>
      </div>

      <button type="submit" id="search-btn" className="btn-primary">
        Rechercher
      </button>
    </form>
  )
}