# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van verblijfstitel velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                     |
        | verblijfstitel             |
        | verblijfstitel.aanduiding  |
        | verblijfstitel.datumEinde  |
        | verblijfstitel.datumIngang |

    @fout-case
    Scenario: een niet-bestaand verblijfstitel veld wordt gevraagd met fields waarde 'verblijfstitel.nietBestaand'
      Als 'verblijfstitel.nietBestaand' wordt gevraagd van personen gezocht met burgerservicenummer
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

  Regel: alle velden van verblijfstitel.aanduiding wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                 |
        | verblijfstitel.aanduiding.code         |
        | verblijfstitel.aanduiding.omschrijving |
        | verblijfstitel.aanduiding.nietBestaand |

  Regel: alle velden van verblijfstitel.datumEinde wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                 |
        | verblijfstitel.datumEinde.langFormaat  |
        | verblijfstitel.datumEinde.type         |
        | verblijfstitel.datumEinde.datum        |
        | verblijfstitel.datumEinde.onbekend     |
        | verblijfstitel.datumEinde.jaar         |
        | verblijfstitel.datumEinde.maand        |
        | verblijfstitel.datumEinde.nietBestaand |

  Regel: alle velden van verblijfstitel.datumEinde wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                  |
        | verblijfstitel.datumIngang.langFormaat  |
        | verblijfstitel.datumIngang.type         |
        | verblijfstitel.datumIngang.datum        |
        | verblijfstitel.datumIngang.onbekend     |
        | verblijfstitel.datumIngang.jaar         |
        | verblijfstitel.datumIngang.maand        |
        | verblijfstitel.datumIngang.nietBestaand |
