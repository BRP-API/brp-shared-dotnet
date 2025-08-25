# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van kind velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                |
        | kinderen                              |
        | kinderen.burgerservicenummer          |
        | kinderen.geboorte                     |
        | kinderen.geboorte.datum               |
        | kinderen.geboorte.land                |
        | kinderen.geboorte.plaats              |
        | kinderen.naam                         |
        | kinderen.naam.adellijkeTitelPredicaat |
        | kinderen.naam.geslachtsnaam           |
        | kinderen.naam.voorletters             |
        | kinderen.naam.voornamen               |
        | kinderen.naam.voorvoegsel             |

    @fout-case
    Abstract Scenario: een niet-bestaand veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
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

      Voorbeelden:
        | fields                         |
        | kinderen.nietBestaand          |
        | kinderen.geboorte.nietBestaand |
        | kinderen.naam.nietBestaand     |

  Regel: alle velden van kinderen.geboorte.datum wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                               |
        | kinderen.geboorte.datum.langFormaat  |
        | kinderen.geboorte.datum.type         |
        | kinderen.geboorte.datum.datum        |
        | kinderen.geboorte.datum.onbekend     |
        | kinderen.geboorte.datum.jaar         |
        | kinderen.geboorte.datum.maand        |
        | kinderen.geboorte.datum.nietBestaand |

  Regel: alle velden van kinderen.geboorte.land wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                              |
        | kinderen.geboorte.land.code         |
        | kinderen.geboorte.land.omschrijving |
        | kinderen.geboorte.land.nietBestaand |

  Regel: alle velden van kinderen.geboorte.plaats wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                |
        | kinderen.geboorte.plaats.code         |
        | kinderen.geboorte.plaats.omschrijving |
        | kinderen.geboorte.plaats.nietBestaand |

  Regel: alle velden van kinderen.naam.adellijkeTitelPredicaat wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                             |
        | kinderen.naam.adellijkeTitelPredicaat.code         |
        | kinderen.naam.adellijkeTitelPredicaat.omschrijving |
        | kinderen.naam.adellijkeTitelPredicaat.soort        |
        | kinderen.naam.adellijkeTitelPredicaat.nietBestaand |
