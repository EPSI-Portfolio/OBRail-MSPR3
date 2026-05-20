import { NavLink } from 'react-router-dom'
import { useEffect, useState } from 'react'
import ServiceIndicator from '../monitoring/ServiceIndicator'

export default function Navbar() {
  const [theme, setTheme] = useState<'light' | 'dark'>(() =>
    (localStorage.getItem('theme') as 'light' | 'dark') || 'light'
  )
  const [menuOpen, setMenuOpen] = useState(false)

  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme)
    localStorage.setItem('theme', theme)
  }, [theme])

  const toggleTheme = () => setTheme(t => t === 'light' ? 'dark' : 'light')
  const toggleMenu = () => setMenuOpen(o => !o)

  return (
    <nav className="navbar" role="navigation" aria-label="Navigation principale">
      <div className="navbar-brand">
        <span aria-hidden="true">🚆</span>
        <span className="navbar-title">ObRail Europe</span>
      </div>

      {/* Hamburger mobile */}
      <button
        className="navbar-hamburger"
        onClick={toggleMenu}
        aria-label={menuOpen ? 'Fermer le menu' : 'Ouvrir le menu'}
        aria-expanded={menuOpen}
      >
        {menuOpen ? '✕' : '☰'}
      </button>

      <ul className={`navbar-links${menuOpen ? ' open' : ''}`} role="list">
        {['trajets', 'stats', 'health'].map((path) => (
          <li key={path}>
            <NavLink
              to={`/${path}`}
              id={`nav-${path}`}
              className={({ isActive }) => `nav-link${isActive ? ' active' : ''}`}
              onClick={() => setMenuOpen(false)}
            >
              {path === 'trajets' ? 'Trajets' : path === 'stats' ? 'Statistiques' : 'État du service'}
            </NavLink>
          </li>
        ))}
      </ul>

      <div className="navbar-right">
        <ServiceIndicator />
        <button
          className="theme-toggle"
          onClick={toggleTheme}
          aria-label={theme === 'light' ? 'Passer en mode sombre' : 'Passer en mode clair'}
          title={theme === 'light' ? 'Mode sombre' : 'Mode clair'}
        >
          {theme === 'light' ? '🌙' : '☀️'}
        </button>
      </div>
    </nav>
  )
}