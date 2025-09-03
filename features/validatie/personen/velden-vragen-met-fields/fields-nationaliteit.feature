# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van nationaliteit velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                |
        | nationaliteiten                       |
        | nationaliteiten.redenOpname           |
        | nationaliteiten.type                  |
        | nationaliteiten.datumIngangGeldigheid |
        | nationaliteiten.nationaliteit         |

    @fout-case
    Scenario: een niet-bestaand nationaliteit veld wordt gevraagd met fields waarde 'nationaliteiten.nietBestaand'
      Als 'nationaliteiten.nietBestaand' wordt gevraagd van personen gezocht met burgerservicenummer
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

  Regel: alle velden van nationaliteiten.redenOpname wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het nationaliteiten.redenOpname veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                   |
        | nationaliteiten.redenOpname.code         |
        | nationaliteiten.redenOpname.omschrijving |
        | nationaliteiten.redenOpname.nietBestaand |

  Regel: alle velden van nationaliteiten.datumIngangGeldigheid wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het nationaliteiten.datumIngangGeldigheid veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                             |
        | nationaliteiten.datumIngangGeldigheid.langFormaat  |
        | nationaliteiten.datumIngangGeldigheid.type         |
        | nationaliteiten.datumIngangGeldigheid.datum        |
        | nationaliteiten.datumIngangGeldigheid.onbekend     |
        | nationaliteiten.datumIngangGeldigheid.jaar         |
        | nationaliteiten.datumIngangGeldigheid.maand        |
        | nationaliteiten.datumIngangGeldigheid.nietBestaand |

  Regel: alle velden van nationaliteiten.nationaliteit wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het nationaliteiten.nationaliteit veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                     |
        | nationaliteiten.nationaliteit.code         |
        | nationaliteiten.nationaliteit.omschrijving |
        | nationaliteiten.nationaliteit.nietBestaand |
