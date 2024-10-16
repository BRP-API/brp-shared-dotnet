#language: nl

@protocollering
Functionaliteit: Protocolleren van raadplegen van bewoning van een adresseerbaar object
  Zoeken en raadplegen van gegevens van burgers worden "geprotocolleerd" (formeel gelogd met als doel de burger te informeren 
  over welke instantie voor welke taak welke gegevens heeft geraadpleegd).

  Bij protocollering wordt voor elk request in 'request_zoek_rubrieken' vastgelegd welke parameters zijn gebruikt
  en in 'request_gevraagde_rubrieken' vastgelegd welke gegevens daarbij zijn gevraagd.
  Zowel bij bewoning op peildatum als bij bewoning in periode worden verblijfplaatsen gezocht met 
  adresseerbaarObjectIdentificatie (08.11.80) plus actuele en historische datum aanvang (08.10.30, 08.13.20, 58.10.30, 58.13.20).
  Aangezien bewoning altijd in zijn geheel wordt gevraagd -er is geen parameter fields- wordt bewoning
  als één rubriek opgenomen in 'request_gevraagde_rubrieken': AX.BW.01.

    Achtergrond:
      Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID | gemeenteCode |
      | 000008    | 0800         |
      En de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | pl_id |
      | 1001  |
      En de response van de downstream api heeft de volgende headers
      | x-geleverde-pls |
      | 1001            |


  Regel: Bewoning wordt geprotocolleerd

    Scenario: Raadpleeg bewoning op peildatum
      Als bewoningen wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-01-01           |
      | adresseerbaarObjectIdentificatie | 0518010000000002     |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken                 | request_gevraagde_rubrieken |
      | 081180, 081030, 081320, 581030, 581320 | AXBW01                      |

    Scenario: Raadpleeg bewoning met periode
      Als bewoningen wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2023-01-01         |
      | datumTot                         | 2024-01-01         |
      | adresseerbaarObjectIdentificatie | 0518010000000002   |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken                 | request_gevraagde_rubrieken |
      | 081180, 081030, 081320, 581030, 581320 | AXBW01                      |
