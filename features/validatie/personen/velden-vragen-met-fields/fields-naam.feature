# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van naam velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                       | zoek methode                                          |
        | naam                         | burgerservicenummer                                   |
        | naam.geslachtsnaam           | adresseerbaar object identificatie                    |
        | naam.volledigeNaam           | geslachtsnaam en geboortedatum                        |
        | naam.voorletters             | geslachtsnaam, voornamen en gemeente van inschrijving |
        | naam.voornamen               | nummeraanduiding identificatie                        |
        | naam.voorvoegsel             | straatnaam, huisnummer en gemeente van inschrijving   |
        | naam.adellijkeTitelPredicaat | postcode en huisnummer                                |

    Scenario: het naam.aanduidingNaamgebruik veld wordt gevraagd met fields waarde 'naam.aanduidingNaamgebruik'
      Als 'naam.aanduidingNaamgebruik' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

    @fout-case
    Scenario: een niet-bestaand naam veld wordt gevraagd met fields waarde 'naam.nietBestaand'
      Als 'naam.nietBestaand' wordt gevraagd van personen gezocht met <zoek methode>
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

  Regel: alle velden van naam.adellijkeTitelPredicaat wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het naam.adellijkeTitelPredicaat veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                    | zoek methode                                          |
        | naam.adellijkeTitelPredicaat.code         | adresseerbaar object identificatie                    |
        | naam.adellijkeTitelPredicaat.omschrijving | geslachtsnaam en geboortedatum                        |
        | naam.adellijkeTitelPredicaat.soort        | geslachtsnaam, voornamen en gemeente van inschrijving |
        | naam.adellijkeTitelPredicaat.nietBestaand | postcode en huisnummer                                |

  Regel: alle velden van naam.aanduidingNaamgebruik wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het naam.aanduidingNaamgebruik veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                  |
        | naam.aanduidingNaamgebruik.code         |
        | naam.aanduidingNaamgebruik.omschrijving |
        | naam.aanduidingNaamgebruik.nietBestaand |
