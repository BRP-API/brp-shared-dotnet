# language: nl

@autorisatie
Functionaliteit: autorisatie voor het gebruik van de BRP API Bewoning met periode
  Autorisatie voor het gebruik van Bewoning gebeurt op twee niveau's:
  1. autorisatie van de gebruiker door de afnemende organisatie
  2. autorisatie van de afnemer (organisatie) door RvIG

  Deze feature beschrijft alleen de autorisatie van de afnemer door RvIG.

  De BRP API Bewoning wordt alleen aangeboden aan gemeenten voor het raadplegen de bewoning van adresseerbare object binnen de eigen gemeente.

  Autorisatie wordt verkregen met behulp van een OAuth 2 token. 
  Wanneer de afnemer een gemeente is, bevat het OAuth token een gemeentecode claim. Deze wordt gebruikt om te bepalen of het bevraagde adres binnen de eigen gemeente ligt.
  Een gemeente is geautoriseerd voor Bewoning als het adresseerbaar object waarvan de bewoning wordt gevraagd in de gemeente ligt, of ooit in de gemeente heeft gelegen.


    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | 0518010000000002                         |

  Regel: Alleen gemeenten zijn geautoriseerd voor het raadplegen van de bewoning van adresseerbare objecten

    @fout-case
    Scenario: De niet-gemeentelijke afnemer heeft geen autorisatie rubrieknummer AX.BW.01
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      |                                 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID |
      | 000008    |
      Als bewoningen wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0518010000000002   |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3 |
      | title    | U bent niet geautoriseerd voor deze vraag.                  |
      | status   | 403                                                         |
      | detail   | Alleen gemeenten mogen bewoningen raadplegen.               |
      | code     | unauthorized                                                |
      | instance | /haalcentraal/api/bewoning/bewoningen                       |

    Scenario: De niet-gemeentelijke afnemer heeft wel autorisatie rubrieknummer 'AX.BW.01'
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | AXBW01                          | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID |
      | 000008    |
      Als bewoningen wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0518010000000002   |
      Dan heeft de response 0 bewoningen

  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van de bewoning van een adresseerbaar object als het adresseerbaar object ooit in de gemeente van de afnemer heeft gelegen

    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object binnen de gemeente
      Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID | gemeenteCode |
      | 000008    | 0800         |
      Als bewoningen wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 0 bewoningen

    @fout-case
    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object buiten de gemeente
      Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID | gemeenteCode |
      | 000008    | 0800         |
      Als bewoningen wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0518010000000002   |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |


  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van bewoning van een adresseerbaar object dat niet bestaat of nog nooit bewoond is

    Scenario: Het adresseerbaar object wordt niet gevonden, waardoor de gemeente van het adresseerbaarbaar object niet gelijk of ongelijk kan zijn aan de afnemer
      Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID | gemeenteCode |
      | 000008    | 0800         |
      Als bewoningen wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2010-01-01         |
      | datumTot                         | 2010-08-17         |
      | adresseerbaarObjectIdentificatie | 1234010000123456   |
      Dan heeft de response 0 bewoningen
    

  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van bewoning van een object dat na gemeentelijke herindeling is komen te liggen in bevragende gemeente

    Abstract Scenario: Adres is na gemeentelijke herindeling in vragende gemeente komen te liggen en <omschrijving>
      Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID | gemeenteCode |
      | 000008    | 0800         |
      En adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0530                 | 0530010000000003                         |
      En adres 'A3' is op '2023-05-26' infrastructureel gewijzigd met de volgende gegevens
      | gemeentecode (92.10) |
      | 0800                 |
      Als bewoningen wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 0530010000000003   |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | datum van  | datum tot  | omschrijving                                            |
      | 2023-07-01 | 2023-08-01 | de periode ligt na de herindeling                       |
      | 2022-01-01 | 2023-01-01 | de periode ligt voor de herindeling                     |
      | 2023-01-01 | 2023-07-01 | de herindeling vindt plaats binnen de gevraagde periode |


  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van de bewoning van een object dat na gemeentelijke herindeling in een andere gemeente ligt, maar op een eerder moment wel in de bevragende gemeente lag
    
    Abstract Scenario: Adres is na gemeentelijke herindeling in andere gemeente komen te liggen en <omschrijving>
      Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID | gemeenteCode |
      | 000008    | 0800         |
      En adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000003                         |
      En adres 'A3' is op '2023-05-26' infrastructureel gewijzigd met de volgende gegevens
      | gemeentecode (92.10) |
      | 0530                 |
      Als bewoningen wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 0800010000000003   |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | datum van  | datum tot  | omschrijving                                                   |
      | 2023-07-01 | 2023-08-01 | de periode ligt na de herindeling                              |
      | 2022-01-01 | 2023-01-01 | de periode ligt voor de herindeling                            |
      | 2023-01-01 | 2023-07-01 | de herindeling vindt plaats binnen de gevraagde periode        |
      | 2024-05-01 | 2024-06-01 | bewoner in gevraagde periode is ingeschreven na de herindeling |


  Regel: Een gemeente als afnemer is geautoriseerd voor bewoning in een gemeente die is samengevoegd in afnemende gemeente
    Een afnemer is geautoriseerd voor bewoning wanneer in de gemeententabel bij de gemeentecode van het gevraagde adresseerbaar object
    een nieuwe gemeentecode (92.12) staat die gelijk is aan de gemeentecode in de claim.

    Abstract Scenario: Adres ligt in samengevoegde gemeente en <scenario>
      Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID | gemeenteCode |
      | 000008    | 0800         |
      En gemeente 'G1' heeft de volgende gegevens
      | gemeentecode (92.10) | gemeentenaam (92.11) |
      | 9999                 | Ons Dorp             |
      En adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 9999                 | 9999010000000003                         |
      En gemeente 'G1' is samengevoegd met de volgende gegevens
      | nieuwe gemeentecode (92.12) | datum beëindiging (99.99) |
      | 0800                        | 20230526                  |
      Als bewoningen wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 9999010000000003   |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | datum van  | datum tot  | scenario                                                                                                                                 |
      | 2023-07-01 | 2023-08-01 | periode ligt na datum samenvoeging (adresseerbaar object ligt in gemeente 0800)                                                          |
      | 2022-01-01 | 2023-01-01 | periode ligt voor datum samenvoeging (adresseerbaar object ligt in gemeente 9999)                                                        |
      | 2023-01-01 | 2023-08-01 | periode overlapt de datum samenvoeging (adresseerbaar object ligt een deel van de periode in gemeente 0800 en een deel in gemeente 9999) |
      | 2019-01-01 | 2020-01-01 | bewoner in gevraagde periode is vertrokken voor de samenvoeging                                                                          |
