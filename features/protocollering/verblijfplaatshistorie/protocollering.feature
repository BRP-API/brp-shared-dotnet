#language: nl

@protocollering
Functionaliteit: Protocolleren van raadplegen van verblijfplaatshistorie
  Zoeken en raadplegen van gegevens van burgers worden "geprotocolleerd" (formeel gelogd).

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | straatnaam (11.10) |
      | 0530                 | 0530010000000001                         | Eerste straat      |
      En de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | pl_id |
      | 1001  |
      En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0530                              | 20000101                           |
      En de response van de downstream api heeft de volgende headers
      | x-geleverde-pls |
      | 1001            |
    
  
  Regel: Gebruikte parameters worden vertaald naar rubrieknummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.

    Scenario: Raadpleeg verblijfplaatshistorie met peildatum
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2023-05-26            |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken                 |
      | 010120, 081030, 081320, 581030, 581320 |

    Scenario: Raadpleeg verblijfplaatshistorie met periode
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken                 |
      | 010120, 081030, 081320, 581030, 581320 |

  Regel: Vragen om verblijfplaatshistorie wordt vastgelegd in het veld 'request_gevraagde_rubrieken' met virtuele rubriek PX.VP.07.

    Scenario: Raadpleeg verblijfplaatshistorie met peildatum
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2023-05-26            |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | PXVP07                      |

    Scenario: Raadpleeg verblijfplaatshistorie met periode
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | PXVP07                      |
