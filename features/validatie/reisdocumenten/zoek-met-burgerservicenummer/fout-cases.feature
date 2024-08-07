#language: nl

@input-validatie
Functionaliteit: Zoek met burgerservicenummer - fout cases

Regel: De burgerservicenummer parameter is een verplichte parameter

  @fout-case
  Scenario: De burgerservicenummer parameter is niet opgegeven
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam   | waarde                     |
    | type   | ZoekMetBurgerservicenummer |
    | fields | reisdocumentnummer         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name                | reason                  |
    | required | burgerservicenummer | Parameter is verplicht. |


Regel: Een burgerservicenummer is een string bestaande uit exact 9 cijfers

  @fout-case
  Abstract Scenario: <titel>
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                | waarde                     |
    | type                | ZoekMetBurgerservicenummer |
    | burgerservicenummer | <burgerservicenummer>      |
    | fields              | reisdocumentnummer         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name                | reason                                      |
    | pattern | burgerservicenummer | Waarde voldoet niet aan patroon ^[0-9]{9}$. |

    Voorbeelden:
    | burgerservicenummer | titel                                                                       |
    | 12345678            | De opgegeven burgerservicenummer is een string met minder dan negen cijfers |
    | 1234567890          | De opgegeven burgerservicenummer is een string met meer dan negen cijfers   |
    | 12345678X           | De opgegeven burgerservicenummer is een string met een letter               |

Regel: Alleen gespecificeerde parameters bij het opgegeven zoektype mogen worden gebruikt

  @fout-case
  Abstract Scenario: <titel>
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                | waarde                     |
    | type                | ZoekMetBurgerservicenummer |
    | burgerservicenummer | 123456789                  |
    | <parameter>         | <waarde>                   |
    | fields              | reisdocumentnummer         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: <parameter>.                 |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft de response invalidParams met de volgende gegevens
    | code         | name        | reason                      |
    | unknownParam | <parameter> | Parameter is niet verwacht. |

    Voorbeelden:
    | titel                                     | parameter          | waarde    |
    | zoeken met parameter uit ander zoektype   | reisdocumentnummer | AB1234567 |
    | zoeken met niet gespecificeerde parameter | geslachtsnaam      | Jansen    |

  Regel: geheimhoudingPersoonsgegevens mag niet worden gevraagd, omdat het automatisch wordt geleverd

    @fout-case
    Abstract Scenario: veld geheimhoudingPersoonsgegevens mag niet worden gevraagd, omdat het automatisch wordt geleverd
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000152                  |
      | fields              | <fields>                   |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: fields[<index>].             |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
      En heeft de response invalidParams met de volgende gegevens
      | code   | name            | reason                                        |
      | fields | fields[<index>] | Parameter bevat een niet toegestane veldnaam. |

      Voorbeelden:
      | fields                                                                             | index |
      | houder.geheimhoudingPersoonsgegevens                                               | 0     |
      | reisdocumentnummer,houder.geheimhoudingPersoonsgegevens,houder.burgerservicenummer | 1     |
      | soort,inhoudingOfVermissing.datum,houder.geheimhoudingPersoonsgegevens             | 2     |
