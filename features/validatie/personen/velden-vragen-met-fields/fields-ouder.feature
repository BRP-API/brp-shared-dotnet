# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van ouder velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                         |
        | ouders                                         |
        | ouders.burgerservicenummer                     |
        | ouders.datumIngangFamilierechtelijkeBetrekking |
        | ouders.geboorte                                |
        | ouders.geboorte.datum                          |
        | ouders.geboorte.land                           |
        | ouders.geboorte.plaats                         |
        | ouders.geslacht                                |
        | ouders.naam                                    |
        | ouders.naam.adellijkeTitelPredicaat            |
        | ouders.naam.geslachtsnaam                      |
        | ouders.naam.voorletters                        |
        | ouders.naam.voornamen                          |
        | ouders.naam.voorvoegsel                        |
        | ouders.ouderAanduiding                         |

    @fout-case
    Abstract Scenario: De fields parameter bevat een niet-bestaand ouders veld
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
        | fields                       |
        | ouders.nietBestaand          |
        | ouders.geboorte.nietBestaand |
        | ouders.naam.nietBestaand     |

  Regel: alle velden van ouders.datumIngangFamilierechtelijkeBetrekking wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                                      |
        | ouders.datumIngangFamilierechtelijkeBetrekking.langFormaat  |
        | ouders.datumIngangFamilierechtelijkeBetrekking.type         |
        | ouders.datumIngangFamilierechtelijkeBetrekking.datum        |
        | ouders.datumIngangFamilierechtelijkeBetrekking.onbekend     |
        | ouders.datumIngangFamilierechtelijkeBetrekking.jaar         |
        | ouders.datumIngangFamilierechtelijkeBetrekking.maand        |
        | ouders.datumIngangFamilierechtelijkeBetrekking.nietBestaand |

  Regel: alle velden van ouders.geboorte.datum wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                             |
        | ouders.geboorte.datum.langFormaat  |
        | ouders.geboorte.datum.type         |
        | ouders.geboorte.datum.datum        |
        | ouders.geboorte.datum.onbekend     |
        | ouders.geboorte.datum.jaar         |
        | ouders.geboorte.datum.maand        |
        | ouders.geboorte.datum.nietBestaand |

  Regel: alle velden van ouders.geboorte.land wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                            |
        | ouders.geboorte.land.code         |
        | ouders.geboorte.land.omschrijving |
        | ouders.geboorte.land.nietBestaand |

  Regel: alle velden van ouders.geboorte.plaats wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                              |
        | ouders.geboorte.plaats.code         |
        | ouders.geboorte.plaats.omschrijving |
        | ouders.geboorte.plaats.nietBestaand |

  Regel: alle velden van ouders.geslacht wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                       |
        | ouders.geslacht.code         |
        | ouders.geslacht.omschrijving |
        | ouders.geslacht.nietBestaand |

  Regel: alle velden van ouders.naam.adellijkeTitelPredicaat wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                           |
        | ouders.naam.adellijkeTitelPredicaat.code         |
        | ouders.naam.adellijkeTitelPredicaat.omschrijving |
        | ouders.naam.adellijkeTitelPredicaat.soort        |
        | ouders.naam.adellijkeTitelPredicaat.nietBestaand |
