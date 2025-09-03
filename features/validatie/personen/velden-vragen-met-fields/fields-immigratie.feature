# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van immigratie velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                        |
        | immigratie                                    |
        | immigratie.datumVestigingInNederland          |
        | immigratie.indicatieVestigingVanuitBuitenland |
        | immigratie.landVanwaarIngeschreven            |
        | immigratie.vanuitVerblijfplaatsOnbekend       |

    @fout-case
    Scenario: het niet-bestaand immigratie veld wordt gevraagd met fields waarde 'immigratie.nietBestaand'
      Als 'immigratie.nietBestaand' wordt gevraagd van personen gezocht met burgerservicenummer
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

  Regel: alle velden van immigratie.datumVestigingInNederland wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                            |
        | immigratie.datumVestigingInNederland.langFormaat  |
        | immigratie.datumVestigingInNederland.type         |
        | immigratie.datumVestigingInNederland.datum        |
        | immigratie.datumVestigingInNederland.onbekend     |
        | immigratie.datumVestigingInNederland.jaar         |
        | immigratie.datumVestigingInNederland.maand        |
        | immigratie.datumVestigingInNederland.nietBestaand |

  Regel: alle velden van immigratie.landVanwaarIngeschreven wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                          |
        | immigratie.landVanwaarIngeschreven.code         |
        | immigratie.landVanwaarIngeschreven.omschrijving |
        | immigratie.landVanwaarIngeschreven.nietBestaand |
