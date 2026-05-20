import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import Navbar from './components/common/Navbar'
import Footer from './components/common/Footer'
import TrajetsPage from './pages/TrajetsPage'
import TrajetDetailPage from './pages/TrajetDetailPage'
import StatsPage from './pages/StatsPage'
import HealthPage from './pages/HealthPage'
import './styles/globals.css'

export default function App() {
  return (
    <BrowserRouter>
      {/* RGAA : lien d'évitement pour navigation clavier */}
      <a href="#main-content" className="skip-link">
        Aller au contenu principal
      </a>

      <Navbar />

      <Routes>
        <Route path="/" element={<Navigate to="/trajets" replace />} />
        <Route path="/trajets" element={<TrajetsPage />} />
        <Route path="/trajets/:id" element={<TrajetDetailPage />} />
        <Route path="/stats" element={<StatsPage />} />
        <Route path="/health" element={<HealthPage />} />
      </Routes>

      <Footer />
    </BrowserRouter>
  )
}