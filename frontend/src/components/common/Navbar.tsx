// Navbar.tsx

import { NavLink } from 'react-router-dom'
import ServiceIndicator from '../monitoring/ServiceIndicator'

export default function Navbar() {
  return (
    <nav className="navbar" role="navigation" aria-label="Navigation principale">
      <div className="navbar-brand">
        <span aria-hidden="true">🚆</span>
        <span className="navbar-title">ObRail Europe</span>
      </div>

      <ul className="navbar-links" role="list">
        <li>
          <NavLink
            to="/trajets"
            id="nav-trajets"
            className={({ isActive }) => `nav-link${isActive ? ' active' : ''}`}
          >
            Trajets
          </NavLink>
        </li>
        <li>
          <NavLink
            to="/stats"
            id="nav-stats"
            className={({ isActive }) => `nav-link${isActive ? ' active' : ''}`}
          >
            Statistiques
          </NavLink>
        </li>
        <li>
          <NavLink
            to="/health"
            id="nav-health"
            className={({ isActive }) => `nav-link${isActive ? ' active' : ''}`}
          >
            État du service
          </NavLink>
        </li>
      </ul>

      {/* Indicateur vert/rouge en temps réel dans la navbar */}
      <ServiceIndicator />
    </nav>
  )
}