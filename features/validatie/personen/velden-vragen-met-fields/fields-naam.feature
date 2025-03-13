# language: nl
@input-validatie
Functionaliteit: naam velden vragen met fields

  Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
    Als het '<fields>' veld wordt gevraagd van personen gezocht met <zoek methode>
    Dan heeft de response 0 personen

    Voorbeelden:
      | fields             | zoek methode                                          |
      | naam               | burgerservicenummer                                   |
      | naam.geslachtsnaam | adresseerbaar object identificatie                    |
      | naam.volledigeNaam | geslachtsnaam en geboortedatum                        |
      | naam.voorletters   | geslachtsnaam, voornamen en gemeente van inschrijving |
      | naam.voornamen     | nummeraanduiding identificatie                        |
      | naam.voorvoegsel   | straatnaam, huisnummer en gemeente van inschrijving   |

  @fout-case
  Scenario: het naam.nietBestaand veld wordt gevraagd met fields waarde 'naam.nietBestaand'
    Als het 'naam.nietBestaand' veld wordt gevraagd van personen gezocht met <zoek methode>
    Dan heeft de response de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   |                                                         400 |
      | detail   | De foutieve parameter(s) zijn: fields[0].                   |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
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

  Regel: bij het vragen van naam.adellijkeTitelPredicaat of bestaande/niet-bestaande velden van naam.adellijkeTitelPredicaat wordt alle velden van naam.adellijkeTitelPredicaat geleverd

    Abstract Scenario: het naam.adellijkeTitelPredicaat veld wordt gevraagd met fields waarde '<fields>'
      Als het '<fields>' veld wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response 0 personen

      Voorbeelden:
        | fields                                    | zoek methode                                          |
        | naam.adellijkeTitelPredicaat              | burgerservicenummer                                   |
        | naam.adellijkeTitelPredicaat.code         | adresseerbaar object identificatie                    |
        | naam.adellijkeTitelPredicaat.omschrijving | geslachtsnaam en geboortedatum                        |
        | naam.adellijkeTitelPredicaat.soort        | geslachtsnaam, voornamen en gemeente van inschrijving |
        | naam.adellijkeTitelPredicaat.nietBestaand | postcode en huisnummer                                |

  Regel: bij het vragen van naam.aanduidingNaamgebruik of bestaande/niet-bestaande velden van naam.aanduidingNaamgebruik wordt alle velden van naam.aanduidingNaamgebruik geleverd

    Abstract Scenario: het naam.aanduidingNaamgebruik veld wordt gevraagd met fields waarde '<fields>'
      Als het '<fields>' veld wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response 0 personen

      Voorbeelden:
        | fields                                  |
        | naam.aanduidingNaamgebruik              |
        | naam.aanduidingNaamgebruik.code         |
        | naam.aanduidingNaamgebruik.omschrijving |
        | naam.aanduidingNaamgebruik.nietBestaand |
