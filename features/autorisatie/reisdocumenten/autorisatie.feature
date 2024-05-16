# language: nl

@autorisatie
Functionaliteit: autorisatie voor het gebruik van BRP API Reisdocumenten

  @fout-case
  Scenario: De response van een Reisdocumenten bevraging bevat geen x-geleverde-gemeentecodes header
    Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
    | naam         | waarde |
    | afnemerID    | 000008 |
    | gemeenteCode | 0800   |
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                | waarde                                                                     |
    | type                | ZoekMetBurgerservicenummer                                                 |
    | burgerservicenummer | 000000152                                                                  |
    | fields              | reisdocumentnummer,soort,datumEindeGeldigheid,inhoudingOfVermissing,houder |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                 |
    | title    | U bent niet geautoriseerd voor deze vraag.                                  |
    | status   | 403                                                                         |
    | detail   | Je mag alleen reisdocumenten van inwoners uit de eigen gemeente raadplegen. |
    | code     | unauthorized                                                                |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten                             |
