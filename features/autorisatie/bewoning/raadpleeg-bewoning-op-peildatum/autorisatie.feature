# language: nl

@autorisatie
Functionaliteit: autorisatie voor het gebruik van de BRP API Bewoning met peildatum
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


  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van de bewoning van een adresseerbaar object als het adresseerbaar object ooit in de gemeente van de afnemer heeft gelegen

    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object binnen de gemeente
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-01-01           |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response 1 bewoning

    @fout-case
    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object buiten de gemeente
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20041103                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-01-01           |
      | adresseerbaarObjectIdentificatie | 0518010000000002     |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |


  Regel: De gemeente waar het adresseerbaar object in ligt kan worden bepaald uit bewoning voor of na de gevraagde peildatum

    @fout-case
    Scenario: Het adresseerbaar object wordt nog niet bewoond op de peildatum, maar is daarna wel bewoond
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20230701                           |
      Als bewoning wordt gezocht met de volgende parameters
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2023-04-01           |
      | adresseerbaarObjectIdentificatie | 0518010000000002     |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |

    @fout-case
    Scenario: Het adresseerbaar object wordt nog niet bewoond op de peildatum, maar is daarvoor wel bewoond
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
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2023-04-01           |
      | adresseerbaarObjectIdentificatie | 0518010000000002     |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |


  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van bewoning van een adresseerbaar object dat niet bestaat of nog nooit bewoond is

    Scenario: Het adresseerbaar object wordt niet gevonden, waardoor de gemeente van het adresseerbaarbaar object niet gelijk of ongelijk kan zijn aan de afnemer
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2023-04-01           |
      | adresseerbaarObjectIdentificatie | 1234010000123456     |
      Dan heeft de response 0 bewoningen


  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van bewoning van een object dat na gemeentelijke herindeling is komen te liggen in bevragende gemeente

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
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0530010000000003     |
      Dan heeft de response 1 bewoning

      Voorbeelden:
      | peildatum  | omschrijving                                       |
      | 2023-07-01 | de peildatum ligt na de herindeling                |
      | 2022-01-01 | de peildatum ligt voor de herindeling              |
      | 2023-05-26 | de herindeling vindt plaats op gevraagde peildatum |


  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van de bewoning van een object dat na gemeentelijke herindeling in een andere gemeente ligt, maar op een eerder moment wel in de bevragende gemeente lag
    
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
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000003     |
      Dan heeft de response 1 bewoning

      Voorbeelden:
      | peildatum  | omschrijving                                       |
      | 2023-07-01 | de peildatum ligt na de herindeling                |
      | 2022-01-01 | de peildatum ligt voor de herindeling              |
      | 2023-05-26 | de herindeling vindt plaats op gevraagde peildatum |


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
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 9999010000000003     |
      Dan heeft de response 1 bewoning

      Voorbeelden:
      | peildatum  | scenario                                                                            |
      | 2023-07-01 | peildatum ligt na datum samenvoeging (adresseerbaar object ligt in gemeente 0800)   |
      | 2022-01-01 | peildatum ligt voor datum samenvoeging (adresseerbaar object ligt in gemeente 9999) |


  Regel: De actuele gemeente van inschrijving van bewoners is niet relevant

    Scenario: Gemeente raadpleegt de bewoning van een adresseerbaar object binnen de gemeente waarvan de bewoner nu niet meer is ingeschreven in de gemeente
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20230526                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-01-01           |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
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
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-01-01           |
      | adresseerbaarObjectIdentificatie | 0518010000000002     |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |