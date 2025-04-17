# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van uitsluiting kiesrecht velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                       |
        | uitsluitingKiesrecht                         |
        | uitsluitingKiesrecht.einddatum               |
        | uitsluitingKiesrecht.uitgeslotenVanKiesrecht |

    @fout-case
    Scenario: een niet-bestaand veld wordt gevraagd met fields waarde 'uitsluitingKiesrecht.nietBestaand'
      Als 'uitsluitingKiesrecht.nietBestaand' wordt gevraagd van personen gezocht met burgerservicenummer
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

  Regel: alle velden van uitgesluitingKiesrecht.einddatum wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                      |
        | uitsluitingKiesrecht.einddatum.langFormaat  |
        | uitsluitingKiesrecht.einddatum.type         |
        | uitsluitingKiesrecht.einddatum.datum        |
        | uitsluitingKiesrecht.einddatum.onbekend     |
        | uitsluitingKiesrecht.einddatum.jaar         |
        | uitsluitingKiesrecht.einddatum.maand        |
        | uitsluitingKiesrecht.einddatum.nietBestaand |
