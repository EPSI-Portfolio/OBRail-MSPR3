export default function Footer() {
  return (
    <footer className="footer" role="contentinfo">
      <p>
        © {new Date().getFullYear()} ObRail Europe — Observatoire indépendant des dessertes ferroviaires
      </p>
      <p className="footer-sub">
        Données open data • Conformité RGPD • Accessibilité RGAA
      </p>
    </footer>
  )
}