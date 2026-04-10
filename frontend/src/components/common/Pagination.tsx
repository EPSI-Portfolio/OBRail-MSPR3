interface Props {
  total: number
  limit: number
  offset: number
  onPageChange: (offset: number) => void
}

export default function Pagination({ total, limit, offset, onPageChange }: Props) {
  const totalPages = Math.ceil(total / limit)
  const currentPage = Math.floor(offset / limit) + 1

  if (totalPages <= 1) return null

  return (
    <nav
      className="pagination"
      aria-label="Pagination des résultats"
      id="pagination"
    >
      <button
        id="prev-page-btn"
        className="btn-page"
        onClick={() => onPageChange(Math.max(0, offset - limit))}
        disabled={offset === 0}
        aria-label="Page précédente"
      >
        ← Précédent
      </button>

      <span aria-current="page" id="current-page">
        Page {currentPage} / {totalPages}
      </span>

      <button
        id="next-page-btn"
        className="btn-page"
        onClick={() => onPageChange(offset + limit)}
        disabled={offset + limit >= total}
        aria-label="Page suivante"
      >
        Suivant →
      </button>
    </nav>
  )
}