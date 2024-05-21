#language: nl

Functionaliteit: test dat raadplegen historie met periode een correcte melding geeft bij een onjuiste aanroep

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | Teststraat         |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |


  Rule: burgerservicenummer is een verplichte parameter en met als waarde exact 9 cijfers van het burgerservicenummer van een persoon in de BRP

    @fout-case
    Scenario: De burgerservicenummer parameter is niet opgegeven
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | datumVan            | 2008-01-01          |
      | datumTot            | 2020-01-01          |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name                | reason                  |
      | required | burgerservicenummer | Parameter is verplicht. |

    @fout-case
    Abstract Scenario: zoek met onjuiste waarde voor parameter burgerservicenummer
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeriode   |
      | burgerservicenummer | <burgerservicenummer> |
      | datumVan            | 2008-01-01            |
      | datumTot            | 2020-01-01            |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code    | name                | reason                                      |
      | pattern | burgerservicenummer | Waarde voldoet niet aan patroon ^[0-9]{9}$. |

      Voorbeelden:
      | burgerservicenummer |
      | 12345678            |
      | 1234567890          |
      | A                   |
      | 12345678A           |
      | 123456789A          |
      | 1234 6789           |
      | 123456789+          |
      | 1234.67890          |
      |                     |


  Rule: bij RaadpleegMetPeriode is datumVan een verplichte parameter in RFC 3339 (yyyy-mm-dd) formaat

    @fout-case
    Scenario: De datumVan parameter is niet opgegeven
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumTot            | 2020-01-01          |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: datumVan.                    |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name     | reason                  |
      | required | datumVan | Parameter is verplicht. |

    @fout-case
    Scenario: De datumVan parameter is leeg
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            |                     |
      | datumTot            | 2020-01-01          |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: datumVan.                    |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name     | reason                  |
      | required | datumVan | Parameter is verplicht. |

    @fout-case
    Abstract Scenario: De datumVan parameter heeft een ongeldige waarde
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | 2020-01-01          |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: datumVan.                    |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code | name     | reason                        |
      | date | datumVan | Waarde is geen geldige datum. |

      Voorbeelden:
      | datum van      |
      | 20190101       |
      | 01/02/2019     |
      | 1 januari 2019 |
      | 2019-1-1       |
      | 2019-01-001    |
      | 2019-01-01-    |
      | -2019-01-01    |
      | 2019-13-01     |
      | 2019-06-31     |
      | 2019-02-29     |
      | 2021-00-00     |
      | 0000-00-00     |
      | --             |
      | - -            |

  Rule: bij RaadpleegMetPeriode is datumTot een verplichte parameter in RFC 3339 (yyyy-mm-dd) formaat

    @fout-case
    Scenario: De datumTot parameter is niet opgegeven
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2020-01-01          |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: datumTot.                    |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name     | reason                  |
      | required | datumTot | Parameter is verplicht. |

    @fout-case
    Scenario: De datumTot parameter is leeg
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2020-01-01          |
      | datumTot            |                     |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: datumTot.                    |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name     | reason                  |
      | required | datumTot | Parameter is verplicht. |

    @fout-case
    Abstract Scenario: De datumTot parameter heeft een ongeldige waarde
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2018-01-01          |
      | datumTot            | <datum tot>         |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: datumTot.                    |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code | name     | reason                        |
      | date | datumTot | Waarde is geen geldige datum. |

      Voorbeelden:
      | datum tot      |
      | 20190101       |
      | 01/02/2019     |
      | 1 januari 2019 |
      | 2019-1-1       |
      | 2019-01-001    |
      | 2019-01-01-    |
      | -2019-01-01    |
      | 2019-13-01     |
      | 2019-06-31     |
      | 2019-02-29     |
      | 2021-00-00     |
      | 0000-00-00     |
      | 01-01-2019     |
      | --             |
      | - -            |

  Rule: datumTot moet na datumVan liggen

    @fout-case
    Abstract Scenario: De datumTot parameter ligt niet na datumVan
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | <datum tot>         |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: datumTot.                    |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code | name     | reason                            |
      | date | datumTot | datumTot moet na datumVan liggen. |

      Voorbeelden:
      | datum van  | datum tot  |
      | 2020-01-01 | 2019-12-31 |
      | 2020-10-14 | 2020-10-14 |
      | 2020-03-01 | 2020-02-29 |

  
  Rule: Alleen gespecificeerde parameters bij het opgegeven raadpleeg type mogen worden gebruikt

    @fout-case
    Abstract Scenario: De peildatum parameter is gebruikt bij RaadpleegMetPeriode
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2020-01-01          |
      | datumTot            | 2021-01-01          |
      | peildatum           | <peildatum>         |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: peildatum.                   |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code         | name      | reason                      |
      | unknownParam | peildatum | Parameter is niet verwacht. |

      Voorbeelden:
      | peildatum  |
      | 2019-01-01 |
      | 2020-01-01 |
      | 2020-07-01 |
      | 2021-01-01 |
      | 2021-07-01 |

    @fout-case
    Abstract Scenario: Een niet gespecificeerde parameter is gebruikt bij RaadpleegMetPeriode
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2020-01-01          |
      | datumTot            | 2021-01-01          |
      | <parameter>         | <waarde>            |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: <parameter>.                 |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code         | name        | reason                      |
      | unknownParam | <parameter> | Parameter is niet verwacht. |

      Voorbeelden:
      | parameter                         | waarde              |
      | iets                              | geks                |
      | gemeenteVanInschrijving           | 0530                |
      | geheimhouding                     | true                |
      | fields                            | burgerservicenummer |
      | adresseerbaarObjectIdentificatie  | 0800010000000001    |
      | exclusiefVerblijfplaatsBuitenland | true                |
