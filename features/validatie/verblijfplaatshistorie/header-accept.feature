#language: nl

Functionaliteit: test dat raadplegen verblijfplaatshistorie een correcte melding geeft bij een onjuiste Accept header

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | Teststraat         |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |


  Regel: Voor de response body wordt als content type en charset respectievelijk alleen application/json en utf-8 ondersteund

    @fout-case
    Abstract Scenario: '<media type>' is opgegeven als Accept content type bij RaadpleegMetPeildatum
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2024-01-01            |
      | header: Accept      | application/xml       |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.6 |
      | title    | Gevraagde content type wordt niet ondersteund.              |
      | detail   | Ondersteunde content type: application/json; charset=utf-8. |
      | code     | notAcceptable                                               |
      | status   | 406                                                         |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |

      Voorbeelden:
      | media type                       |
      | application/xml                  |
      | text/csv                         |
      | application/json; charset=cp1252 |

    @fout-case
    Abstract Scenario: '<media type>' is opgegeven als Accept content type bij RaadpleegMetPeriode
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2024-01-01          |
      | datumTot            | 2024-05-01          |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.6 |
      | title    | Gevraagde content type wordt niet ondersteund.              |
      | detail   | Ondersteunde content type: application/json; charset=utf-8. |
      | code     | notAcceptable                                               |
      | status   | 406                                                         |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |

      Voorbeelden:
      | media type                       |
      | application/xml                  |
      | text/csv                         |
      | application/json; charset=cp1252 |

    @geen-protocollering
    Abstract Scenario: '<accept media type>' wordt opgegeven als Accept content type bij RaadpleegMetPeildatum
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2024-01-01            |
      | header: Accept      | <accept media type>   |
      Dan heeft de response 1 verblijfplaats

      Voorbeelden:
      | accept media type               |
      | */*                             |
      | */*; charset=utf-8              |
      | */*;charset=utf-8               |
      | application/json                |
      | application/json; charset=utf-8 |
      | application/json;charset=utf-8  |
      | */*;charset=UTF-8               |
      | application/json;charset=Utf-8  |
      | application/json; charset=UTF-8 |

    @geen-protocollering
    Abstract Scenario: '<accept media type>' wordt opgegeven als Accept content type bij RaadpleegMetPeriode
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2024-01-01          |
      | datumTot            | 2024-05-01          |
      | header: Accept      | <accept media type> |
      Dan heeft de response 1 verblijfplaats

      Voorbeelden:
      | accept media type               |
      | */*                             |
      | */*; charset=utf-8              |
      | */*;charset=utf-8               |
      | application/json                |
      | application/json; charset=utf-8 |
      | application/json;charset=utf-8  |
      | */*;charset=UTF-8               |
      | application/json;charset=Utf-8  |
      | application/json; charset=UTF-8 |


  Regel: Voor de response body is application/json de default Accept waarde en is utf-8 de default charset waarde

    @geen-protocollering
    Scenario: Er is geen Accept header met waarde opgegeven bij RaadpleegMetPeildatum
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2024-01-01            |
      Dan heeft de response 1 verblijfplaats

    @geen-protocollering
    Scenario: Er is geen Accept header met waarde opgegeven bij RaadpleegMetPeriode
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2024-01-01          |
      | datumTot            | 2024-05-01          |
      Dan heeft de response 1 verblijfplaats

    @geen-protocollering
    Scenario: Er is een lege waarde opgegeven voor de Accept header bij RaadpleegMetPeildatum
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2024-01-01            |
      | header: Accept      |                       |
      Dan heeft de response 1 verblijfplaats

    @geen-protocollering
    Scenario: Er is een lege waarde opgegeven voor de Accept header bij RaadpleegMetPeriode
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2024-01-01          |
      | datumTot            | 2024-05-01          |
      | header: Accept      |                     |
      Dan heeft de response 1 verblijfplaats
