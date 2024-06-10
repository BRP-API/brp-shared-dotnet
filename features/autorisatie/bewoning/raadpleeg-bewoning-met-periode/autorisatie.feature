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
  Autorisatie voor bewoning wordt bepaald door de gemeente waar het gevraagde adresseerbaar object ligt.
 


    Achtergrond:
      Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID | gemeenteCode |
      | 000008    | 0800         |
      En adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | 0518010000000002                         |


  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van bewoning waarbij de gemeente van de gevonden verblijfplaats(en) gelijk is aan de gemeentecode van de afnemer.

    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object binnen de gemeente
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 1 bewoning

    @fout-case
    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object buiten de gemeente
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20041103                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0518010000000002   |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |

    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object binnen de gemeente waarvan de bewoner nu niet meer is ingeschreven in de gemeente
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20230526                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 1 bewoning

    @fout-case
    Scenario: Gemeente raadpleegt de bewoning van een adresseerbaar object buiten de gemeente waarvan de bewoner is nu wel ingeschreven in de gemeente
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20041103                           |
      En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230601                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0518010000000002   |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |

    Scenario: Gemeente raadpleegt de bewoning van een adresseerbaar object binnen de gemeente en de bewoner is binnen de periode verhuisd buiten de gemeente
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220526                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20220820                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 1 bewoning

    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object binnen de gemeente waarvan de bewoner binnen de periode is vertrokken naar het buitenland
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220526                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
      | 5010         | 20220820                               | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 1 bewoning

    Scenario: Vorige verblijf is in andere gemeente en aanvang verblijf is gedeeltelijk onbekend en de periode valt binnen de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230000                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2023-07-01         |
      | datumTot                         | 2023-08-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 1 bewoning

    Scenario: Volgende verblijf is in andere gemeente en aanvang volgende verblijf is gedeeltelijk onbekend en de periode valt binnen de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20230000                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2023-07-01         |
      | datumTot                         | 2023-08-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 1 bewoning


  Regel: Een gemeente als afnemer is geautoriseerd voor een bewoning wanneer het gevraagde adresseerbaar object niet bestaat

    Scenario: Het adresseerbaar object wordt niet gevonden, waardoor de gemeente van het adresseerbaarbaar object niet gelijk of ongelijk kan zijn aan de afnemer
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2010-01-01         |
      | datumTot                         | 2010-08-17         |
      | adresseerbaarObjectIdentificatie | 1234010000123456   |
      Dan heeft de response 0 bewoningen

    @fout-case
    Scenario: Het adresseerbaar object wordt nog niet bewoond in de gevraagde periode, waarmee de gemeente van inschrijving van het verblijf in die periode niet gelijk of ongelijk kan zijn aan gemeentecode van de afnemer
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20230701                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0518010000000002   |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |

    @fout-case
    Scenario: Het adresseerbaar object wordt niet meer bewoond in de gevraagde periode, waarmee de gemeente van inschrijving van het verblijf in die periode niet gelijk of ongelijk kan zijn aan de gemeentecode van de afnemer
      Gegeven adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0530                 | 0530010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20150701                           |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0530                              | 20210601                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0518010000000002   |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |
    

  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van bewoning van een object dat na gemeentelijke herindeling is komen te liggen in bevragende gemeente. 

    Abstract Scenario: Adres is na gemeentelijke herindeling in vragende gemeente komen te liggen en <omschrijving>
      Gegeven adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0530                 | 0530010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0530                              | 20100818                           |
      En adres 'A3' is op '2023-05-26' infrastructureel gewijzigd met de volgende gegevens
      | gemeentecode (92.10) |
      | 0800                 |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 0530010000000003   |
      Dan heeft de response 1 bewoning

      Voorbeelden:
      | datum van  | datum tot  | omschrijving                                            |
      | 2023-07-01 | 2023-08-01 | de periode ligt na de herindeling                       |
      | 2022-01-01 | 2023-01-01 | de periode ligt voor de herindeling                     |
      | 2023-01-01 | 2023-07-01 | de herindeling vindt plaats binnen de gevraagde periode |


  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van de bewoning van een object dat na gemeentelijke herindeling in een andere gemeente ligt, maar op een eerder moment wel in de bevragende gemeente lag.
    
    Abstract Scenario: Adres is na gemeentelijke herindeling in andere gemeente komen te liggen en <omschrijving>
      Gegeven adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En adres 'A3' is op '2023-05-26' infrastructureel gewijzigd met de volgende gegevens
      | gemeentecode (92.10) |
      | 0530                 |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 0800010000000003   |
      Dan heeft de response 1 bewoning

      Voorbeelden:
      | datum van  | datum tot  | omschrijving                                            |
      | 2023-07-01 | 2023-08-01 | de periode ligt na de herindeling                       |
      | 2022-01-01 | 2023-01-01 | de periode ligt voor de herindeling                     |
      | 2023-01-01 | 2023-07-01 | de herindeling vindt plaats binnen de gevraagde periode |


  Regel: Een gemeente als afnemer is geautoriseerd voor bewoning wanneer de gemeente van de gevonden verblijfplaats niet overeenkomt met de claim in het token, omdat de bevragende gemeente een nieuwe gemeentecode heeft gekregen (92.12) 

    Abstract Scenario: Adres ligt in samengevoegde gemeente en <scenario>
      Gegeven gemeente 'G1' heeft de volgende gegevens
      | gemeentecode (92.10) | gemeentenaam (92.11) |
      | 9999                 | Ons Dorp             |
      En adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 9999                 | 9999010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 9999                              | 20100818                           |
      En gemeente 'G1' is samengevoegd met de volgende gegevens
      | nieuwe gemeentecode (92.12) | datum beëindiging (99.99) |
      | 0800                        | 20230526                  |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 9999010000000003   |
      Dan heeft de response 1 bewoning

      Voorbeelden:
      | datum van  | datum tot  | scenario                                                                                                                                 |
      | 2023-07-01 | 2023-08-01 | periode ligt na datum samenvoeging (adresseerbaar object ligt in gemeente 0800)                                                          |
      | 2022-01-01 | 2023-01-01 | periode ligt voor datum samenvoeging (adresseerbaar object ligt in gemeente 9999)                                                        |
      | 2023-01-01 | 2023-08-01 | periode overlapt de datum samenvoeging (adresseerbaar object ligt een deel van de periode in gemeente 0800 en een deel in gemeente 9999) |
