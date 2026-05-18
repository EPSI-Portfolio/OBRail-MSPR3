import { NavLink } from 'react-router-dom'
import { useEffect, useState } from 'react'
import ServiceIndicator from '../monitoring/ServiceIndicator'

export default function Navbar() {
  const [theme, setTheme] = useState<'light' | 'dark'>(() => {
    return (localStorage.getItem('theme') as 'light' | 'dark') || 'light'
  })

  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme)
    localStorage.setItem('theme', theme)
  }, [theme])

  const toggleTheme = () => setTheme(t => t === 'light' ? 'dark' : 'light')

  return (
    <nav className="navbar" role="navigation" aria-label="Navigation principale">
      <div className="navbar-brand">
        <span aria-hidden="true">🚆</span>
        <span className="navbar-title">ObRail Europe</span>
      </div>

      <ul className="navbar-links" role="list">
        <li>
          <NavLink to="/trajets" id="nav-trajets"
            className={({ isActive }) => `nav-link${isActive ? ' active' : ''}`}>
            Trajets
          </NavLink>
        </li>
        <li>
          <NavLink to="/stats" id="nav-stats"
            className={({ isActive }) => `nav-link${isActive ? ' active' : ''}`}>
            Statistiques
          </NavLink>
        </li>
        <li>
          <NavLink to="/health" id="nav-health"
            className={({ isActive }) => `nav-link${isActive ? ' active' : ''}`}>
            État du service
          </NavLink>
        </li>
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