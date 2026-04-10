interface Props {
  message?: string
}

export default function LoadingSpinner({ message = 'Chargement...' }: Props) {
  return (
    <div
      className="loader-wrapper"
      role="status"
      aria-live="polite"
      aria-label={message}
      id="loader"
    >
      <div className="loader-spinner" aria-hidden="true" />
      <p className="loader-text">{message}</p>
    </div>
  )
}