import type { TrajetSummary } from '../../types/trajet'
import TrajetCard from './TrajetCard'

interface Props {
  trajets: TrajetSummary[]
  total: number
}

export default function TrajetList({ trajets, total }: Props) {
  if (trajets.length === 0) {
    return (
      <p id="no-results" className="no-results" role="status">
        Aucun trajet trouvé pour ces critères.
      </p>
    )
  }

  return (
    <>
      <p className="results-count" aria-live="polite" id="results-count">
        {total} trajet{total > 1 ? 's' : ''} trouvé{total > 1 ? 's' : ''}
      </p>
      <div
        className="trajets-grid"
        id="trajets-list"
        aria-label="Liste des trajets"
      >
        {trajets.map((trajet) => (
          <TrajetCard key={trajet.route_id} trajet={trajet} />
        ))}
      </div>
    </>
  )
}