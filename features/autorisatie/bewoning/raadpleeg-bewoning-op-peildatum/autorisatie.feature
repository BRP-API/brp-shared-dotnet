# language: nl

@autorisatie
Functionaliteit: autorisatie voor het gebruik van de API BewoningMetPeildatum
  Autorisatie voor het gebruik van de API gebeurt op twee niveau's:
  1. autorisatie van de gebruiker door de afnemende organisatie
  2. autorisatie van de afnemer (organisatie) door RvIG

  Deze feature beschrijft alleen de autorisatie van de afnemer door RvIG.

  Voorlopig wordt de Bewoning API alleen aangeboden aan gemeenten voor het raadplegen van adresseerbare object binnen de eigen gemeente.

  Autorisatie wordt verkregen met behulp van een OAuth 2 token. 
  Wanneer de afnemer een gemeente is, is er in de claims in het OAuth token ook een gemeentecode opgenomen. Deze wordt gebruikt om te bepalen of het bevraagde adres binnen de eigen gemeente ligt.
  Autorisatie voor bewoning wordt bepaald door de gemeente waar het gevraagde adresseerbaar object ligt in de gevraagde periode.
  Een afnemer is alleen geautoriseerd voor een vraag naar bewoning, wanneer in het antwoord op die vraag elke (mogelijke) bewoner in de periode van betreffende bewoning in de afnemer gemeente stond ingeschreven.


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


  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van bewoning waarbij voor de gevonden verblijfplaats de gemeente van inschrijving gelijk is aan de gemeentecode in de 'claim' uit de token

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

    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object binnen de gemeente en de bewoner is nu niet meer ingeschreven in de gemeente
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
    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object buiten de gemeente en de bewoner is nu wel ingeschreven in de gemeente
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

    Scenario: Vorige verblijf is in andere gemeente en aanvang verblijf is gedeeltelijk onbekend en de peildatum valt binnen de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230000                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2023-04-01           |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response 1 bewoning

    Scenario: Volgende verblijf is in andere gemeente en aanvang volgende verblijf is gedeeltelijk onbekend en de peildatum valt binnen de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20230000                           |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2023-04-01           |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response 1 bewoning


  Regel: Een gemeente als afnemer is geautoriseerd voor een antwoord wanneer het gevraagde adresseerbaar object niet bestaat

    Scenario: Het adresseerbaar object wordt niet gevonden en dus is er kan de gemeente van het adresseerbaarbaar object niet gelijk of ongelijk zijn aan de afnemer
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2023-04-01           |
      | adresseerbaarObjectIdentificatie | 1234010000123456     |
      Dan heeft de response 0 bewoningen

    @fout-case
    Scenario: Het adresseerbaar object wordt nog niet bewoond in de gevraagde periode en dus kan de gemeente van inschrijving van het verblijf in die periode niet gelijk of ongelijk zijn aan de afnemer (gemeentecode in token)
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
    Scenario: Het adresseerbaar object wordt niet meer bewoond in de gevraagde periode en dus kan de gemeente van inschrijving van het verblijf in die periode niet gelijk of ongelijk zijn aan de afnemer (gemeentecode in token)
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
    

  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van bewoning van een object dat na gemeentelijke herindeling is komen te liggen in gemeente van inschrijving die gelijk is aan de gemeentecode in de 'claim' uit de token

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


  Regel: Een gemeente als afnemer is geautoriseerd voor het vragen van bewoning van een object dat na gemeentelijke herindeling is komen te liggen in een andere gemeente, maar op een eerder moment de gemeente van inschrijving gelijk was aan de gemeentecode in de 'claim' uit de token
    
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


  Regel: Een gemeente als afnemer is geautoriseerd voor bewoning, wanneer de gemeente van inschrijving van een gevonden verblijfplaats ongelijk is aan gemeentecode in de token, maar deze gemeente van inschrijving heeft in de gemeententabel nieuwe gemeentecode (92.12) gelijk aan de gemeentecode in de token

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
