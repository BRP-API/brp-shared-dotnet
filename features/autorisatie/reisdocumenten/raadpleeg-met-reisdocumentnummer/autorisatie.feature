# language: nl

@autorisatie
Functionaliteit: autorisatie voor het gebruik van de API RaadpleegMetReisdocumentnummer
  Autorisatie voor het gebruik van de API gebeurt op twee niveau's:
  1. autorisatie van de gebruiker door de afnemende organisatie
  2. autorisatie van de afnemer (organisatie) door RvIG

  Deze feature beschrijft alleen de autorisatie van de afnemer door RvIG.

  Voorlopig wordt de reisdocumenten bevragen API alleen aangeboden aan gemeenten voor het raadplegen van reisdocumenten van eigen inwoners.

  Autorisatie wordt verkregen met behulp van een OAuth 2 token. 
  In het verkregen token is de afnemerindicatie opgenomen die de afnemer uniek identificeert. Op basis van de afnemerindicatie kan de autorisatie worden opgezocht.
  Wanneer de afnemer een gemeente is, is er ook een gemeentecode opgenomen in de OAuth token. Deze wordt gebruikt om te bepalen of een eigen inwoner houder is van het gevraagde reisdocument.

  Voor één afnemer kunnen er meerdere rijen zijn in de autorisatietabel, maar daarvan kan er maar één actueel zijn. Alleen de actuele mag worden gebruikt.
  Een autorisatie is actueel wanneer de Datum ingang (35.99.98) in het verleden ligt en Datum beëindiging tabelregel (35.99.99) leeg is of in de toekomst ligt.

  # To Do (t.z.t.): regels voor autorisatie op basis van een autorisatiebesluit
  # To Do (t.z.t.): regels voor leveren persoonsgegevens met geheimhouding aan derde (35.95.12)
  # To Do (t.z.t.): regels voor voorwaarderegel ad hoc (35.95.61)

  Regel: Een gemeente als afnemer is geautoriseerd voor alle zoekvragen en alle gegevens voor haar eigen inwoners
         'gemeentecode' claim komt overeen met 'gemeente van inschrijving' van houder

    @fout-case
    Scenario: afnemer is geen gemeente
      Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID |
      | 000008    |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam               | waarde                         |
      | type               | RaadpleegMetReisdocumentnummer |
      | reisdocumentnummer | NE3663258                      |
      | fields             | reisdocumentnummer             |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                 |
      | title    | U bent niet geautoriseerd voor deze vraag.                                  |
      | status   | 403                                                                         |
      | detail   | Je mag alleen reisdocumenten van inwoners uit de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                |
      | instance | /haalcentraal/api/reisdocumenten/reisdocumenten                             |

    @geen-protocollering
    Scenario: afnemer is een gemeente en raadpleegt een reisdocument van een eigen inwoner
      Gegeven de response van de downstream api heeft de volgende body
      """
      {
        "reisdocumenten": [
          {
            "houder": {
              "gemeenteVanInschrijving": {
                "code": "0800"
              }
            }
          }
        ]
      }
      """
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID | gemeenteCode |
      | 000008    | 0800         |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam               | waarde                         |
      | type               | RaadpleegMetReisdocumentnummer |
      | reisdocumentnummer | NE3663258                      |
      | fields             | reisdocumentnummer             |
      Dan heeft de response een reisdocument zonder gegevens

    @fout-case
    Scenario: Gemeente raadpleegt een reisdocument van een inwoner van een andere gemeente
      Gegeven de response van de downstream api heeft de volgende body
      """
      {
        "reisdocumenten": [
          {
            "houder": {
              "gemeenteVanInschrijving": {
                "code": "0800"
              }
            }
          }
        ]
      }
      """
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0599   |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam               | waarde                         |
      | type               | RaadpleegMetReisdocumentnummer |
      | reisdocumentnummer | NE3663258                      |
      | fields             | reisdocumentnummer             |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                 |
      | title    | U bent niet geautoriseerd voor deze vraag.                                  |
      | status   | 403                                                                         |
      | detail   | Je mag alleen reisdocumenten van inwoners uit de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                |
      | instance | /haalcentraal/api/reisdocumenten/reisdocumenten                             |
