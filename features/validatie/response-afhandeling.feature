#language: nl

Functionaliteit: correcte afhandeling van een downstream api response

  Regel: Een downstream api response met status 500 wordt als interne server fout geleverd

    @fout-case
    Scenario: de aanroep van een downstream api resulteert in een 500 response 
      Gegeven de response van de downstream api heeft de volgende headers
      | status | Content-Type             |
      | 500    | application/problem+json |
      En de response van de downstream api heeft de volgende body
      """
      {
          "type": "https://datatracker.ietf.org/doc/html/rfc7231#section-6.6.1",
          "title": "Name or service not known (gezag-api:8080)",
          "status": 500,
          "detail": "Name or service not known",
          "instance": "/haalcentraal/api/brp/personen",
          "code": "serverError"
      }
      """
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.6.1 |
      | title    | Internal Server error.                                      |
      | status   | 500                                                         |
      | instance | /haalcentraal/api/brp/personen                              |
