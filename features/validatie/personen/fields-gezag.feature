# language: nl
@input-validatie
Functionaliteit:  gezag veld vragen met fields bij 'raadplegen met burgerservicenummer' en 'zoeken met adresseerbaar object identificatie'

  Regel: het is niet toegestaan om specifieke velden van het gezag veld te vragen

    Abstract Scenario: het gezag veld wordt gevraagd met fields waarde 'gezag'
      Als het 'gezag' veld van <zoek methode>
      Dan heeft de response 0 personen

      Voorbeelden:
        | zoek methode                                      |
        | een persoon wordt gevraagd                        |
        | personen ingeschreven op een adres wordt gevraagd |

    @fout-case
    Abstract Scenario: het gezag veld wordt gevraagd met fields waarde '<fields>'
      Als het '<fields>' veld van <zoek methode>
      Dan heeft de response de volgende gegevens
        | naam     | waarde                                                      |
        | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
        | title    | Een of meerdere parameters zijn niet correct.               |
        | status   |                                                         400 |
        | detail   | De foutieve parameter(s) zijn: fields[0].                   |
        | code     | paramsValidation                                            |
        | instance | /haalcentraal/api/brp/personen                              |
      En heeft de response invalidParams met de volgende gegevens
        | code   | name      | reason                                        |
        | fields | fields[0] | Parameter bevat een niet toegestane veldnaam. |

      Voorbeelden:
        | fields             | zoek methode                                      |
        | gezag.type         | een persoon wordt gevraagd                        |
        | gezag.minderjarige | personen ingeschreven op een adres wordt gevraagd |
        | gezag.ouders       | een persoon wordt gevraagd                        |
        | gezag.ouder        | personen ingeschreven op een adres wordt gevraagd |
        | gezag.derde        | een persoon wordt gevraagd                        |
        | gezag.derden       | personen ingeschreven op een adres wordt gevraagd |
        | gezag.toelichting  | een persoon wordt gevraagd                        |
        | gezag.nietBestaand | personen ingeschreven op een adres wordt gevraagd |
