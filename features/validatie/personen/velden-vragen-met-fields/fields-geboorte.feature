# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van geboorte velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields         | zoek methode                       |
        | geboorte       | adresseerbaar object identificatie |
        | geboorte.datum | geslachtsnaam en geboortedatum     |

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields          |
        | geboorte.land   |
        | geboorte.plaats |

    @fout-case
    Abstract Scenario: een niet-bestaand geboorte veld wordt gevraagd met fields waarde 'geboorte.nietBestaand'
      Als 'geboorte.nietBestaand' wordt gevraagd van personen gezocht met <zoek methode>
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
        | zoek methode                                          |
        | burgerservicenummer                                   |
        | adresseerbaar object identificatie                    |
        | geslachtsnaam en geboortedatum                        |
        | geslachtsnaam, voornamen en gemeente van inschrijving |
        | nummeraanduiding identificatie                        |
        | postcode en huisnummer                                |
        | straatnaam, huisnummer en gemeente van inschrijving   |

  Regel: alle velden van geboorte.datum wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                      | zoek methode                                          |
        | geboorte.datum.langFormaat  | burgerservicenummer                                   |
        | geboorte.datum.type         | geslachtsnaam, voornamen en gemeente van inschrijving |
        | geboorte.datum.datum        | nummeraanduiding identificatie                        |
        | geboorte.datum.onbekend     | postcode en huisnummer                                |
        | geboorte.datum.jaar         | straatnaam, huisnummer en gemeente van inschrijving   |
        | geboorte.datum.maand        | burgerservicenummer                                   |
        | geboorte.datum.nietBestaand | geslachtsnaam en geboortedatum                        |

  Regel: alle velden van geboorte.land wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                     |
        | geboorte.land.code         |
        | geboorte.land.omschrijving |
        | geboorte.land.nietBestaand |

  Regel: alle velden van geboorte.plaats wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                       |
        | geboorte.plaats.code         |
        | geboorte.plaats.omschrijving |
        | geboorte.plaats.nietBestaand |
