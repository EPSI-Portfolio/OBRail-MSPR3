import { useTrajets } from '../hooks/useTrajets'
import TrajetFilter from '../components/trajets/TrajetFilter'
import TrajetList from '../components/trajets/TrajetList'
import Pagination from '../components/common/Pagination'
import LoadingSpinner from '../components/common/LoadingSpinner'
import ErrorMessage from '../components/common/ErrorMessage'
import { DEFAULT_PAGE_LIMIT } from '../utils/constants'

export default function TrajetsPage() {
  const { data, isLoading, error, filters, updateFilters, goToPage } = useTrajets()

  return (
    <main id="main-content" className="page-container fade-in">
      <div className="page-header">
        <h1 className="page-title">Trajets Ferroviaires Européens</h1>
        <p className="page-subtitle">
          Analyse comparative des liaisons transfrontalières et de leur impact environnemental.
          Comparez les émissions CO₂ train vs avion sur {data?.total ?? '—'} trajets.
        </p>
      </div>

      <TrajetFilter onFilter={updateFilters} />

      {isLoading && <LoadingSpinner message="Chargement des trajets..." />}
      {error && <ErrorMessage message={error} />}

      {!isLoading && !error && data && (
        <>
          <TrajetList trajets={data.trajets} total={data.total} />
          <Pagination
            total={data.total}
            limit={filters.limit ?? DEFAULT_PAGE_LIMIT}
            offset={filters.offset ?? 0}
            onPageChange={goToPage}
          />
        </>
      )}
    </main>
  )
}