#language: nl

Functionaliteit: test dat raadplegen verblijfplaatshistorie een correcte melding geeft bij een onjuiste Content-Type header

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | Teststraat         |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |


  Regel: Voor de request body wordt als content type en charset respectievelijk alleen application/json en utf-8 ondersteund

    @fout-case
    Abstract Scenario: '<media type>' is opgegeven als Content-Type waarde bij RaadpleegMetPeildatum
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                 | waarde                |
      | type                 | RaadpleegMetPeildatum |
      | burgerservicenummer  | 000000012             |
      | peildatum            | 2024-01-01            |
      | header: Content-Type | <media type>          |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                       |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.13 |
      | title    | Media Type wordt niet ondersteund.                           |
      | detail   | Ondersteunde content type: application/json; charset=utf-8.  |
      | code     | unsupportedMediaType                                         |
      | status   | 415                                                          |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie         |

      Voorbeelden:
      | media type                       |
      | application/xml                  |
      | text/csv                         |
      | application/json; charset=cp1252 |
      | */*                              |
      | */*; charset=utf-8               |
      | */*;charset=utf-8                |

    @fout-case
    Abstract Scenario: '<media type>' is opgegeven als Content-Type waarde bij RaadpleegMetPeriode
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                 | waarde              |
      | type                 | RaadpleegMetPeriode |
      | burgerservicenummer  | 000000012           |
      | datumVan             | 2024-01-01          |
      | datumTot             | 2024-05-01          |
      | header: Content-Type | <media type>        |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                       |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.13 |
      | title    | Media Type wordt niet ondersteund.                           |
      | detail   | Ondersteunde content type: application/json; charset=utf-8.  |
      | code     | unsupportedMediaType                                         |
      | status   | 415                                                          |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie         |

      Voorbeelden:
      | media type                       |
      | application/xml                  |
      | text/csv                         |
      | application/json; charset=cp1252 |
      | */*                              |
      | */*; charset=utf-8               |
      | */*;charset=utf-8                |

    Abstract Scenario: '<media type>' is opgegeven als Content-Type waarde bij RaadpleegMetPeildatum
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                 | waarde                |
      | type                 | RaadpleegMetPeildatum |
      | burgerservicenummer  | 000000012             |
      | peildatum            | 2024-01-01            |
      | header: Content-Type | <media type>          |
      Dan heeft de response 1 verblijfplaats

      Voorbeelden:
      | media type                      |
      | application/json                |
      | application/json;charset=utf-8  |
      | application/json; charset=utf-8 |
      | application/json;charset=Utf-8  |
      | application/json; charset=UTF-8 |

    Abstract Scenario: '<media type>' is opgegeven als Content-Type waarde bij RaadpleegMetPeriode
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                 | waarde              |
      | type                 | RaadpleegMetPeriode |
      | burgerservicenummer  | 000000012           |
      | datumVan             | 2024-01-01          |
      | datumTot             | 2024-05-01          |
      | header: Content-Type | <media type>        |
      Dan heeft de response 1 verblijfplaats

      Voorbeelden:
      | media type                      |
      | application/json                |
      | application/json;charset=utf-8  |
      | application/json; charset=utf-8 |
      | application/json;charset=Utf-8  |
      | application/json; charset=UTF-8 |


  Regel: Voor de request body is application/json de default Content-Type waarde en is utf-8 de default charset waarde

    Scenario: Er is geen Content-Type header met waarde opgegeven bij RaadpleegMetPeildatum
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                 | waarde                |
      | type                 | RaadpleegMetPeildatum |
      | burgerservicenummer  | 000000012             |
      | peildatum            | 2024-01-01            |
      Dan heeft de response 1 verblijfplaats

    Scenario: Er is geen Content-Type header met waarde opgegeven bij RaadpleegMetPeriode
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                 | waarde              |
      | type                 | RaadpleegMetPeriode |
      | burgerservicenummer  | 000000012           |
      | datumVan             | 2024-01-01          |
      | datumTot             | 2024-05-01          |
      Dan heeft de response 1 verblijfplaats

    Scenario: Er is een lege waarde opgegeven voor de Content-Type header bij RaadpleegMetPeildatum
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                 | waarde                |
      | type                 | RaadpleegMetPeildatum |
      | burgerservicenummer  | 000000012             |
      | peildatum            | 2024-01-01            |
      | header: Content-Type |                       |
      Dan heeft de response 1 verblijfplaats

    Scenario: Er is een lege waarde opgegeven voor de Content-Type header bij RaadpleegMetPeriode
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                 | waarde              |
      | type                 | RaadpleegMetPeriode |
      | burgerservicenummer  | 000000012           |
      | datumVan             | 2024-01-01          |
      | datumTot             | 2024-05-01          |
      | header: Content-Type |                     |
      Dan heeft de response 1 verblijfplaats