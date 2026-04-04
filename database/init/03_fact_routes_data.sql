--
-- PostgreSQL database dump
--

\restrict eA8GUTsya8ZNOVLyIBejLtTKihBLVap9yycFfTsLfLTavRkYgkd25NkMG4I3CwP

-- Dumped from database version 15.15 (Debian 15.15-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: fact_routes; Type: TABLE DATA; Schema: public; Owner: obrail_user
--

COPY public.fact_routes (route_id, route_name, route_name_simple, origin, destination, origin_country, destination_country, distance_km, service_type, train_type, operator, train_gco2_pkm, plane_gco2_pkm, train_co2_kg, plane_co2_kg, co2_savings_kg, savings_percent, emission_source, calculation_date, created_at, duration_minutes) FROM stdin;
3576	CS 1003 (E) + 1004 (E)	London → Edinburgh	London	Edinburgh	GB	GB	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3495	CS 1001 (A) + 1002 (A)	London → Aberdeen	London	Aberdeen	GB	GB	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3599	CS 1001 (I) + 1002 (I)	London → Inverness	London	Inverness	GB	GB	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3667	VR IC 266 (T) + IC 933	Rovaniemi → Turku	Rovaniemi	Turku	FI	FI	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
165	Amsterdam Centraal → Berlin Ostbahnhof	Amsterdam Centraal → Berlin Ostbahnhof	Amsterdam Centraal	Berlin Ostbahnhof	DE	DE	578.33	night	night	DB	14.00	144.00	8.10	83.28	75.18	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	434
7	Aachen Hbf → Berlin Ostbahnhof	Aachen → Berlin Ostbahnhof	Aachen Hbf	Berlin Ostbahnhof	DE	DE	542.23	night	night	DB	14.00	144.00	7.59	78.08	70.49	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	407
260	INCONNU	Arcachon → Paris Montparnasse Hall 1 2	Arcachon	Paris Montparnasse Hall 1 2	FR	FR	535.39	night	night	Other	14.00	144.00	7.50	77.10	69.60	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	402
434	INCONNU	Barcelone Sants → Paris de Lyon Hall 1 2	Barcelone Sants	Paris Gare De Lyon Hall 1 2	FR	FR	830.38	day	day	Other	14.00	144.00	11.63	119.57	107.94	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	415
316	D9	Augsburg → Dortmund	Augsburg Hauptbahnhof	Dortmund Hauptbahnhof	AT	AT	427.67	night	night	ÖBB	14.00	144.00	5.99	61.58	55.59	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	321
435	INCONNU	Barcelone Sants → Paris Montparnasse Hall 1 2	Barcelone Sants	Paris Montparnasse Hall 1 2	FR	FR	829.88	day	day	Other	14.00	144.00	11.62	119.50	107.88	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	415
641	Berlin-Charlottenburg → Budapest-Keleti	Berlin Charlottenburg → Budapest Keleti	Berlin Charlottenburg	Budapest Keleti	DE	DE	692.62	day	day	Other	14.00	144.00	9.70	99.74	90.04	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	346
642	Berlin-Charlottenburg → Przemysl Gl.	Berlin Charlottenburg → Przemysl Gl	Berlin Charlottenburg	Przemysl Gl	DE	DE	726.08	day	day	Other	14.00	144.00	10.17	104.56	94.39	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	363
646	Berlin Gesundbrunnen → Budapest-Keleti	Berlin Gesundbrunnen → Budapest Keleti	Berlin Gesundbrunnen	Budapest Keleti	DE	DE	692.90	day	day	Other	14.00	144.00	9.70	99.78	90.08	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	346
669	Berlin Gesundbrunnen → Przemysl Gl.	Berlin Gesundbrunnen → Przemysl Gl	Berlin Gesundbrunnen	Przemysl Gl	DE	DE	722.48	day	day	Other	14.00	144.00	10.11	104.04	93.93	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	361
950	INCONNU	Bordeaux Saint Jean → Paris Montparnasse Hall 1 2	Bordeaux Saint Jean	Paris Montparnasse Hall 1 2	FR	FR	497.15	night	night	Other	14.00	144.00	6.96	71.59	64.63	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	373
1261	INCONNU	Cerbere → Paris Austerlitz	Cerbere	Paris Austerlitz	FR	FR	714.39	day	day	Other	14.00	144.00	10.00	102.87	92.87	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	357
1262	INCONNU	Cerbere → Paris Bercy Bourg Pays d Auv	Cerbere	Paris Bercy Bourg Pays D Auv	FR	FR	713.94	day	day	Other	14.00	144.00	10.00	102.81	92.81	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	357
2507	INCONNU	Paris Austerlitz → Latour de Carol Enveitg	Paris Austerlitz	Latour De Carol Enveitg	FR	FR	710.69	night	night	Other	14.00	144.00	9.95	102.34	92.39	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	533
3165	INCONNU	Paris Austerlitz → Tarbes	Paris Austerlitz	Tarbes	FR	FR	647.58	day	day	Other	14.00	144.00	9.07	93.25	84.18	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	324
168	BEBMI -> NLAMA	Bruxelles Midi → Amsterdam Centraal	Bruxelles Midi	Amsterdam Centraal	BE	NL	176.03	night	night	Eurostar	14.00	144.00	2.46	25.35	22.89	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	132
175	FRMLV -> NLAMA	Marne la Vallee Chessy → Amsterdam Centraal	Marne La Vallee Chessy	Amsterdam Centraal	FR	NL	417.72	day	day	Eurostar	14.00	144.00	5.85	60.15	54.30	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	90
177	NLAMA -> FRPNO	Amsterdam Centraal → Paris Nord	Amsterdam Centraal	Paris Nord	NL	FR	428.33	night	night	Eurostar	14.00	144.00	6.00	61.68	55.68	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	321
178	GBSPX -> NLAMA	St Pancras International → Amsterdam Centraal	St Pancras International	Amsterdam Centraal	GB	NL	357.02	day	day	Eurostar	14.00	144.00	5.00	51.41	46.41	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	77
508	ECE 20	Basel Sbb → Hamburg	Basel Sbb	Hamburg Hbf	CH	DE	689.15	day	day	DB	14.00	144.00	9.65	99.24	89.59	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	345
509	Hamburg-Altona → Basel SBB	Hamburg Altona → Basel Sbb	Hamburg Altona	Basel Sbb	DE	DE	687.91	day	day	DB	14.00	144.00	9.63	99.06	89.43	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	344
510	ECE 20	Hamburg Dammtor → Basel Sbb	Hamburg Dammtor	Basel Sbb	DE	CH	689.71	day	day	DB	14.00	144.00	9.66	99.32	89.66	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	345
511	Basel SBB → Hamburg-Harburg	Basel Sbb → Hamburg Harburg	Basel Sbb	Hamburg Harburg	DE	DE	678.50	night	night	DB	14.00	144.00	9.50	97.70	88.20	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	509
512	Hannover Hbf → Basel SBB	Hannover → Basel Sbb	Hannover Hbf	Basel Sbb	DE	DE	558.55	night	night	DB	14.00	144.00	7.82	80.43	72.61	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	419
514	Basel SBB → Kiel Hbf	Basel Sbb → Kiel	Basel Sbb	Kiel Hbf	DE	DE	773.19	night	night	DB	14.00	144.00	10.82	111.34	100.52	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	580
643	Wien Hbf → Berlin-Charlottenburg	Wien → Berlin Charlottenburg	Wien Hbf	Berlin Charlottenburg	DE	DE	527.36	night	night	ÖBB	14.00	144.00	7.38	75.94	68.56	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	396
440	Basel Bad Bf → Berlin Ostbahnhof	Basel Bad → Berlin Ostbahnhof	Basel Bad Bf	Berlin Ostbahnhof	DE	DE	688.94	night	night	DB	14.00	144.00	9.65	99.21	89.56	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	517
451	Basel Bad Bf → Flensburg	Basel Bad → Flensburg	Basel Bad Bf	Flensburg	DE	DE	811.36	night	night	DB	14.00	144.00	11.36	116.84	105.48	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	609
452	ECE 85	Basel Bad → Frankfurt Main	Basel Bad Bf	Frankfurt Main Hbf	CH	DE	292.73	day	day	DB	14.00	144.00	4.10	42.15	38.05	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	146
456	Basel Bad Bf → Hamburg Hbf	Basel Bad → Hamburg	Basel Bad Bf	Hamburg Hbf	DE	DE	686.68	night	night	DB	14.00	144.00	9.61	98.88	89.27	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	515
457	ICE 43	Basel Bad → Hamburg Altona S	Basel Bad Bf	Hamburg Altona S	CH	DE	685.45	day	day	DB	14.00	144.00	9.60	98.70	89.10	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	343
458	ICE 20	Hamburg Dammtor → Basel Bad	Hamburg Dammtor	Basel Bad Bf	DE	DE	687.25	day	day	DB	14.00	144.00	9.62	98.96	89.34	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	344
459	Basel Bad Bf → Hamburg-Harburg	Basel Bad → Hamburg Harburg	Basel Bad Bf	Hamburg Harburg	DE	DE	676.03	night	night	DB	14.00	144.00	9.46	97.35	87.89	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	507
460	Basel Bad Bf → Hannover Hbf	Basel Bad → Hannover	Basel Bad Bf	Hannover Hbf	DE	DE	556.06	night	night	DB	14.00	144.00	7.78	80.07	72.29	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	417
464	Basel Bad Bf → Kiel Hbf	Basel Bad → Kiel	Basel Bad Bf	Kiel Hbf	DE	DE	770.74	night	night	DB	14.00	144.00	10.79	110.99	100.20	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	578
469	Lüneburg → Basel Bad Bf	Luneburg → Basel Bad	Luneburg	Basel Bad Bf	DE	DE	662.39	night	night	DB	14.00	144.00	9.27	95.38	86.11	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	497
486	Basel SBB → Berlin Hbf	Basel Sbb → Berlin	Basel Sbb	Berlin Hbf	DE	DE	690.06	day	day	DB	14.00	144.00	9.66	99.37	89.71	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	345
487	ICE 12	Berlin Gesundbrunnen → Basel Sbb	Berlin Gesundbrunnen	Basel Sbb	DE	CH	692.93	day	day	DB	14.00	144.00	9.70	99.78	90.08	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	346
488	Berlin Ostbahnhof → Basel SBB	Berlin Ostbahnhof → Basel Sbb	Berlin Ostbahnhof	Basel Sbb	DE	DE	691.54	night	night	DB	14.00	144.00	9.68	99.58	89.90	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	519
489	Basel SBB → Berlin Hbf (tief)	Basel Sbb → Berlin	Basel Sbb	Berlin Hbf Tief	DE	DE	690.06	day	day	DB	14.00	144.00	9.66	99.37	89.71	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	345
502	ICE 43	Basel Sbb → Dusseldorf	Basel Sbb	Dusseldorf Hbf	CH	DE	412.40	day	day	DB	14.00	144.00	5.77	59.39	53.62	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	206
526	ICE 60	Munchen → Basel Sbb	Munchen Hbf	Basel Sbb	DE	CH	303.39	day	day	DB	14.00	144.00	4.25	43.69	39.44	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	152
535	ICE 60	Stuttgart → Basel Sbb	Stuttgart Hbf	Basel Sbb	DE	CH	181.35	day	day	DB	14.00	144.00	2.54	26.11	23.57	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	91
672	ICE 82	Berlin Gesundbrunnen → Strasbourg	Berlin Gesundbrunnen	Strasbourg	DE	FR	594.48	day	day	DB	14.00	144.00	8.32	85.61	77.29	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	297
675	Wien Hbf → Berlin Gesundbrunnen	Wien → Berlin Gesundbrunnen	Wien Hbf	Berlin Gesundbrunnen	DE	DE	529.39	night	night	ÖBB	14.00	144.00	7.41	76.23	68.82	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	397
681	Berlin Ostbahnhof → Calais Ville	Berlin Ostbahnhof → Calais Ville	Berlin Ostbahnhof	Calais Ville	DE	DE	815.41	day	day	DB	14.00	144.00	11.42	117.42	106.00	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	408
694	Berlin Ostbahnhof → Interlaken Ost	Berlin Ostbahnhof → Interlaken Ost	Berlin Ostbahnhof	Interlaken Ost	DE	DE	760.86	night	night	SBB	14.00	144.00	10.65	109.56	98.91	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	571
695	Berlin Ostbahnhof → Karlsruhe Hbf	Berlin Ostbahnhof → Karlsruhe	Berlin Ostbahnhof	Karlsruhe Hbf	DE	DE	527.27	night	night	DB	14.00	144.00	7.38	75.93	68.55	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	395
630	Hamburg Hbf → Berchtesgaden Hbf	Hamburg → Berchtesgaden	Hamburg Hbf	Berchtesgaden Hbf	DE	DE	691.81	day	day	DB	14.00	144.00	9.69	99.62	89.93	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	346
631	Berchtesgaden Hbf → Hamburg-Altona	Berchtesgaden → Hamburg Altona	Berchtesgaden Hbf	Hamburg Altona	DE	DE	693.36	day	day	DB	14.00	144.00	9.71	99.84	90.13	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	347
635	Bergen auf Rügen → München Hbf	Bergen Auf Rugen → Munchen	Bergen Auf Rugen	Munchen Hbf	DE	DE	710.14	day	day	DB	14.00	144.00	9.94	102.26	92.32	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	355
743	Interlaken Ost → Berlin Hbf (tief)	Interlaken Ost → Berlin	Interlaken Ost	Berlin Hbf Tief	DE	DE	759.81	day	day	DB	14.00	144.00	10.64	109.41	98.77	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	380
744	Karlsruhe Hbf → Berlin Hbf (tief)	Karlsruhe → Berlin	Karlsruhe Hbf	Berlin Hbf Tief	DE	DE	525.43	night	night	DB	14.00	144.00	7.36	75.66	68.30	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	394
765	CZ3	Breclav → Berlin	Breclav	Berlin Hauptbahnhof	AT	AT	487.26	night	night	ÖBB	14.00	144.00	6.82	70.17	63.35	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	365
788	Warszawa Wschodnia → Berlin Hbf	Warszawa Wschodnia → Berlin	Warszawa Wschodnia	Berlin Hbf	DE	DE	522.02	night	night	DB	14.00	144.00	7.31	75.17	67.86	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	392
1040	München Hbf → Bremen Hbf	Munchen → Bremen	Munchen Hbf	Bremen Hbf	DE	DE	582.67	night	night	DB	14.00	144.00	8.16	83.90	75.74	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	437
1151	A15-A	Buchs → Graz 2	Buchs Bahnhof	Graz Hbf 2	AT	AT	449.31	night	night	ÖBB	14.00	144.00	6.29	64.70	58.41	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	337
1152	A15-A	Buchs → Graz 4	Buchs Bahnhof	Graz Hbf 4	AT	AT	449.29	night	night	ÖBB	14.00	144.00	6.29	64.70	58.41	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	337
1153	A88	Jesenice Si Zelezniska Posta → Buchs	Jesenice Si Zelezniska Posta	Buchs Bahnhof	AT	AT	357.64	night	night	ÖBB	14.00	144.00	5.01	51.50	46.49	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	268
1154	A94	Buchs → Linz Donau 6	Buchs Bahnhof	Linz Donau Hauptbahnhof 6	AT	AT	380.90	night	night	ÖBB	14.00	144.00	5.33	54.85	49.52	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	286
1155	A94	Buchs → Linz Donau 7	Buchs Bahnhof	Linz Donau Hauptbahnhof 7	AT	AT	380.91	night	night	ÖBB	14.00	144.00	5.33	54.85	49.52	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	286
1156	A15-A	Buchs → Villach	Buchs Bahnhof	Villach Hauptbahnhof	AT	AT	337.57	night	night	ÖBB	14.00	144.00	4.73	48.61	43.88	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	253
1157	A11	Wien → Buchs	Wien Hauptbahnhof	Buchs Bahnhof	AT	AT	528.60	night	night	ÖBB	14.00	144.00	7.40	76.12	68.72	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	396
1163	Budapest-Nyugati → Calais Ville	Budapest Nyugati → Calais Ville	Budapest Nyugati	Calais Ville	DE	DE	1303.26	day	day	DB	14.00	144.00	18.25	187.67	169.42	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	652
1009	A13	Kosice → Bratislava Hlavna Stanica	Kosice	Bratislava Hlavna Stanica	AT	AT	313.34	night	night	ÖBB	14.00	144.00	4.39	45.12	40.73	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	235
1012	CZ3	Breclav → Decin Hlavni Nadrazi	Breclav	Decin Hlavni Nadrazi	AT	AT	296.30	night	night	ÖBB	14.00	144.00	4.15	42.67	38.52	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	222
1013	A1	Breclav → Freilassing	Breclav	Freilassing Bahnhof	AT	AT	307.11	night	night	ÖBB	14.00	144.00	4.30	44.22	39.92	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	230
1018	A14	Breclav → Salzburg	Breclav	Salzburg Hauptbahnhof	AT	AT	303.24	night	night	ÖBB	14.00	144.00	4.25	43.67	39.42	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	227
1644	DEDTM -> FRPNO	Dortmund → Paris Nord	Dortmund Hbf	Paris Nord	DE	FR	466.67	day	day	Eurostar	14.00	144.00	6.53	67.20	60.67	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	100
1645	D1	Passau → Dortmund	Passau Hauptbahnhof	Dortmund Hauptbahnhof	AT	AT	538.43	night	night	ÖBB	14.00	144.00	7.54	77.53	69.99	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	404
1651	Dortmund Hbf → Wien Hbf	Dortmund → Wien	Dortmund Hbf	Wien Hbf	DE	DE	738.20	night	night	ÖBB	14.00	144.00	10.33	106.30	95.97	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	554
1021	A3	Bregenz → Flughafen Wien	Bregenz Bahnhof	Flughafen Wien Bahnhof	AT	AT	513.95	night	night	ÖBB	14.00	144.00	7.20	74.01	66.81	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	385
1022	A3	Hegyeshalom Palyaudvar → Bregenz	Hegyeshalom Palyaudvar	Bregenz Bahnhof	AT	AT	555.78	night	night	ÖBB	14.00	144.00	7.78	80.03	72.25	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	417
1024	A3	Linz Donau 9 → Bregenz	Linz Donau Hauptbahnhof 9	Bregenz Bahnhof	AT	AT	350.34	night	night	ÖBB	14.00	144.00	4.90	50.45	45.55	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	263
1027	A3	Wien → Bregenz	Wien Hauptbahnhof	Bregenz Bahnhof	AT	AT	500.94	night	night	ÖBB	14.00	144.00	7.01	72.14	65.13	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	376
1028	A3	Wien Autoreisezug → Bregenz	Wien Hauptbahnhof Autoreisezug	Bregenz Bahnhof	AT	AT	501.79	night	night	ÖBB	14.00	144.00	7.03	72.26	65.23	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	376
1114	A3	Bruck Leitha → Salzburg	Bruck Leitha Bahnhof	Salzburg Hauptbahnhof	AT	AT	279.31	night	night	ÖBB	14.00	144.00	3.91	40.22	36.31	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	209
1130	ICE 79	Bruxelles Midi → Frankfurt M Flughafen Fernbf	Bruxelles Midi	Frankfurt M Flughafen Fernbf	BE	DE	312.16	day	day	DB	14.00	144.00	4.37	44.95	40.58	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	156
1136	BEBMI -> FRMLV	Bruxelles Midi → Marne la Vallee Chessy	Bruxelles Midi	Marne La Vallee Chessy	BE	FR	245.21	day	day	Eurostar	14.00	144.00	3.43	35.31	31.88	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	53
1142	BEBMI -> FRPNO	Bruxelles Midi → Paris Nord	Bruxelles Midi	Paris Nord	BE	FR	259.56	day	day	Eurostar	14.00	144.00	3.63	37.38	33.75	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	56
1145	BEBMI -> GBSPX	Bruxelles Midi → St Pancras International	Bruxelles Midi	St Pancras International	BE	GB	320.42	day	day	Eurostar	14.00	144.00	4.49	46.14	41.65	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	69
1218	Praha-Smichov → Calais Ville	Praha Smichov → Calais Ville	Praha Smichov	Calais Ville	DE	DE	892.50	day	day	DB	14.00	144.00	12.50	128.52	116.02	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	446
1704	Düsseldorf Hbf → Wien Hbf (Autoreisezuganlage)	Dusseldorf → Wien Autoreisezuganlage	Dusseldorf Hbf	Wien Hbf Autoreisezuganlage	DE	DE	768.03	day	day	ÖBB	14.00	144.00	10.75	110.60	99.85	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	384
1852	A1	Innsbruck → Flughafen Wien	Innsbruck Hauptbahnhof	Flughafen Wien Bahnhof	AT	AT	397.96	night	night	ÖBB	14.00	144.00	5.57	57.31	51.74	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	298
1853	A1	Jenbach → Flughafen Wien	Jenbach Bahnhof	Flughafen Wien Bahnhof	AT	AT	366.91	night	night	ÖBB	14.00	144.00	5.14	52.84	47.70	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	275
1875	Graz Hbf → Frankfurt(Main)Hbf	Graz → Frankfurt Main	Graz Hbf	Frankfurt Main Hbf	DE	DE	600.09	night	night	DB	14.00	144.00	8.40	86.41	78.01	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	450
1930	Freiburg(Breisgau) Hbf → Kiel Hbf	Freiburg Breisgau → Kiel	Freiburg Breisgau Hbf	Kiel Hbf	DE	DE	720.29	night	night	DB	14.00	144.00	10.08	103.72	93.64	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	540
2149	Hamburg-Altona → München Hbf	Hamburg Altona → Munchen	Hamburg Altona	Munchen Hbf	DE	DE	612.49	night	night	DB	14.00	144.00	8.57	88.20	79.63	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	459
2152	D17	Nurnberg → Hamburg Altona	Nurnberg Hauptbahnhof	Hamburg Altona	AT	AT	463.69	night	night	ÖBB	14.00	144.00	6.49	66.77	60.28	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	348
2154	D3	Passau → Hamburg Altona	Passau Hauptbahnhof	Hamburg Altona	AT	AT	605.54	night	night	ÖBB	14.00	144.00	8.48	87.20	78.72	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	454
2157	Hamburg-Altona → Schwarzach-St.Veit	Hamburg Altona → Schwarzach St Veit	Hamburg Altona	Schwarzach St Veit	DE	DE	729.55	day	day	ÖBB	14.00	144.00	10.21	105.06	94.85	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	365
2159	Stuttgart Hbf → Hamburg-Altona	Stuttgart → Hamburg Altona	Stuttgart Hbf	Hamburg Altona	DE	DE	532.83	night	night	DB	14.00	144.00	7.46	76.73	69.27	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	400
2161	Hamburg-Altona → Wien Hbf	Hamburg Altona → Wien	Hamburg Altona	Wien Hbf	DE	DE	748.05	day	day	ÖBB	14.00	144.00	10.47	107.72	97.25	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	374
2162	Hamburg-Altona → Wien Hbf (Autoreisezuganlage)	Hamburg Altona → Wien Autoreisezuganlage	Hamburg Altona	Wien Hbf Autoreisezuganlage	DE	DE	749.53	day	day	ÖBB	14.00	144.00	10.49	107.93	97.44	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	375
2165	Hamburg-Altona → Zürich HB	Hamburg Altona → Zurich Hb	Hamburg Altona	Zurich Hb	DE	DE	693.60	day	day	SBB	14.00	144.00	9.71	99.88	90.17	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	347
2166	Hamburg-Bergedorf → Innsbruck Hbf	Hamburg Bergedorf → Innsbruck	Hamburg Bergedorf	Innsbruck Hbf	DE	DE	697.50	day	day	ÖBB	14.00	144.00	9.76	100.44	90.68	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	349
2170	Passau Hbf → Hamburg Dammtor	Passau → Hamburg Dammtor	Passau Hbf	Hamburg Dammtor	DE	DE	604.81	night	night	DB	14.00	144.00	8.47	87.09	78.62	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	454
2174	Innsbruck Hbf → Hamburg-Harburg	Innsbruck → Hamburg Harburg	Innsbruck Hbf	Hamburg Harburg	DE	DE	695.77	day	day	DB	14.00	144.00	9.74	100.19	90.45	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	348
2175	Hamburg-Harburg → Interlaken Ost	Hamburg Harburg → Interlaken Ost	Hamburg Harburg	Interlaken Ost	DE	DE	767.29	night	night	SBB	14.00	144.00	10.74	110.49	99.75	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	575
2180	Hamburg-Harburg → München Hbf	Hamburg Harburg → Munchen	Hamburg Harburg	Munchen Hbf	DE	DE	601.20	night	night	DB	14.00	144.00	8.42	86.57	78.15	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	451
2182	Passau Hbf → Hamburg-Harburg	Passau → Hamburg Harburg	Passau Hbf	Hamburg Harburg	DE	DE	594.20	night	night	DB	14.00	144.00	8.32	85.56	77.24	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	446
2185	Hamburg-Harburg → Schwarzach-St.Veit	Hamburg Harburg → Schwarzach St Veit	Hamburg Harburg	Schwarzach St Veit	DE	DE	718.15	day	day	ÖBB	14.00	144.00	10.05	103.41	93.36	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	359
2189	Hamburg-Harburg → Wien Hbf	Hamburg Harburg → Wien	Hamburg Harburg	Wien Hbf	DE	DE	737.39	day	day	ÖBB	14.00	144.00	10.32	106.18	95.86	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	369
2191	Hamburg-Harburg → Zürich HB	Hamburg Harburg → Zurich Hb	Hamburg Harburg	Zurich Hb	DE	DE	683.55	day	day	SBB	14.00	144.00	9.57	98.43	88.86	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	342
2193	Hamburg Hbf → Innsbruck Hbf	Hamburg → Innsbruck	Hamburg Hbf	Innsbruck Hbf	DE	DE	706.26	day	day	ÖBB	14.00	144.00	9.89	101.70	91.81	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	353
2194	Interlaken Ost → Hamburg Hbf	Interlaken Ost → Hamburg	Interlaken Ost	Hamburg Hbf	DE	DE	778.02	day	day	DB	14.00	144.00	10.89	112.03	101.14	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	389
2202	Hamburg Hbf → München Hbf	Hamburg → Munchen	Hamburg Hbf	Munchen Hbf	DE	DE	611.58	night	night	DB	14.00	144.00	8.56	88.07	79.51	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	459
2208	Passau Hbf → Hamburg Hbf	Passau → Hamburg	Passau Hbf	Hamburg Hbf	DE	DE	603.52	night	night	DB	14.00	144.00	8.45	86.91	78.46	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	453
2213	Stuttgart Hbf → Hamburg Hbf	Stuttgart → Hamburg	Stuttgart Hbf	Hamburg Hbf	DE	DE	533.35	night	night	DB	14.00	144.00	7.47	76.80	69.33	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	400
2214	Hamburg Hbf → Wien Hbf (Autoreisezuganlage)	Hamburg → Wien Autoreisezuganlage	Hamburg Hbf	Wien Hbf Autoreisezuganlage	DE	DE	746.51	day	day	ÖBB	14.00	144.00	10.45	107.50	97.05	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	373
2216	Hamburg Hbf → Zürich HB	Hamburg → Zurich Hb	Hamburg Hbf	Zurich Hb	DE	DE	694.34	day	day	SBB	14.00	144.00	9.72	99.98	90.26	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	347
1381	HU1	Chop → Hegyeshalom Palyaudvar	Chop	Hegyeshalom Palyaudvar	AT	AT	379.48	night	night	ÖBB	14.00	144.00	5.31	54.65	49.34	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	285
2241	A11	Kufstein → Hegyeshalom Palyaudvar	Kufstein Bahnhof	Hegyeshalom Palyaudvar	AT	AT	374.16	night	night	ÖBB	14.00	144.00	5.24	53.88	48.64	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	281
2243	A3	Hegyeshalom Palyaudvar → Salzburg	Hegyeshalom Palyaudvar	Salzburg Hauptbahnhof	AT	AT	306.11	night	night	ÖBB	14.00	144.00	4.29	44.08	39.79	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	230
2300	A1	Innsbruck → Wien	Innsbruck Hauptbahnhof	Wien Hauptbahnhof	AT	AT	386.09	night	night	ÖBB	14.00	144.00	5.41	55.60	50.19	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	290
1386	Chur → Hamburg Hbf	Chur → Hamburg	Chur	Hamburg Hbf	DE	DE	745.74	day	day	DB	14.00	144.00	10.44	107.39	96.95	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	373
1387	Hamburg-Altona → Chur	Hamburg Altona → Chur	Hamburg Altona	Chur	DE	DE	745.52	night	night	SBB	14.00	144.00	10.44	107.35	96.91	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	559
1388	Hamburg-Harburg → Chur	Hamburg Harburg → Chur	Hamburg Harburg	Chur	DE	DE	734.94	night	night	SBB	14.00	144.00	10.29	105.83	95.54	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	551
1390	Kiel Hbf → Chur	Kiel → Chur	Kiel Hbf	Chur	DE	DE	830.81	day	day	SBB	14.00	144.00	11.63	119.64	108.01	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	415
2321	EC 62	Salzburg → Jesenice Gr	Salzburg Hbf	Jesenice Gr	AT	FR	165.39	day	day	ÖBB	14.00	144.00	2.32	23.82	21.50	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	83
2340	Stralsund Hbf → Karlsruhe Hbf	Stralsund → Karlsruhe	Stralsund Hbf	Karlsruhe Hbf	DE	DE	672.95	night	night	DB	14.00	144.00	9.42	96.90	87.48	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	505
2352	Kiel Hbf → München Hbf	Kiel → Munchen	Kiel Hbf	Munchen Hbf	DE	DE	693.71	day	day	DB	14.00	144.00	9.71	99.89	90.18	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	347
2354	Passau Hbf → Kiel Hbf	Passau → Kiel	Passau Hbf	Kiel Hbf	DE	DE	678.39	night	night	DB	14.00	144.00	9.50	97.69	88.19	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	509
2357	Kiel Hbf → Stuttgart Hbf	Kiel → Stuttgart	Kiel Hbf	Stuttgart Hbf	DE	DE	618.49	night	night	DB	14.00	144.00	8.66	89.06	80.40	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	464
2358	Kiel Hbf → Zürich HB	Kiel → Zurich Hb	Kiel Hbf	Zurich Hb	DE	DE	779.34	day	day	SBB	14.00	144.00	10.91	112.22	101.31	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	390
2360	Münster(Westf)Hbf → Klagenfurt Hbf	Munster Westf → Klagenfurt	Munster Westf Hbf	Klagenfurt Hbf	DE	DE	765.69	day	day	ÖBB	14.00	144.00	10.72	110.26	99.54	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	383
1505	Cottbus Hbf → Norddeich Mole	Cottbus → Norddeich Mole	Cottbus Hbf	Norddeich Mole	DE	DE	525.66	night	night	DB	14.00	144.00	7.36	75.70	68.34	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	394
2390	DEKOH -> FRPNO	Koln → Paris Nord	Koln Hbf	Paris Nord	DE	FR	401.42	day	day	Eurostar	14.00	144.00	5.62	57.80	52.18	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	86
2394	Stralsund Hbf → Köln Hbf	Stralsund → Koln	Stralsund Hbf	Koln Hbf	DE	DE	556.96	night	night	DB	14.00	144.00	7.80	80.20	72.40	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	418
1533	Graz Hbf → Darmstadt Hbf	Graz → Darmstadt	Graz Hbf	Darmstadt Hbf	DE	DE	588.96	night	night	DB	14.00	144.00	8.25	84.81	76.56	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	442
3011	München Hbf → Roma Termini	Munchen → Roma Termini	Munchen Hbf	Roma Termini	DE	DE	697.77	day	day	ÖBB	14.00	144.00	9.77	100.48	90.71	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	349
3014	EC 62	Munchen → Salzburg	Munchen Hbf	Salzburg Hbf	DE	AT	116.55	day	day	DB	14.00	144.00	1.63	16.78	15.15	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	58
3016	Stralsund Hbf → München Hbf	Stralsund → Munchen	Stralsund Hbf	Munchen Hbf	DE	DE	693.96	day	day	DB	14.00	144.00	9.72	99.93	90.21	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	347
3028	D1	Nurnberg → Munster Westf	Nurnberg Hauptbahnhof	Munster Westf Hbf	AT	AT	370.04	night	night	ÖBB	14.00	144.00	5.18	53.29	48.11	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	278
3029	D1	Passau → Munster Westf	Passau Hauptbahnhof	Munster Westf Hbf	AT	AT	558.58	night	night	ÖBB	14.00	144.00	7.82	80.44	72.62	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	419
3432	A9	Tarvisio Citta Boscoverde → Wien	Tarvisio Citta Boscoverde	Wien Hauptbahnhof	AT	AT	279.99	night	night	ÖBB	14.00	144.00	3.92	40.32	36.40	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	210
38	003A	Bordeaux Saint Jean → Aeroport Charles de Gaulle 2 Tgv	Bordeaux Saint Jean	Aeroport Charles De Gaulle 2 Tgv	FR	FR	521.65	night	night	SNCF	14.00	144.00	7.30	75.12	67.82	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	391
1621	A3	Linz Donau 9 → Dornbirn	Linz Donau Hauptbahnhof 9	Dornbirn Bahnhof	AT	AT	353.35	night	night	ÖBB	14.00	144.00	4.95	50.88	45.93	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	265
1634	Klagenfurt Hbf → Dortmund Hbf	Klagenfurt → Dortmund	Klagenfurt Hbf	Dortmund Hbf	DE	DE	738.63	day	day	DB	14.00	144.00	10.34	106.36	96.02	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	369
1772	Graz Hbf → Erfurt Hbf	Graz → Erfurt	Graz Hbf	Erfurt Hbf	DE	DE	538.30	night	night	DB	14.00	144.00	7.54	77.52	69.98	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	404
44	001B	Marseille Saint Charles → Aeroport Charles de Gaulle 2 Tgv	Marseille Saint Charles	Aeroport Charles De Gaulle 2 Tgv	FR	FR	669.72	day	day	SNCF	14.00	144.00	9.38	96.44	87.06	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	335
1820	A15-A	Feldkirch → Graz 2	Feldkirch Bahnhof	Graz Hbf 2	AT	AT	439.72	night	night	ÖBB	14.00	144.00	6.16	63.32	57.16	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	330
1821	A15-A	Feldkirch → Graz 4	Feldkirch Bahnhof	Graz Hbf 4	AT	AT	439.70	night	night	ÖBB	14.00	144.00	6.16	63.32	57.16	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	330
1822	A3	Hegyeshalom Palyaudvar → Feldkirch	Hegyeshalom Palyaudvar	Feldkirch Bahnhof	AT	AT	570.38	night	night	ÖBB	14.00	144.00	7.99	82.13	74.14	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	428
1823	A88	Jesenice Si Zelezniska Posta → Feldkirch	Jesenice Si Zelezniska Posta	Feldkirch Bahnhof	AT	AT	350.02	night	night	ÖBB	14.00	144.00	4.90	50.40	45.50	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	263
1824	A11	Linz Donau 9 → Feldkirch	Linz Donau Hauptbahnhof 9	Feldkirch Bahnhof	AT	AT	369.12	night	night	ÖBB	14.00	144.00	5.17	53.15	47.98	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	277
49	631A	Nice Ville → Aeroport Charles de Gaulle 2 Tgv	Nice Ville	Aeroport Charles De Gaulle 2 Tgv	FR	FR	690.20	day	day	SNCF	14.00	144.00	9.66	99.39	89.73	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	345
50	633G	Aeroport Charles de Gaulle 2 Tgv → Perpignan	Aeroport Charles De Gaulle 2 Tgv	Perpignan	FR	FR	701.77	day	day	SNCF	14.00	144.00	9.82	101.05	91.23	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	351
52	533A	Aeroport Charles de Gaulle 2 Tgv → Toulon	Aeroport Charles De Gaulle 2 Tgv	Toulon	FR	FR	702.63	day	day	SNCF	14.00	144.00	9.84	101.18	91.34	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	351
53	TGV	Marseille Saint Charles → Aeroport Charles de Gaulle Tgv	Marseille Saint Charles	Aeroport Charles De Gaulle Tgv	CH	CH	669.67	day	day	SNCF	14.00	144.00	9.38	96.43	87.05	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	335
1830	A15-A	Feldkirch → Villach	Feldkirch Bahnhof	Villach Hauptbahnhof	AT	AT	329.50	night	night	ÖBB	14.00	144.00	4.61	47.45	42.84	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	247
1831	A11	Wien → Feldkirch	Wien Hauptbahnhof	Feldkirch Bahnhof	AT	AT	517.30	night	night	ÖBB	14.00	144.00	7.24	74.49	67.25	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	388
1846	Flensburg → München Hbf	Flensburg → Munchen	Flensburg	Munchen Hbf	DE	DE	752.06	day	day	DB	14.00	144.00	10.53	108.30	97.77	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	376
1847	Schwarzach-St.Veit → Flensburg	Schwarzach St Veit → Flensburg	Schwarzach St Veit	Flensburg	DE	DE	868.49	day	day	DB	14.00	144.00	12.16	125.06	112.90	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	434
1905	Frankfurt(Main)Hbf → Stralsund Hbf	Frankfurt Main → Stralsund	Frankfurt Main Hbf	Stralsund Hbf	DE	DE	555.37	night	night	DB	14.00	144.00	7.78	79.97	72.19	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	417
1906	ICE 82	Frankfurt Main → Strasbourg	Frankfurt Main Hbf	Strasbourg	DE	FR	182.05	day	day	DB	14.00	144.00	2.55	26.22	23.67	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	91
1940	A3	Hegyeshalom Palyaudvar → Freilassing	Hegyeshalom Palyaudvar	Freilassing Bahnhof	AT	AT	311.11	night	night	ÖBB	14.00	144.00	4.36	44.80	40.44	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	233
1946	D9	Freilassing → Stuttgart 10	Freilassing Bahnhof	Stuttgart Hauptbahnhof 10	AT	AT	299.64	night	night	ÖBB	14.00	144.00	4.19	43.15	38.96	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	225
1947	D9	Freilassing → Stuttgart 9	Freilassing Bahnhof	Stuttgart Hauptbahnhof 9	AT	AT	299.64	night	night	ÖBB	14.00	144.00	4.19	43.15	38.96	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	225
66	421C	Agen → Paris Montparnasse Hall 1 2	Agen	Paris Montparnasse Hall 1 2	FR	FR	531.31	night	night	SNCF	14.00	144.00	7.44	76.51	69.07	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	398
80	533A	Aix En Provence Tgv → Lille Flandres	Aix En Provence Tgv	Lille Flandres	FR	FR	816.38	day	day	SNCF	14.00	144.00	11.43	117.56	106.13	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	408
88	TGV	Paris de Lyon → Aix les Bains le Revard	Paris Gare De Lyon	Aix Les Bains Le Revard	CH	CH	440.74	day	day	SNCF	14.00	144.00	6.17	63.47	57.30	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	220
2076	A8	Graz 6 → Innsbruck	Graz Hbf 6	Innsbruck Hauptbahnhof	AT	AT	304.25	night	night	ÖBB	14.00	144.00	4.26	43.81	39.55	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	228
2077	A8	Graz 6 → Jenbach	Graz Hbf 6	Jenbach Bahnhof	AT	AT	276.94	night	night	ÖBB	14.00	144.00	3.88	39.88	36.00	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	208
2079	Saarbrücken Hbf → Graz Hbf	Saarbrucken → Graz	Saarbrucken Hbf	Graz Hbf	DE	DE	669.43	night	night	ÖBB	14.00	144.00	9.37	96.40	87.03	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	502
2080	ICE	Graz → Salzburg	Graz Hbf	Salzburg Hbf	AT	AT	196.38	day	day	ÖBB	14.00	144.00	2.75	28.28	25.53	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	98
2140	Hamburg-Altona → Innsbruck Hbf	Hamburg Altona → Innsbruck	Hamburg Altona	Innsbruck Hbf	DE	DE	706.98	day	day	ÖBB	14.00	144.00	9.90	101.81	91.91	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	353
2141	Hamburg-Altona → Interlaken Ost	Hamburg Altona → Interlaken Ost	Hamburg Altona	Interlaken Ost	DE	DE	777.04	night	night	SBB	14.00	144.00	10.88	111.89	101.01	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	583
2211	Schwarzach-St.Veit → Hamburg Hbf	Schwarzach St Veit → Hamburg	Schwarzach St Veit	Hamburg Hbf	DE	DE	727.99	day	day	DB	14.00	144.00	10.19	104.83	94.64	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	364
2331	Karlsruhe Hbf → Kiel Hbf	Karlsruhe → Kiel	Karlsruhe Hbf	Kiel Hbf	DE	DE	603.58	night	night	DB	14.00	144.00	8.45	86.92	78.47	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	453
2424	A1	Wien → Kufstein	Wien Hauptbahnhof	Kufstein Bahnhof	AT	AT	321.16	night	night	ÖBB	14.00	144.00	4.50	46.25	41.75	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	241
227	TGV	Paris de Lyon → Annecy	Paris Gare De Lyon	Annecy	CH	CH	431.99	day	day	SNCF	14.00	144.00	6.05	62.21	56.16	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	216
228	621B	Annecy → Paris de Lyon Hall 1 2	Annecy	Paris Gare De Lyon Hall 1 2	FR	FR	432.04	night	night	SNCF	14.00	144.00	6.05	62.21	56.16	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	324
345	555C	Aurillac → Paris Austerlitz	Aurillac	Paris Austerlitz	FR	FR	436.06	night	night	SNCF	14.00	144.00	6.10	62.79	56.69	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	327
2662	A94	St Margrethen → Linz Donau 6	St Margrethen Bahnhof	Linz Donau Hauptbahnhof 6	AT	AT	359.34	night	night	ÖBB	14.00	144.00	5.03	51.74	46.71	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	270
2665	A94	St Margrethen → Linz Donau 7	St Margrethen Bahnhof	Linz Donau Hauptbahnhof 7	AT	AT	359.35	night	night	ÖBB	14.00	144.00	5.03	51.75	46.72	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	270
383	TGV	Paris de Lyon → Avignon Centre	Paris Gare De Lyon	Avignon Centre	CH	CH	576.21	day	day	SNCF	14.00	144.00	8.07	82.97	74.90	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	288
584	TER	Lyon Part Dieu → Belfort	Lyon Part Dieu	Belfort	CH	CH	257.82	day	day	SNCF	14.00	144.00	3.61	37.13	33.52	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	129
585	TER	Lyon Perrache → Belfort	Lyon Perrache	Belfort	CH	CH	260.49	day	day	SNCF	14.00	144.00	3.65	37.51	33.86	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	130
588	TER	Belfort → Paris Est	Belfort	Paris Est	CH	CH	360.27	day	day	SNCF	14.00	144.00	5.04	51.88	46.84	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	180
597	TGV	Bellegarde Sur Valserine → Paris de Lyon	Bellegarde Sur Valserine	Paris Gare De Lyon	CH	CH	399.56	day	day	SNCF	14.00	144.00	5.59	57.54	51.95	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	200
2828	SI2	Maribor Zelezniska Postaja → Split Zeljeznicki Kolodvor	Maribor Zelezniska Postaja	Split Zeljeznicki Kolodvor	AT	AT	345.52	night	night	ÖBB	14.00	144.00	4.84	49.75	44.91	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	259
667	651A	Berlin Gesundbrunnen → Paris Est	Berlin Gesundbrunnen	Paris Est	FR	FR	876.29	day	day	SNCF	14.00	144.00	12.27	126.19	113.92	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	438
840	TGV	Paris de Lyon → Besancon Viotte	Paris Gare De Lyon	Besancon Viotte	CH	CH	324.12	day	day	SNCF	14.00	144.00	4.54	46.67	42.13	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	162
937	003A	Bordeaux Saint Jean → Lille Europe	Bordeaux Saint Jean	Lille Europe	FR	FR	700.98	day	day	SNCF	14.00	144.00	9.81	100.94	91.13	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	350
938	003A	Bordeaux Saint Jean → Lille Flandres	Bordeaux Saint Jean	Lille Flandres	FR	FR	700.52	night	night	SNCF	14.00	144.00	9.81	100.87	91.06	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	525
957	061C	Bordeaux Saint Jean → Strasbourg	Bordeaux Saint Jean	Strasbourg	FR	FR	757.21	day	day	SNCF	14.00	144.00	10.60	109.04	98.44	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	379
960	533B	Tourcoing → Bordeaux Saint Jean	Tourcoing	Bordeaux Saint Jean	FR	FR	711.50	night	night	SNCF	14.00	144.00	9.96	102.46	92.50	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	534
962	TGV	Bordeaux St Jean → Strasbourg	Bordeaux St Jean	Strasbourg	CH	CH	757.20	day	day	SNCF	14.00	144.00	10.60	109.04	98.44	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	379
978	081G	Brest → Bourg Saint Maurice	Brest	Bourg Saint Maurice	FR	FR	906.01	day	day	SNCF	14.00	144.00	12.68	130.47	117.79	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	453
981	081G	le Havre → Bourg Saint Maurice	Le Havre	Bourg Saint Maurice	FR	FR	658.57	day	day	SNCF	14.00	144.00	9.22	94.83	85.61	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	329
982	001G	Lille Flandres → Bourg Saint Maurice	Lille Flandres	Bourg Saint Maurice	FR	FR	621.70	night	night	SNCF	14.00	144.00	8.70	89.52	80.82	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	466
985	081G	Nantes → Bourg Saint Maurice	Nantes	Bourg Saint Maurice	FR	FR	661.23	night	night	SNCF	14.00	144.00	9.26	95.22	85.96	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	496
986	TGV	Bourg Saint Maurice → Paris de Lyon	Bourg Saint Maurice	Paris Gare De Lyon	CH	CH	488.64	day	day	SNCF	14.00	144.00	6.84	70.36	63.52	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	244
987	621F	Paris de Lyon Hall 1 2 → Bourg Saint Maurice	Paris Gare De Lyon Hall 1 2	Bourg Saint Maurice	FR	FR	488.64	night	night	SNCF	14.00	144.00	6.84	70.36	63.52	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	366
988	081G	Bourg Saint Maurice → Quimper	Bourg Saint Maurice	Quimper	FR	FR	867.09	day	day	SNCF	14.00	144.00	12.14	124.86	112.72	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	434
989	081G	Rennes → Bourg Saint Maurice	Rennes	Bourg Saint Maurice	FR	FR	698.44	day	day	SNCF	14.00	144.00	9.78	100.58	90.80	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	349
2998	München Ost → Roma Termini	Munchen Ost → Roma Termini	Munchen Ost	Roma Termini	DE	DE	695.98	day	day	ÖBB	14.00	144.00	9.74	100.22	90.48	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	348
3007	München Hbf → Ostseebad Binz	Munchen → Ostseebad Binz	Munchen Hbf	Ostseebad Binz	DE	DE	710.85	day	day	DB	14.00	144.00	9.95	102.36	92.41	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	355
3008	München Hbf → Paris Est	Munchen → Paris Est	Munchen Hbf	Paris Est	DE	DE	682.19	day	day	DB	14.00	144.00	9.55	98.24	88.69	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	341
1049	TGV	Brest F → Modane	Brest F	Modane	CH	CH	918.28	day	day	SNCF	14.00	144.00	12.86	132.23	119.37	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	459
1052	401A	Brest → Paris Montparnasse Hall 1 2	Brest	Paris Montparnasse Hall 1 2	FR	FR	502.32	night	night	SNCF	14.00	144.00	7.03	72.33	65.30	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	377
1058	IC	Paris Bercy → Briancon	Paris Bercy	Briancon	CH	CH	544.99	day	day	SNCF	14.00	144.00	7.63	78.48	70.85	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	272
1134	001A	Lyon Part Dieu → Bruxelles Midi	Lyon Part Dieu	Bruxelles Midi	FR	FR	565.68	night	night	SNCF	14.00	144.00	7.92	81.46	73.54	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	424
1135	001A	Lyon Perrache → Bruxelles Midi	Lyon Perrache	Bruxelles Midi	FR	FR	566.86	night	night	SNCF	14.00	144.00	7.94	81.63	73.69	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	425
1137	001B	Bruxelles Midi → Marseille Saint Charles	Bruxelles Midi	Marseille Saint Charles	FR	FR	841.37	day	day	SNCF	14.00	144.00	11.78	121.16	109.38	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	421
1138	001B	Bruxelles Midi → Montpellier Saint Roch	Bruxelles Midi	Montpellier Saint Roch	FR	FR	804.81	day	day	SNCF	14.00	144.00	11.27	115.89	104.62	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	402
1139	001B	Bruxelles Midi → Montpellier Sud de France	Bruxelles Midi	Montpellier Sud De France	FR	FR	805.74	day	day	SNCF	14.00	144.00	11.28	116.03	104.75	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	403
1140	003B	Nantes → Bruxelles Midi	Nantes	Bruxelles Midi	FR	FR	587.52	night	night	SNCF	14.00	144.00	8.23	84.60	76.37	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	441
1143	001B	Bruxelles Midi → Perpignan	Bruxelles Midi	Perpignan	FR	FR	911.84	day	day	SNCF	14.00	144.00	12.77	131.30	118.53	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	456
3133	IC 87	Oberndorf Neckar → Stuttgart	Oberndorf Neckar	Stuttgart Hbf	CH	DE	70.40	day	day	DB	14.00	144.00	0.99	10.14	9.15	90.20	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	35
3158	Ostseebad Binz → Stuttgart Hbf	Ostseebad Binz → Stuttgart	Ostseebad Binz	Stuttgart Hbf	DE	DE	695.22	day	day	DB	14.00	144.00	9.73	100.11	90.38	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	348
1208	560A	Cahors → Paris Austerlitz	Cahors	Paris Austerlitz	FR	FR	493.62	night	night	SNCF	14.00	144.00	6.91	71.08	64.17	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	370
3211	FRPNO -> GBSPX	Paris Nord → St Pancras International	Paris Nord	St Pancras International	FR	GB	343.53	day	day	Eurostar	14.00	144.00	4.81	49.47	44.66	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	74
3293	I3	Tarvisio Citta Boscoverde → Roma Stazione Di Roma Tiburtina	Tarvisio Citta Boscoverde	Roma Stazione Di Roma Tiburtina	AT	AT	518.12	night	night	ÖBB	14.00	144.00	7.25	74.61	67.36	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	389
3308	Wien Hbf → Rostock Hbf	Wien → Rostock	Wien Hbf	Rostock Hbf	DE	DE	718.82	day	day	DB	14.00	144.00	10.06	103.51	93.45	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	359
3314	NLRTA -> GBSPX	Rotterdam Centraal → St Pancras International	Rotterdam Centraal	St Pancras International	NL	GB	319.52	day	day	Eurostar	14.00	144.00	4.47	46.01	41.54	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	68
3416	ICE 83	Stuttgart → Strasbourg	Stuttgart Hbf	Strasbourg	DE	FR	108.64	day	day	DB	14.00	144.00	1.52	15.64	14.12	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	54
3421	Westerland(Sylt) → Stuttgart Hbf	Westerland Sylt → Stuttgart	Westerland Sylt	Stuttgart Hbf	DE	DE	683.43	day	day	DB	14.00	144.00	9.57	98.41	88.84	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	342
1303	TGV	Paris de Lyon → Chambery Challes les Eaux	Paris Gare De Lyon	Chambery Challes Les Eaux	CH	CH	451.79	day	day	SNCF	14.00	144.00	6.33	65.06	58.73	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	226
3517	CFR R-E 4007/1642 + 1641/R-E 4008	Bistrita → Bucuresti	Bistrita	Bucuresti	RO	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3497	AMSTERDAM CENTRAAL → LONDON-ST-PANCRAS INTL	Amsterdam Centraal → London St Pancras Intl	Amsterdam Centraal	London St Pancras Intl	BE	GB	\N	day	day	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3498	AMSTERDAM CENTRAAL → PARIS-NORD	Amsterdam Centraal → Paris Nord	Amsterdam Centraal	Paris Nord	BE	FR	\N	day	day	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3508	ATC IR 11501 + IR 11500	Bucuresti → Arad	Bucuresti	Arad	RO	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3510	VY 605 + 606	Oslo → Bergen	Oslo	Bergen	NO	NO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3499	ÖBB NJ 420 + NJ 421	Innsbruck → Amsterdam	Innsbruck	Amsterdam	AT	NL	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3500	ÖBB NJ 40421 + NJ 40490	Amsterdam → Wien	Amsterdam	Wien	NL	AT	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3501	ÖBB NJ 402 + NJ 403	Zurich → Amsterdam	Zurich	Amsterdam	CH	NL	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3513	ES 496 + 497	Paris → Berlin	Paris	Berlin	FR	DE	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3511	MÁV EN 40457 + EN 40476	Berlin → Budapest	Berlin	Budapest	DE	HU	\N	night	night	MÁV	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3512	ÖBB NJ 456 + NJ 457	Graz → Berlin	Graz	Berlin	AT	DE	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3515	ÖBB NJ 408 + NJ 409	Berlin → Zurich	Berlin	Zurich	DE	CH	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3514	SJ/RDC EN 345 + EN 346	Stockholm → Berlin	Stockholm	Berlin	SE	DE	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3519	CFR/MÁV IC 406 + IC 407	Brasov → Budapest	Brasov	Budapest	RO	HU	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3522	ÖBB NJ 446 + NJ 447	Wien → Bregenz	Wien	Bregenz	AT	CH	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3520	ZSSK R 680 + R 681	Humenne → Bratislava	Humenne	Bratislava	SK	SK	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3521	ZSSK EN 1152 + EN 1153	Split → Bratislava	Split	Bratislava	SK	SK	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3533	CFR IC 472 + IC 473	Bucuresti → Budapest	Bucuresti	Budapest	RO	HU	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3535	CFR 1641 (CN) + 1642 (CN)	Bucuresti → Cluj Napoca	Bucuresti	Cluj Napoca	RO	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3536	CFR 1667 + 1668	Bucuresti → Iasi	Bucuresti	Iasi	RO	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3532	ÖBB NJ 40425 + NJ 40468	Bruxelles Brussel → Wien	Bruxelles Brussel	Wien	BE	AT	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3538	CFR 78/1743 + 1744/79	Bucuresti → Oradea	Bucuresti	Oradea	RO	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3544	MÁV 1246 / 1605 / 481 + 480 / 1604 / 1247	Budapest → Rijeka	Budapest	Rijeka	HU	HR	\N	night	night	MÁV	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3545	MÁV IC 1204 + IC 1205	Budapest → Split	Budapest	Split	HU	HR	\N	night	night	MÁV	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3539	CFR 1641 (SM) + 1642 (SM)	Bucuresti → Satu Mare	Bucuresti	Satu Mare	RO	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3540	CFR R 4116 + 1641/R 4112	Sighetu Marmatiei → Bucuresti	Sighetu Marmatiei	Bucuresti	RO	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3541	CFR 1653 + 1654	Bucuresti → Vatra Dornei	Bucuresti	Vatra Dornei	RO	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3549	BDŽ 3686 + 3687	Burgas → Sofia	Burgas	Sofia	BG	BG	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3562	CFR 1837 + 1838	Iasi → Cluj Napoca	Iasi	Cluj Napoca	RO	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3563	CFR 1920 + 1922	Constanta → Oradea	Constanta	Oradea	RO	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3564	CFR 1952 + 1954	Suceava → Constanta	Suceava	Constanta	RO	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3571	BDŽ 2636 + 2637	Dobrich → Sofia	Dobrich	Sofia	BG	BG	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3531	ES 452 + 453	Praha → Bruxelles Brussel	Praha	Bruxelles Brussel	CZ	BE	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3534	CFM/CFR 401 + 402	Chisinau → Bucuresti	Chisinau	Bucuresti	MD	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3542	CFR/MÁV/ÖBB D 346 + D 347	Bucuresti → Wien	Bucuresti	Wien	RO	AT	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3546	MÁV/ÖBB EN 50237 + EN 50462	Budapest → Stuttgart	Budapest	Stuttgart	HU	HU	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3548	MÁV/ÖBB EN 40462 + EN 40467	Budapest → Zurich	Budapest	Zurich	HU	CH	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3561	RJ 1020 + 1021	Chop → Praha	Chop	Praha	SK	CZ	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3572	UEX 332/1372 + 333/1373	Innsbruck → Dusseldorf	Innsbruck	Dusseldorf	AT	DE	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3573	ST 3904 + 3905	Malmo → Duved	Malmo	Duved	SE	SE	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3597	CFR 1763 + 1765	Iasi → Timisoara	Iasi	Timisoara	RO	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3588	UEX 1858 + 1859	Lorrach → Hamburg	Lorrach	Hamburg	DE	DE	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3589	UEX 1856 + 1857	Munchen → Hamburg	Munchen	Hamburg	DE	DE	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3596	ZSSK EN 442 + EN 443	Humenne → Praha	Humenne	Praha	SK	CZ	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3598	ST 304 + 305	Innsbruck → Malmo	Innsbruck	Malmo	AT	AT	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3610	KOLN HBF → PARIS-NORD	Koln → Paris Nord	Koln Hbf	Paris Nord	BE	FR	\N	day	day	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3586	ÖBB NJ 464 + NJ 465	Graz → Zurich	Graz	Zurich	AT	CH	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3587	ÖBB NJ 40420 + NJ 40491	Innsbruck → Hamburg	Innsbruck	Hamburg	AT	DE	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3590	ÖBB NJ 490 + NJ 491	Wien → Hamburg	Wien	Hamburg	AT	DE	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3591	ÖBB NJ 470 + NJ 471	Zurich → Hamburg	Zurich	Hamburg	CH	DE	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3641	CFR 1941 + 1942/R 8810	Satu Mare → Mangalia	Satu Mare	Mangalia	RO	RO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3651	HŽPP 1880 + 1881	Osijek → Split	Osijek	Split	HR	HR	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3669	BDŽ 9646 + 9647	Silistra → Sofia	Silistra	Sofia	BG	BG	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3670	BDŽ 2626 + 2627	Varna → Sofia	Varna	Sofia	BG	BG	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3671	HŽPP 1840 + 1841	Vukovar → Split	Vukovar	Split	HR	HR	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3672	HŽPP 1820 + 1821	Split → Zagreb	Split	Zagreb	HR	HR	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3633	GWR Sleeper (Penzance) + Sleeper (London)	London → Penzance	London	Penzance	GB	GB	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3652	GA F5 725 + F5 726	Oslo → Stavanger	Oslo	Stavanger	NO	NO	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3657	RJ 1038 + 1039	Przemysl → Praha	Przemysl	Praha	PL	CZ	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3659	ČD EC 458 + EN 40459	Praha → Zurich	Praha	Zurich	CH	CH	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3674	HŽPP/ÖBB EN 414 + EN 40237	Zagreb → Stuttgart	Zagreb	Stuttgart	HR	HR	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3678	HŽPP/ÖBB EN 40414 + EN 40465	Zagreb → Zurich	Zagreb	Zurich	HR	CH	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3645	ÖBB NJ 294 + NJ 295	Roma → Munchen	Roma	Munchen	IT	DE	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3666	ÖBB NJ 40233 + NJ 40294	Wien → Roma	Wien	Roma	AT	IT	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3673	ÖBB NJ 236 + NJ 237	Venezia → Stuttgart	Venezia	Stuttgart	IT	IT	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3676	ÖBB NJ 40236 + NJ 40466	Venezia → Wien	Venezia	Wien	IT	AT	\N	night	night	ÖBB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3496	SNCF IC Nuit 3754 (Sun) + IC Nuit 3755 (Sun)	Albi → Paris	Albi	Paris	FR	FR	\N	night	night	SNCF	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3509	SNCF IC Nuit 3789 + IC Nuit 3790	Paris → Aurillac	Paris	Aurillac	FR	FR	\N	night	night	SNCF	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3523	SNCF IC Nuit 5787 + IC Nuit 5792	Paris → Briancon	Paris	Briancon	FR	FR	\N	night	night	SNCF	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3550	SNCF IC Nuit 5737 + IC Nuit 5738	Paris → Cerbere	Paris	Cerbere	FR	FR	\N	night	night	SNCF	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3565	SNCF IC Nuit 3970 + IC Nuit 3971	Latour → de Carol Paris	Latour	De Carol Paris	FR	FR	\N	night	night	SNCF	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3648	SNCF IC Nuit 5781 + IC Nuit 5772	Paris → Nice	Paris	Nice	FR	FR	\N	night	night	SNCF	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3654	SNCF IC Nuit 3754 + IC Nuit 3755	Rodez → Paris	Rodez	Paris	FR	FR	\N	night	night	SNCF	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3655	SNCF IC Nuit 3731 + IC Nuit 3740	Tarbes → Paris	Tarbes	Paris	FR	FR	\N	night	night	SNCF	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3656	SNCF IC Nuit 3750 + IC Nuit 3751	Toulouse → Paris	Toulouse	Paris	FR	FR	\N	night	night	SNCF	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3630	FS IC Notte 752 + IC Notte 755	Lecce → Milano	Lecce	Milano	IT	IT	\N	night	night	Trenitalia	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3518	FS IC Notte 763 + IC Notte 764	Bolzano → Roma	Bolzano	Roma	IT	IT	\N	night	night	Trenitalia	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3631	FS IC Notte 788 + IC Notte 789	Lecce → Roma	Lecce	Roma	IT	IT	\N	night	night	Trenitalia	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3632	FS IC Notte 754 + IC Notte 757	Lecce → Torino	Lecce	Torino	IT	IT	\N	night	night	Trenitalia	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3643	FS IC Notte 1964 + IC Notte 1967	Palermo → Milano	Palermo	Milano	IT	IT	\N	night	night	Trenitalia	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3644	FS IC Notte 1962 + IC Notte 1963	Siracusa → Milano	Siracusa	Milano	IT	IT	\N	night	night	Trenitalia	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3653	FS IC Notte 1954 + IC Notte 1955 (P)	Palermo → Roma	Palermo	Roma	IT	IT	\N	night	night	Trenitalia	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3663	FS IC Notte 794 + IC Notte 795	Reggio Calabria → Torino	Reggio Calabria	Torino	IT	IT	\N	night	night	Trenitalia	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3664	FS IC Notte 1955 (S) + IC Notte 1956	Roma → Siracusa	Roma	Siracusa	IT	IT	\N	night	night	Trenitalia	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3665	FS IC Notte 770 + IC Notte 774	Trieste → Roma	Trieste	Roma	IT	IT	\N	night	night	Trenitalia	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3668	FS IC Notte 796 + IC Notte 1515	Salerno → Torino	Salerno	Torino	IT	IT	\N	night	night	Trenitalia	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3575	PKP TLK 35190 + TLK 53190	Krakow → Eba	Krakow	Eba	PL	PL	\N	night	night	PKP	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3516	PKP TLK 48190/38194 + TLK 83194/84190	Bielsko → Biaa Swinoujscie	Bielsko	Biaa Swinoujscie	PL	PL	\N	night	night	PKP	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3547	MÁV/PKP IC 407 / EN 477 + EN 476 / IC 406	Warszawa → Budapest	Warszawa	Budapest	PL	HU	\N	night	night	PKP	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3554	PKP IC 28170 + IC 82170	Chelm → Swinoujscie	Chelm	Swinoujscie	PL	PL	\N	night	night	PKP	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3582	PKP/ČD EC 460 + EC 461	Praha → Gdynia	Praha	Gdynia	PL	CZ	\N	night	night	PKP	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3583	PKP TLK 35170 + TLK 53170	Zakopane → Gdynia	Zakopane	Gdynia	PL	PL	\N	night	night	PKP	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3592	PKP TLK 35190/50191 + TLK 55190/53190	Krakow → Hel	Krakow	Hel	PL	PL	\N	night	night	PKP	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3611	PKP TLK 38170 + TLK 83170	Krakow → Koobrzeg	Krakow	Koobrzeg	PL	PL	\N	night	night	PKP	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3646	PKP/ČD EN 40406 + EN 40407	Munchen → Warszawa	Munchen	Warszawa	DE	PL	\N	night	night	PKP	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3658	PKP/ČD EN 443 / IC 406 + IC 407 / EN 442	Praha → Warszawa	Praha	Warszawa	CZ	PL	\N	night	night	PKP	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3660	PKP EN 430 / IC 28170 + IC 82170 / EC 431	Przemysl → Swinoujscie	Przemysl	Swinoujscie	PL	PL	\N	night	night	PKP	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3675	PKP IC 38172 + IC 83172	Zakopane → Swinoujscie	Zakopane	Swinoujscie	PL	PL	\N	night	night	PKP	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3493	AACHEN HBF → LIEGE-GUILLEMINS	Aachen → Liege Guillemins	Aachen Hbf	Liege Guillemins	BE	BE	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3494	AACHEN HBF → LIEGE-SAINT-LAMBERT	Aachen → Liege Saint Lambert	Aachen Hbf	Liege Saint Lambert	BE	BE	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3524	BRUSSEL-ZUID → FRANKFURT(MAIN) HBF	Brussel Zuid → Frankfurt Main	Brussel Zuid	Frankfurt Main Hbf	BE	DE	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3525	BRUSSEL-ZUID → LIEGE-SAINT-LAMBERT	Brussel Zuid → Liege Saint Lambert	Brussel Zuid	Liege Saint Lambert	BE	BE	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3526	BRUSSEL-ZUID → MARSEILLE-SAINT-CHARLES	Brussel Zuid → Marseille Saint Charles	Brussel Zuid	Marseille Saint Charles	BE	FR	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3527	BRUSSEL-ZUID → PARIS-NORD	Brussel Zuid → Paris Nord	Brussel Zuid	Paris Nord	BE	FR	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3528	BRUSSEL-ZUID → ROTTERDAM CENTRAAL	Brussel Zuid → Rotterdam Centraal	Brussel Zuid	Rotterdam Centraal	BE	NL	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3529	BRUSSELS AIRPORT - ZAVENTEM → DINANT	Brussels Airport Zaventem → Dinant	Brussels Airport Zaventem	Dinant	BE	BE	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3530	BRUSSELS AIRPORT - ZAVENTEM → GENT-SINT-PIETERS	Brussels Airport Zaventem → Gent Sint Pieters	Brussels Airport Zaventem	Gent Sint Pieters	BE	BE	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3551	CHARLEROI-CENTRAL → ESSEN	Charleroi → Essen	Charleroi Central	Essen	BE	DE	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3584	GENK → GENT-SINT-PIETERS	Genk → Gent Sint Pieters	Genk	Gent Sint Pieters	BE	BE	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3609	KNOKKE → LIEGE-GUILLEMINS	Knokke → Liege Guillemins	Knokke	Liege Guillemins	BE	BE	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3612	KORTRIJK → LILLE FLANDRES	Kortrijk → Lille Flandres	Kortrijk	Lille Flandres	BE	FR	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3642	MECHELEN → ZEEBRUGGE-DORP	Mechelen → Zeebrugge Dorp	Mechelen	Zeebrugge Dorp	BE	BE	\N	day	day	SNCB	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3574	SJ 70 + 71	Stockholm → Duved	Stockholm	Duved	SE	SE	\N	night	night	SJ	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3636	SJ 91 + 92	Lulea → Stockholm	Lulea	Stockholm	SE	SE	\N	night	night	SJ	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3640	SJ 1 + 2	Stockholm → Malmo	Stockholm	Malmo	SE	SE	\N	night	night	SJ	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3647	SJ 93 + 94	Narvik → Stockholm	Narvik	Stockholm	SE	SE	\N	night	night	SJ	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
1159	München Hbf → Budapest-Keleti	Munchen → Budapest Keleti	Munchen Hbf	Budapest Keleti	DE	DE	566.22	night	night	MÁV	14.00	144.00	7.93	81.54	73.61	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	425
3578	CS 1001 (FW) + 1002 (FW)	London → Fort William	London	Fort William	GB	GB	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3585	CS 1003 (G) + 1004 (G)	London → Glasgow	London	Glasgow	GB	GB	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3593	VR IC 267 + IC 274	Helsinki → Kemijarvi	Helsinki	Kemijarvi	FI	FI	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3594	VR P 269 + P 276	Helsinki → Kolari	Helsinki	Kolari	FI	FI	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
3595	VR IC 266 (H) + IC 273	Rovaniemi → Helsinki	Rovaniemi	Helsinki	FI	FI	\N	night	night	Other	14.00	144.00	\N	\N	\N	\N	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	\N
1444	IC	Paris Bercy → Clermont Ferrand	Paris Bercy	Clermont Ferrand	CH	CH	344.58	day	day	SNCF	14.00	144.00	4.82	49.62	44.80	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	172
1588	TER	Paris Bercy → Dijon	Paris Bercy	Dijon	CH	CH	258.78	day	day	SNCF	14.00	144.00	3.62	37.26	33.64	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	129
1590	TER	Paris de Lyon → Dijon	Paris Gare De Lyon	Dijon	CH	CH	259.68	day	day	SNCF	14.00	144.00	3.64	37.39	33.75	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	130
1803	TGV	Paris de Lyon → Saint Etienne Chateaucreux	Paris Gare De Lyon	Saint Etienne Chateaucreux	CH	CH	408.02	day	day	SNCF	14.00	144.00	5.71	58.75	53.04	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	204
1807	TGV	Evian les Bains → Paris de Lyon	Evian Les Bains	Paris Gare De Lyon	CH	CH	416.18	day	day	SNCF	14.00	144.00	5.83	59.93	54.10	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	208
1868	671A	Marseille Saint Charles → Francfort Sur le Main	Marseille Saint Charles	Francfort Sur Le Main	FR	FR	796.75	day	day	SNCF	14.00	144.00	11.15	114.73	103.58	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	398
1869	651A	Francfort Sur le Main → Paris Est	Francfort Sur Le Main	Paris Est	FR	FR	475.26	night	night	SNCF	14.00	144.00	6.65	68.44	61.79	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	356
1922	TGV	Paris de Lyon → Frasne	Paris Gare De Lyon	Frasne	CH	CH	358.45	day	day	SNCF	14.00	144.00	5.02	51.62	46.60	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	179
2025	621I	Paris de Lyon Hall 1 2 → Saint Gervais les Bains le Fayet	Paris Gare De Lyon Hall 1 2	Saint Gervais Les Bains Le Fayet	FR	FR	461.34	night	night	SNCF	14.00	144.00	6.46	66.43	59.97	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	346
2099	TGV	Paris de Lyon → Grenoble	Paris Gare De Lyon	Grenoble	CH	CH	478.60	day	day	SNCF	14.00	144.00	6.70	68.92	62.22	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	239
2100	621A	Grenoble → Paris de Lyon Hall 1 2	Grenoble	Paris Gare De Lyon Hall 1 2	FR	FR	478.62	night	night	SNCF	14.00	144.00	6.70	68.92	62.22	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	359
2102	081G	Rennes → Grenoble	Rennes	Grenoble	FR	FR	649.84	day	day	SNCF	14.00	144.00	9.10	93.58	84.48	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	325
2246	421A	Paris Montparnasse Hall 1 2 → Hendaye	Paris Montparnasse Hall 1 2	Hendaye	FR	FR	687.10	day	day	SNCF	14.00	144.00	9.62	98.94	89.32	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	344
2286	631B	Hyeres → Paris de Lyon Hall 1 2	Hyeres	Paris Gare De Lyon Hall 1 2	FR	FR	700.36	day	day	SNCF	14.00	144.00	9.81	100.85	91.04	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	350
2551	TGV	Lyon Part Dieu → le Havre	Lyon Part Dieu	Le Havre	CH	CH	545.77	day	day	SNCF	14.00	144.00	7.64	78.59	70.95	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	273
2552	081C	le Havre → Marseille Saint Charles	Le Havre	Marseille Saint Charles	FR	FR	797.15	day	day	SNCF	14.00	144.00	11.16	114.79	103.63	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	399
2616	001B	Lille Europe → Marseille Saint Charles	Lille Europe	Marseille Saint Charles	FR	FR	834.23	night	night	SNCF	14.00	144.00	11.68	120.13	108.45	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	626
2617	001B	Lille Europe → Montpellier Saint Roch	Lille Europe	Montpellier Saint Roch	FR	FR	784.57	day	day	SNCF	14.00	144.00	10.98	112.98	102.00	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	392
2618	001A	Lille Europe → Montpellier Sud de France	Lille Europe	Montpellier Sud De France	FR	FR	785.90	day	day	SNCF	14.00	144.00	11.00	113.17	102.17	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	393
2626	001B	Lille Flandres → Marseille Saint Charles	Lille Flandres	Marseille Saint Charles	FR	FR	834.01	night	night	SNCF	14.00	144.00	11.68	120.10	108.42	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	626
2628	001G	Lille Flandres → Modane	Lille Flandres	Modane	FR	FR	661.51	night	night	SNCF	14.00	144.00	9.26	95.26	86.00	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	496
2629	001B	Montpellier Saint Roch → Lille Flandres	Montpellier Saint Roch	Lille Flandres	FR	FR	784.29	night	night	SNCF	14.00	144.00	10.98	112.94	101.96	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	588
2630	533A	Montpellier Sud de France → Lille Flandres	Montpellier Sud De France	Lille Flandres	FR	FR	785.62	day	day	SNCF	14.00	144.00	11.00	113.13	102.13	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	393
2687	401C	Lorient → Paris Montparnasse Hall 1 2	Lorient	Paris Montparnasse Hall 1 2	FR	FR	437.52	night	night	SNCF	14.00	144.00	6.13	63.00	56.87	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	328
2731	071A	Luxembourg → Marseille Saint Charles	Luxembourg	Marseille Saint Charles	FR	FR	702.57	day	day	SNCF	14.00	144.00	9.84	101.17	91.33	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	351
2733	071B	Montpellier Saint Roch → Luxembourg	Montpellier Saint Roch	Luxembourg	FR	FR	688.41	night	night	SNCF	14.00	144.00	9.64	99.13	89.49	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	516
2768	TER	Lyon Part Dieu → Paris Bercy	Lyon Part Dieu	Paris Bercy	CH	CH	389.92	day	day	SNCF	14.00	144.00	5.46	56.15	50.69	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	195
2775	TGV	Strasbourg → Lyon Part Dieu	Strasbourg	Lyon Part Dieu	CH	CH	381.87	day	day	SNCF	14.00	144.00	5.35	54.99	49.64	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	191
2795	TER	Paris Bercy → Lyon Perrache	Paris Bercy	Lyon Perrache	CH	CH	389.88	day	day	SNCF	14.00	144.00	5.46	56.14	50.68	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	195
2797	TGV	Paris de Lyon → Lyon Perrache	Paris Gare De Lyon	Lyon Perrache	CH	CH	390.75	day	day	SNCF	14.00	144.00	5.47	56.27	50.80	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	195
2813	TER	Macon → Paris Bercy	Macon	Paris Bercy	CH	CH	336.25	day	day	SNCF	14.00	144.00	4.71	48.42	43.71	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	168
2815	TER	Macon → Paris de Lyon	Macon	Paris Gare De Lyon	CH	CH	337.13	day	day	SNCF	14.00	144.00	4.72	48.55	43.83	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	169
2830	633A	Marne la Vallee Chessy → Marseille Saint Charles	Marne La Vallee Chessy	Marseille Saint Charles	FR	FR	650.55	day	day	SNCF	14.00	144.00	9.11	93.68	84.57	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	325
2835	633B	Nice Ville → Marne la Vallee Chessy	Nice Ville	Marne La Vallee Chessy	FR	FR	669.31	night	night	SNCF	14.00	144.00	9.37	96.38	87.01	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	502
2836	631C	Marne la Vallee Chessy → Perpignan	Marne La Vallee Chessy	Perpignan	FR	FR	686.54	day	day	SNCF	14.00	144.00	9.61	98.86	89.25	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	343
2837	533A	Toulon → Marne la Vallee Chessy	Toulon	Marne La Vallee Chessy	FR	FR	682.98	day	day	SNCF	14.00	144.00	9.56	98.35	88.79	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	341
2838	071A	Marseille Saint Charles → Metz	Marseille Saint Charles	Metz	FR	FR	648.58	day	day	SNCF	14.00	144.00	9.08	93.40	84.32	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	324
2839	TGV	Metz Ville → Marseille Saint Charles	Metz Ville	Marseille Saint Charles	CH	CH	648.44	day	day	SNCF	14.00	144.00	9.08	93.38	84.30	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	324
2843	081A	Marseille Saint Charles → Nantes	Marseille Saint Charles	Nantes	FR	FR	694.56	day	day	SNCF	14.00	144.00	9.72	100.02	90.30	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	347
2845	631B	Marseille Saint Charles → Paris de Lyon Hall 1 2	Marseille Saint Charles	Paris Gare De Lyon Hall 1 2	FR	FR	658.34	night	night	SNCF	14.00	144.00	9.22	94.80	85.58	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	494
2846	631B	Marseille Saint Charles → Paris Montparnasse Hall 1 2	Marseille Saint Charles	Paris Montparnasse Hall 1 2	FR	FR	659.40	day	day	SNCF	14.00	144.00	9.23	94.95	85.72	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	330
2848	081A	Rennes → Marseille Saint Charles	Rennes	Marseille Saint Charles	FR	FR	764.23	day	day	SNCF	14.00	144.00	10.70	110.05	99.35	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	382
2849	081C	Rouen Rive Droite → Marseille Saint Charles	Rouen Rive Droite	Marseille Saint Charles	FR	FR	758.09	day	day	SNCF	14.00	144.00	10.61	109.16	98.55	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	379
2854	533A	Marseille Saint Charles → Tourcoing	Marseille Saint Charles	Tourcoing	FR	FR	841.20	day	day	SNCF	14.00	144.00	11.78	121.13	109.35	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	421
2884	TGV	Montpellier Saint Roch → Metz Ville	Montpellier Saint Roch	Metz Ville	CH	CH	636.90	day	day	SNCF	14.00	144.00	8.92	91.71	82.79	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	318
2886	TGV	Paris Est → Metz Ville	Paris Est	Metz Ville	CH	CH	279.77	day	day	SNCF	14.00	144.00	3.92	40.29	36.37	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	140
2894	071B	Metz → Montpellier Saint Roch	Metz	Montpellier Saint Roch	FR	FR	636.88	night	night	SNCF	14.00	144.00	8.92	91.71	82.79	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	478
2912	641A	Milano Porta Garibaldi → Paris de Lyon Hall 1 2	Milano Porta Garibaldi	Paris Gare De Lyon Hall 1 2	FR	FR	635.98	night	night	SNCF	14.00	144.00	8.90	91.58	82.68	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	477
2914	TGV	Paris de Lyon → Miramas	Paris Gare De Lyon	Miramas	CH	CH	619.10	day	day	SNCF	14.00	144.00	8.67	89.15	80.48	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	310
2915	631D	Miramas → Paris de Lyon Hall 1 2	Miramas	Paris Gare De Lyon Hall 1 2	FR	FR	619.15	night	night	SNCF	14.00	144.00	8.67	89.16	80.49	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	464
2921	081G	Quimper → Modane	Quimper	Modane	FR	FR	877.62	day	day	SNCF	14.00	144.00	12.29	126.38	114.09	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	439
2922	081G	Modane → Rennes	Modane	Rennes	FR	FR	713.04	day	day	SNCF	14.00	144.00	9.98	102.68	92.70	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	357
2953	TGV	Montpellier Saint Roch → Paris de Lyon	Montpellier Saint Roch	Paris Gare De Lyon	CH	CH	594.08	day	day	SNCF	14.00	144.00	8.32	85.55	77.23	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	297
2954	631C	Montpellier Saint Roch → Paris de Lyon Hall 1 2	Montpellier Saint Roch	Paris Gare De Lyon Hall 1 2	FR	FR	594.07	night	night	SNCF	14.00	144.00	8.32	85.55	77.23	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	446
2956	081A	Rennes → Montpellier Saint Roch	Rennes	Montpellier Saint Roch	FR	FR	659.35	day	day	SNCF	14.00	144.00	9.23	94.95	85.72	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	330
2959	081B	Nantes → Montpellier Sud de France	Nantes	Montpellier Sud De France	FR	FR	586.52	night	night	SNCF	14.00	144.00	8.21	84.46	76.25	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	440
2960	TGV	Montpellier Sud de France → Paris de Lyon	Montpellier Sud De France	Paris Gare De Lyon	CH	CH	595.76	day	day	SNCF	14.00	144.00	8.34	85.79	77.45	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	298
2963	533A	Tourcoing → Montpellier Sud de France	Tourcoing	Montpellier Sud De France	FR	FR	793.94	day	day	SNCF	14.00	144.00	11.12	114.33	103.21	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	397
2970	401A	Morlaix → Paris Montparnasse Hall 1 2	Morlaix	Paris Montparnasse Hall 1 2	FR	FR	452.30	night	night	SNCF	14.00	144.00	6.33	65.13	58.80	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	339
2984	TGV	Mulhouse → Paris de Lyon	Mulhouse	Paris Gare De Lyon	CH	CH	387.43	day	day	SNCF	14.00	144.00	5.42	55.79	50.37	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	194
2990	TER	Troyes → Mulhouse	Troyes	Mulhouse	CH	CH	251.48	day	day	SNCF	14.00	144.00	3.52	36.21	32.69	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	126
3026	661A	Munich → Paris Est	Munich	Paris Est	FR	FR	682.27	day	day	SNCF	14.00	144.00	9.55	98.25	88.70	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	341
3072	TGV	Nantes → St Gervais les Bains le Fayet	Nantes	St Gervais Les Bains Le Fayet	CH	CH	646.48	day	day	SNCF	14.00	144.00	9.05	93.09	84.04	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	323
3073	061A	Nantes → Strasbourg	Nantes	Strasbourg	FR	FR	707.53	day	day	SNCF	14.00	144.00	9.91	101.88	91.97	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	354
3097	770B	Nice Ville → Paris Austerlitz	Nice Ville	Paris Austerlitz	FR	FR	683.80	day	day	SNCF	14.00	144.00	9.57	98.47	88.90	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	342
3098	770B	Nice Ville → Paris Bercy Bourg Pays d Auv	Nice Ville	Paris Bercy Bourg Pays D Auv	FR	FR	682.77	day	day	SNCF	14.00	144.00	9.56	98.32	88.76	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	341
3099	633B	Nice Ville → Paris de Lyon Hall 1 2	Nice Ville	Paris Gare De Lyon Hall 1 2	FR	FR	683.68	night	night	SNCF	14.00	144.00	9.57	98.45	88.88	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	513
3164	555B	Rodez → Paris Austerlitz	Rodez	Paris Austerlitz	FR	FR	498.39	night	night	SNCF	14.00	144.00	6.98	71.77	64.79	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	374
3166	555A	Toulouse Matabiau → Paris Austerlitz	Toulouse Matabiau	Paris Austerlitz	FR	FR	585.87	night	night	SNCF	14.00	144.00	8.20	84.37	76.17	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	439
3172	631C	Perpignan → Paris de Lyon Hall 1 2	Perpignan	Paris Gare De Lyon Hall 1 2	FR	FR	684.84	night	night	SNCF	14.00	144.00	9.59	98.62	89.03	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	514
3173	631B	Toulon → Paris de Lyon Hall 1 2	Toulon	Paris Gare De Lyon Hall 1 2	FR	FR	692.29	night	night	SNCF	14.00	144.00	9.69	99.69	90.00	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	519
3177	TGV	Perpignan → Paris de Lyon	Perpignan	Paris Gare De Lyon	CH	CH	684.84	day	day	SNCF	14.00	144.00	9.59	98.62	89.03	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	342
3178	TGV	Paris de Lyon → St Gervais les Bains le Fayet	Paris Gare De Lyon	St Gervais Les Bains Le Fayet	CH	CH	461.29	day	day	SNCF	14.00	144.00	6.46	66.43	59.97	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	231
3179	TGV	Paris de Lyon → Valence	Paris Gare De Lyon	Valence	CH	CH	475.73	day	day	SNCF	14.00	144.00	6.66	68.51	61.85	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	238
3180	TGV	Paris de Lyon → Zurich Hb	Paris Gare De Lyon	Zurich Hb	CH	CH	485.80	day	day	SNCF	14.00	144.00	6.80	69.96	63.16	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	243
3195	TER	Paris Est → Vittel	Paris Est	Vittel	CH	CH	274.19	day	day	SNCF	14.00	144.00	3.84	39.48	35.64	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	137
3201	631C	Paris Montparnasse Hall 1 2 → Perpignan	Paris Montparnasse Hall 1 2	Perpignan	FR	FR	684.67	day	day	SNCF	14.00	144.00	9.59	98.59	89.00	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	342
3204	401C	Quimper → Paris Montparnasse Hall 1 2	Quimper	Paris Montparnasse Hall 1 2	FR	FR	482.37	night	night	SNCF	14.00	144.00	6.75	69.46	62.71	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	362
3207	421C	Paris Montparnasse Hall 1 2 → Toulouse Matabiau	Paris Montparnasse Hall 1 2	Toulouse Matabiau	FR	FR	585.35	night	night	SNCF	14.00	144.00	8.19	84.29	76.10	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	439
3253	061B	Quimper → Strasbourg	Quimper	Strasbourg	FR	FR	876.52	day	day	SNCF	14.00	144.00	12.27	126.22	113.95	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	438
3279	061B	Rennes → Strasbourg	Rennes	Strasbourg	FR	FR	696.82	day	day	SNCF	14.00	144.00	9.76	100.34	90.58	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	348
169	IC	Amsterdam Centraal → Eindhoven Centraal	Amsterdam Centraal	Eindhoven Centraal	NL	NL	111.44	day	day	DB	14.00	144.00	1.56	16.05	14.49	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	56
468	EC	Basel Bad → Leipzig	Basel Bad Bf	Leipzig Hbf	CH	CH	543.47	day	day	SBB	14.00	144.00	7.61	78.26	70.65	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	272
1385	IC	Chur → Geneve Aeroport	Chur	Geneve Aeroport	CH	CH	270.26	day	day	SBB	14.00	144.00	3.78	38.92	35.14	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	135
1913	EC	Frankfurt Main → Zurich Hb	Frankfurt Main Hbf	Zurich Hb	CH	CH	303.53	day	day	SBB	14.00	144.00	4.25	43.71	39.46	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	152
1993	IC1	St Gallen → Geneve Aeroport	St Gallen	Geneve Aeroport	CH	CH	280.97	day	day	SBB	14.00	144.00	3.93	40.46	36.53	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	140
2010	TGV	Geneve → Paris de Lyon	Geneve	Paris Gare De Lyon	CH	CH	407.18	day	day	SBB	14.00	144.00	5.70	58.63	52.93	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	204
2013	IC1	St Gallen → Geneve	St Gallen	Geneve	CH	CH	280.16	day	day	SBB	14.00	144.00	3.92	40.34	36.42	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	140
3277	IC5	Rorschach → Renens Vd	Rorschach	Renens Vd	CH	CH	245.29	day	day	SBB	14.00	144.00	3.43	35.32	31.89	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	123
3481	RJX	Wien → Zurich Hb	Wien Hbf	Zurich Hb	CH	CH	592.12	day	day	SBB	14.00	144.00	8.29	85.27	76.98	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	296
2770	---/---	Paris de Lyon → Lyon Part Dieu	Paris Gare De Lyon	Lyon Part Dieu	IT	IT	390.84	night	night	Trenitalia	14.00	144.00	5.47	56.28	50.81	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	293
2785	---/---	Lyon Perrache Voyageurs → Paris de Lyon	Lyon Perrache Voyageurs	Paris Gare De Lyon	IT	IT	390.76	night	night	Trenitalia	14.00	144.00	5.47	56.27	50.80	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	293
2831	Marseille-St-Charles/Paris-Gare-de-Lyon	Marne la Vallee Chessy → Marseille St Charles	Marne La Vallee Chessy	Marseille St Charles	IT	IT	651.25	night	night	Trenitalia	14.00	144.00	9.12	93.78	84.66	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	488
2858	Paris-Gare-de-Lyon/Marseille-St-Charles	Paris de Lyon → Marseille St Charles	Paris Gare De Lyon	Marseille St Charles	IT	IT	658.26	night	night	Trenitalia	14.00	144.00	9.22	94.79	85.57	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	494
2910	30-50154404-1-40 Milano Centrale/Paris-Gare-de-Lyon	Milano → Oulx Cesana Claviere Sestriere	Milano Centrale	Oulx Cesana Claviere Sestriere	IT	IT	193.38	night	night	Trenitalia	14.00	144.00	2.71	27.85	25.14	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	145
2911	30-50154404-1-40 Milano Centrale/Paris-Gare-de-Lyon	Milano → Paris de Lyon	Milano Centrale	Paris Gare De Lyon	IT	IT	636.90	night	night	Trenitalia	14.00	144.00	8.92	91.71	82.79	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	478
2919	30-49982794-1-40 Milano Centrale/Paris-Gare-de-Lyon	Modane → Paris de Lyon	Modane	Paris Gare De Lyon	IT	IT	519.83	day	day	Trenitalia	14.00	144.00	7.28	74.86	67.58	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	260
3469	EN	Wien → Warszawa Wschodnia	Wien Hbf	Warszawa Wschodnia	DE	DE	561.09	night	night	PKP	14.00	144.00	7.86	80.80	72.94	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	421
1161	München Ost → Budapest-Keleti	Munchen Ost → Budapest Keleti	Munchen Ost	Budapest Keleti	DE	DE	562.66	night	night	MÁV	14.00	144.00	7.88	81.02	73.14	90.30	Back-on-Track 2022	2026-03-22	2026-03-22 18:25:44.394193	422
\.


--
-- Name: fact_routes_route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: obrail_user
--

SELECT pg_catalog.setval('public.fact_routes_route_id_seq', 3678, true);


--
-- PostgreSQL database dump complete
--

\unrestrict eA8GUTsya8ZNOVLyIBejLtTKihBLVap9yycFfTsLfLTavRkYgkd25NkMG4I3CwP

