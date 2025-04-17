# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van partner velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                        |
        | partners                                      |
        | partners.aangaanHuwelijkPartnerschap          |
        | partners.aangaanHuwelijkPartnerschap.datum    |
        | partners.aangaanHuwelijkPartnerschap.land     |
        | partners.aangaanHuwelijkPartnerschap.plaats   |
        | partners.burgerservicenummer                  |
        | partners.geboorte                             |
        | partners.geboorte.datum                       |
        | partners.geboorte.land                        |
        | partners.geboorte.plaats                      |
        | partners.geslacht                             |
        | partners.naam                                 |
        | partners.naam.adellijkeTitelPredicaat         |
        | partners.naam.geslachtsnaam                   |
        | partners.naam.voorletters                     |
        | partners.naam.voornamen                       |
        | partners.naam.voorvoegsel                     |
        | partners.ontbindingHuwelijkPartnerschap       |
        | partners.ontbindingHuwelijkPartnerschap.datum |
        | partners.soortVerbintenis                     |

    @fout-case
    Abstract Scenario: een niet-bestaand partner veld wordt gevraagd met fields waarde '<fields>'
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
        | fields                                               |
        | partners.nietBestaand                                |
        | partners.aangaanHuwelijkPartnerschap.nietBestaand    |
        | partners.geboorte.nietBestaand                       |
        | partners.naam.nietBestaand                           |
        | partners.ontbindingHuwelijkPartnerschap.nietBestaand |

  Regel: alle velden van partners.aangaanHuwelijkPartnerschap.datum wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                                  |
        | partners.aangaanHuwelijkPartnerschap.datum.langFormaat  |
        | partners.aangaanHuwelijkPartnerschap.datum.type         |
        | partners.aangaanHuwelijkPartnerschap.datum.datum        |
        | partners.aangaanHuwelijkPartnerschap.datum.onbekend     |
        | partners.aangaanHuwelijkPartnerschap.datum.jaar         |
        | partners.aangaanHuwelijkPartnerschap.datum.maand        |
        | partners.aangaanHuwelijkPartnerschap.datum.nietBestaand |

  Regel: alle velden van partners.aangaanHuwelijkPartnerschap.land wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                                 |
        | partners.aangaanHuwelijkPartnerschap.land.code         |
        | partners.aangaanHuwelijkPartnerschap.land.omschrijving |
        | partners.aangaanHuwelijkPartnerschap.land.nietBestaand |

  Regel: alle velden van partners.aangaanHuwelijkPartnerschap.plaats wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                                   |
        | partners.aangaanHuwelijkPartnerschap.plaats.code         |
        | partners.aangaanHuwelijkPartnerschap.plaats.omschrijving |
        | partners.aangaanHuwelijkPartnerschap.plaats.nietBestaand |

  Regel: alle velden van partners.geboorte.datum wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                               |
        | partners.geboorte.datum.langFormaat  |
        | partners.geboorte.datum.langFormaat  |
        | partners.geboorte.datum.type         |
        | partners.geboorte.datum.datum        |
        | partners.geboorte.datum.onbekend     |
        | partners.geboorte.datum.jaar         |
        | partners.geboorte.datum.maand        |
        | partners.geboorte.datum.nietBestaand |

  Regel: alle velden van partners.geboorte.land wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                              |
        | partners.geboorte.land.code         |
        | partners.geboorte.land.omschrijving |
        | partners.geboorte.land.nietBestaand |

  Regel: alle velden van partners.geboorte.plaats wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                |
        | partners.geboorte.plaats.code         |
        | partners.geboorte.plaats.omschrijving |
        | partners.geboorte.plaats.nietBestaand |

  Regel: alle velden van partners.geslacht wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                         |
        | partners.geslacht.code         |
        | partners.geslacht.omschrijving |
        | partners.geslacht.nietBestaand |

  Regel: alle velden van partners.naam.adellijkeTitelPredicaat wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                             |
        | partners.naam.adellijkeTitelPredicaat.code         |
        | partners.naam.adellijkeTitelPredicaat.omschrijving |
        | partners.naam.adellijkeTitelPredicaat.soort        |
        | partners.naam.adellijkeTitelPredicaat.nietBestaand |

  Regel: alle velden van partners.ontbindingHuwelijkPartnerschap.datum wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                                     |
        | partners.ontbindingHuwelijkPartnerschap.datum.langFormaat  |
        | partners.ontbindingHuwelijkPartnerschap.datum.langFormaat  |
        | partners.ontbindingHuwelijkPartnerschap.datum.type         |
        | partners.ontbindingHuwelijkPartnerschap.datum.datum        |
        | partners.ontbindingHuwelijkPartnerschap.datum.onbekend     |
        | partners.ontbindingHuwelijkPartnerschap.datum.jaar         |
        | partners.ontbindingHuwelijkPartnerschap.datum.maand        |
        | partners.ontbindingHuwelijkPartnerschap.datum.nietBestaand |

  Regel: alle velden van partners.ontbindingHuwelijkPartnerschap.datum wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                 |
        | partners.soortVerbintenis.code         |
        | partners.soortVerbintenis.omschrijving |
        | partners.soortVerbintenis.nietBestaand |
