# language: nl
@input-validatie
Functionaliteit: adressering velden vragen met fields

  Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
    Als het '<fields>' veld wordt gevraagd van personen gezocht met burgerservicenummer
    Dan heeft de response 0 personen

    Voorbeelden:
      | fields                                    |
      | adressering                               |
      | adressering.adresregel1                   |
      | adressering.adresregel2                   |
      | adressering.adresregel3                   |
      | adressering.aanhef                        |
      | adressering.aanschrijfwijze               |
      | adressering.aanschrijfwijze.aanspreekvorm |
      | adressering.aanschrijfwijze.naam          |
      | adressering.gebruikInLopendeTekst         |

  @fout-case
  Abstract Scenario: De fields parameter bevat een niet-bestaand adressering veld
    Als het '<fields>' veld wordt gevraagd van personen gezocht met burgerservicenummer
    Dan heeft de response de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   |                                                         400 |
      | detail   | De foutieve parameter(s) zijn: fields[0].                   |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
      | code   | name      | reason                                       |
      | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

    Voorbeelden:
      | fields                                  |
      | adressering.bestaatNiet                 |
      | adressering.aanschrijfwijze.bestaatNiet |

  Regel: bij het vragen van adressering.land of bestaande/niet-bestaande velden van adressering.land wordt alle velden van adressering.land geleverd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als het '<fields>' veld wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response 0 personen

      Voorbeelden:
        | fields                        |
        | adressering.land              |
        | adressering.land.code         |
        | adressering.land.omschrijving |
        | adressering.land.nietBestaand |
