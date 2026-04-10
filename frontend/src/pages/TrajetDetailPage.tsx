import { useParams, useNavigate } from 'react-router-dom'
import { useTrajetDetail } from '../hooks/useTrajets'
import TrajetDetail from '../components/trajets/TrajetDetail'
import LoadingSpinner from '../components/common/LoadingSpinner'
import ErrorMessage from '../components/common/ErrorMessage'

export default function TrajetDetailPage() {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()
  const { data, isLoading, error } = useTrajetDetail(id)

  return (
    <main id="main-content" className="page-container">
      <button
        id="back-btn"
        className="btn-back"
        onClick={() => navigate('/trajets')}
        aria-label="Retour à la liste des trajets"
      >
        ← Retour à la liste
      </button>

      {isLoading && <LoadingSpinner message="Chargement du trajet..." />}
      {error && <ErrorMessage message={error} />}
      {!isLoading && !error && data && <TrajetDetail trajet={data} />}
    </main>
  )
}