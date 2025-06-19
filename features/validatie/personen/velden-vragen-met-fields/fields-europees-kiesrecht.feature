# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van europees kiesrecht velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                 |
        | europeesKiesrecht                      |
        | europeesKiesrecht.aanduiding           |
        | europeesKiesrecht.einddatumUitsluiting |

    @fout-case
    Abstract Scenario: een niet-bestaand europees kiesrecht veld wordt gevraagd met fields waarde 'europeesKiesrecht.nietBestaand'
      Als 'europeesKiesrecht.nietBestaand' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response een foutmelding
        | naam     | waarde                                                      |
        | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
        | title    | Een of meerdere parameters zijn niet correct.               |
        | status   |                                                         400 |
        | detail   | De foutieve parameter(s) zijn: fields[0].                   |
        | code     | paramsValidation                                            |
        | instance | /haalcentraal/api/brp/personen                              |
      En parameter foutmeldingen
        | code   | name      | reason                                       |
        | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

  Regel: alle velden van europeesKiesrecht.aanduiding wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                    |
        | europeesKiesrecht.aanduiding.code         |
        | europeesKiesrecht.aanduiding.omschrijving |
        | europeesKiesrecht.aanduiding.nietBestaand |

  Regel: alle velden van europeesKiesrecht.aanduiding wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                              |
        | europeesKiesrecht.einddatumUitsluiting.langFormaat  |
        | europeesKiesrecht.einddatumUitsluiting.type         |
        | europeesKiesrecht.einddatumUitsluiting.datum        |
        | europeesKiesrecht.einddatumUitsluiting.onbekend     |
        | europeesKiesrecht.einddatumUitsluiting.jaar         |
        | europeesKiesrecht.einddatumUitsluiting.maand        |
        | europeesKiesrecht.einddatumUitsluiting.nietBestaand |
