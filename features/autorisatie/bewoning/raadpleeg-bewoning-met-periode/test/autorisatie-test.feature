# language: nl

@autorisatie
Functionaliteit: test autorisatie bij combinatie infrastructurele wijziging en samenvoeging gemeente bij BewoningMetPeriode


    Achtergrond:
      Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID | gemeenteCode |
      | 000008    | 0800         |


    Abstract Scenario: Adres lag in samengevoegde gemeente en is na gemeentelijke herindeling in andere gemeente komen te liggen en <omschrijving periode>
      Gegeven gemeente 'G1' heeft de volgende gegevens
      | gemeentecode (92.10) | gemeentenaam (92.11) |
      | 9999                 | Ons Dorp             |
      En adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 9999                 | 0800010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 9999                              | 20100818                           |
      En gemeente 'G1' is samengevoegd met de volgende gegevens
      | nieuwe gemeentecode (92.12) | datum beëindiging (99.99) |
      | 0800                        | 20180730                  |
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
      | omschrijving periode                                            | datum van  | datum tot  |
      | periode ligt voor samenvoegen en voor infrastructureel wijzigen | 2015-01-01 | 2016-01-01 |
      | periode ligt na samenvoegen en voor infrastructureel wijzigen   | 2019-01-01 | 2020-01-01 |
      | periode ligt na samenvoegen en na infrastructureel wijzigen     | 2023-07-01 | 2024-01-01 |

    Abstract Scenario: Adres is na gemeentelijke herindeling in andere gemeente komen te liggen en gemeente is daarna samengevoegd en <omschrijving periode>
      Gegeven gemeente 'G1' heeft de volgende gegevens
      | gemeentecode (92.10) | gemeentenaam (92.11) |
      | 9999                 | Ons Dorp             |
      En adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 9999                 | 0800010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 9999                              | 20100818                           |
      En adres 'A3' is op '2018-07-30' infrastructureel gewijzigd met de volgende gegevens
      | gemeentecode (92.10) |
      | 0800                 |
      En gemeente 'G1' is samengevoegd met de volgende gegevens
      | nieuwe gemeentecode (92.12) | datum beëindiging (99.99) |
      | 0530                        | 20230526                  |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 0800010000000003   |
      Dan heeft de response 1 bewoning

      Voorbeelden:
      | omschrijving periode                                            | datum van  | datum tot  |
      | periode ligt voor samenvoegen en voor infrastructureel wijzigen | 2015-01-01 | 2016-01-01 |
      | periode ligt na samenvoegen en voor infrastructureel wijzigen   | 2019-01-01 | 2020-01-01 |
      | periode ligt na samenvoegen en na infrastructureel wijzigen     | 2023-07-01 | 2024-01-01 |

    Abstract Scenario: Adres is na gemeentelijke herindeling in andere gemeente komen te liggen en gemeente is daarna samengevoegd en <omschrijving periode>
      Gegeven gemeente 'G1' heeft de volgende gegevens
      | gemeentecode (92.10) | gemeentenaam (92.11) |
      | 0800                 | Ons Dorp             |
      En adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En adres 'A3' is op '2018-07-30' infrastructureel gewijzigd met de volgende gegevens
      | gemeentecode (92.10) |
      | 0530                 |
      En gemeente 'G1' is samengevoegd met de volgende gegevens
      | nieuwe gemeentecode (92.12) | datum beëindiging (99.99) |
      | 9999                        | 20230526                  |
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 0800010000000003   |
      Dan heeft de response 1 bewoning

      Voorbeelden:
      | omschrijving periode                                            | datum van  | datum tot  |
      | periode ligt voor samenvoegen en voor infrastructureel wijzigen | 2015-01-01 | 2016-01-01 |
      | periode ligt na samenvoegen en voor infrastructureel wijzigen   | 2019-01-01 | 2020-01-01 |
      | periode ligt na samenvoegen en na infrastructureel wijzigen     | 2023-07-01 | 2024-01-01 |
