interface Props {
  message?: string
}

export default function ErrorMessage({ message = 'Une erreur est survenue.' }: Props) {
  return (
    <div
      className="error-wrapper"
      role="alert"
      aria-live="assertive"
      id="error-message"
    >
      <span aria-hidden="true">⚠️</span>
      <p>{message}</p>
    </div>
  )
}