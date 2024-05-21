#language: nl

Functionaliteit: test dat raadplegen verblijfplaatshistorie een correcte melding geeft bij een http method die niet ondersteund wordt

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | Teststraat         |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |

  Regel: Om privacy en security redenen moet een bevraging van verblijfplaatshistorie worden gedaan met behulp van de POST aanroep

    @fout-case
    Abstract Scenario: verblijfplaatshistorie wordt gezocht met een '<aanroep type>' aanroep
      Als verblijfplaatshistorie wordt gezocht met een '<aanroep type>' aanroep
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.5 |
      | title    | Gebruikte bevragingsmethode is niet toegestaan.             |
      | status   | 405                                                         |
      | code     | methodNotAllowed                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |

      Voorbeelden:
      | aanroep type |
      | GET          |
      | PUT          |
      | PATCH        |
      | DELETE       |
      | OPTIONS      |
      | TRACE        |
