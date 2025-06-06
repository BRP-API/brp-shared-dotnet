# language: nl
@stap-documentatie
Functionaliteit: Persoon is geadopteerd

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'
    En de 2e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '10000'
    En de 3e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '10001'

  Abstract Scenario: is geadopteerd door '[aanduiding]' als ouder [1 of 2]
    Gegeven de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P2                    |
    En de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000036 | P1                    |
    * 'P1' is geadopteerd door 'P2' als ouder <ouder type>
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie          | text                                                                                                                                                                        | values                                                      |
      | persoon-P2 | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                       |                                                           0 |
      |            | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                          |                                     9999,0,0,P,000000012,P2 |
      |            | kind-1             | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                               |                             9999,0,0,K,000000036,P1,1AQ0100 |
      | persoon-P1 | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                       |                                                           0 |
      |            | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                          |                                    10000,0,1,P,000000036,P1 |
      |            | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                               |                            10000,0,0,P,000000036,P1,1AQ0100 |
      |            | ouder-<ouder type> | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7,$8) | 10000,0,0,<ouder type>,000000012,P2,10 jaar geleden,1AQ0100 |

    Voorbeelden:
      | ouder type |
      |          1 |
      |          2 |

  Scenario: is geadopteerd door '[aanduiding]' als ouder [1 of 2] met de volgende gegevens
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    * 'P2' is geadopteerd door 'P1' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | aktenummer (81.20) |
      | gisteren - 5 jaar                                  |            2BR1211 |
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                        | values                                             |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                       |                                                  0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                          |                            9999,0,0,P,000000012,P1 |
      |            | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                               |                    9999,0,0,K,000000024,P2,1AQ0100 |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                       |                                                  0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                          |                           10000,0,1,P,000000024,P2 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                               |                   10000,0,0,P,000000024,P2,1AQ0100 |
      |            | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7,$8) | 10000,0,0,1,000000012,P1,gisteren - 5 jaar,2BR1211 |

  Scenario: is geadopteerd door personen als ouder 1 en ouder 2
    Gegeven de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P2                    |
    En de persoon 'P3' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P3                    |
    En de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000036 | P1                    |
    * is minderjarig
    * is geadopteerd door 'P2' als ouder 1
    * is geadopteerd door 'P3' als ouder 2
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                        | values                                              |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                       |                                                   0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                          |                             9999,0,0,P,000000012,P2 |
      |            | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,geboorte_datum,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7,$8)             |  9999,0,0,K,000000036,P1,gisteren - 17 jaar,1AQ0100 |
      | persoon-P3 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                       |                                                   0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                          |                            10000,0,0,P,000000024,P3 |
      |            | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,geboorte_datum,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7,$8)             | 10000,0,0,K,000000036,P1,gisteren - 17 jaar,1AQ0100 |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                       |                                                   0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,geboorte_datum) VALUES($1,$2,$3,$4,$5,$6,$7)                        |         10001,0,2,P,000000036,P1,gisteren - 17 jaar |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,geboorte_datum,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7,$8)             | 10001,0,1,P,000000036,P1,gisteren - 17 jaar,1AQ0100 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,geboorte_datum,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7,$8)             | 10001,0,0,P,000000036,P1,gisteren - 17 jaar,1AQ0100 |
      |            | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7,$8) |    10001,0,0,1,000000012,P2,10 jaar geleden,1AQ0100 |
      |            | ouder-2      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7,$8) |    10001,0,0,2,000000024,P3,10 jaar geleden,1AQ0100 |

  Scenario: is geadopteerd door '[aanduiding]' als ouder [1 of 2] met de volgende gegevens
    Gegeven de persoon 'P1' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | P1                    |
    En de persoon 'P2' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | P2                    |
    * 'P2' is geadopteerd door 'P1' als ouder 1 met de volgende gegevens
      | datum ingang familierechtelijke betrekking (62.10) | aktenummer (81.20) |
      | gisteren - 5 jaar                                  |            2BR1211 |
    En de adoptie van 'P2' is herroepen voor 'P1' als ouder 1
    Dan zijn de gegenereerde SQL statements
      | stap       | categorie    | text                                                                                                                                                                                       | values                                               |
      | persoon-P1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                      |                                                    0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                                                         |                              9999,0,0,P,000000012,P1 |
      |            | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                                              |                      9999,0,0,K,000000024,P2,1AQ0100 |
      | persoon-P2 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                      |                                                    0 |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6,$7)                                          |                           10000,0,2,P,000000024,P2,O |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6,$7,$8)                               |                   10000,0,1,P,000000024,P2,1AQ0100,O |
      |            | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,akte_nr) VALUES($1,$2,$3,$4,$5,$6,$7)                                              |                     10000,0,0,P,000000024,P2,1AR0200 |
      |            | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum,akte_nr,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9) | 10000,0,1,1,000000012,P1,gisteren - 5 jaar,2BR1211,O |
      |            | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam,familie_betrek_start_datum) VALUES($1,$2,$3,$4,$5,$6,$7)                           |             10000,0,0,1,000000012,P1,morgen - 2 jaar |
