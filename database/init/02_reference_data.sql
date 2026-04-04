/* =========================================================
   OBRAIL EUROPE - REFERENCE DATA
   ========================================================= */

-- ========================================
-- COUNTRIES
-- ========================================

INSERT INTO dim_countries (country_code, country_name) VALUES
('AT', 'Austria'),
('BE', 'Belgium'),
('BG', 'Bulgaria'),
('CH', 'Switzerland'),
('CZ', 'Czech Republic'),
('DE', 'Germany'),
('DK', 'Denmark'),
('EE', 'Estonia'),
('ES', 'Spain'),
('FI', 'Finland'),
('FR', 'France'),
('GB', 'United Kingdom'),
('GR', 'Greece'),
('HR', 'Croatia'),
('HU', 'Hungary'),
('IT', 'Italy'),
('LI', 'Liechtenstein'),
('LT', 'Lithuania'),
('LU', 'Luxembourg'),
('LV', 'Latvia'),
('MD', 'Moldova'),
('ME', 'Montenegro'),
('NL', 'Netherlands'),
('NO', 'Norway'),
('PL', 'Poland'),
('PT', 'Portugal'),
('RO', 'Romania'),
('RS', 'Serbia'),
('SE', 'Sweden'),
('SI', 'Slovenia'),
('SK', 'Slovakia'),
('TR', 'Turkey'),
('UA', 'Ukraine')
ON CONFLICT (country_code) DO NOTHING;

-- ========================================
-- TRANSPORT MODES
-- ========================================

INSERT INTO dim_transport_modes (mode_name, gco2_per_pkm, source) VALUES
('Night Train',         14,  'Back-on-Track 2022'),
('Day Train',           14,  'Back-on-Track 2022'),
('Airplane',           144,  'Back-on-Track 2022'),
('Airplane (with RF)', 389,  'Back-on-Track 2022 (Radiative Forcing 3.0)'),
('Car (Diesel)',        132,  'Back-on-Track 2022'),
('Coach/Bus',           22,  'Back-on-Track 2022'),
('Electric Car (PV)',   62,  'Back-on-Track 2022'),
('Airplane (SAF)',      20,  'Back-on-Track 2022 (Sustainable Aviation Fuel)')
ON CONFLICT (mode_name) DO NOTHING;

-- ========================================
-- TRAIN TYPES
-- ========================================

INSERT INTO dim_train_types (type_code, type_name) VALUES
('night', 'Night Train'),
('day',   'Day Train')
ON CONFLICT (type_code) DO NOTHING;