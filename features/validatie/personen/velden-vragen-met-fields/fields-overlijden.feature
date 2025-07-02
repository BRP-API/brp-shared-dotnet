# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van overlijden velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields            |
        | overlijden        |
        | overlijden.datum  |
        | overlijden.land   |
        | overlijden.plaats |

    @fout-case
    Scenario: een niet-bestaand overlijden veld wordt gevraagd met fields waarde 'overlijden.nietBestaand'
      Als 'overlijden.nietBestaand' wordt gevraagd van personen gezocht met burgerservicenummer
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

  Regel: alle velden van overlijden.datum wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                        |
        | overlijden.datum.langFormaat  |
        | overlijden.datum.type         |
        | overlijden.datum.datum        |
        | overlijden.datum.onbekend     |
        | overlijden.datum.jaar         |
        | overlijden.datum.maand        |
        | overlijden.datum.nietBestaand |

  Regel: alle velden van overlijden.land wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                       |
        | overlijden.land.code         |
        | overlijden.land.omschrijving |
        | overlijden.land.nietBestaand |

  Regel: alle velden van overlijden.plaats wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                         |
        | overlijden.plaats.code         |
        | overlijden.plaats.omschrijving |
        | overlijden.plaats.nietBestaand |
