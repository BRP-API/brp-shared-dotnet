# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van indicatie gezag minderjarige velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Scenario: het indicatieGezagMinderjarige veld wordt gevraagd met fields waarde 'indicatieGezagMinderjarige'
      Als 'indicatieGezagMinderjarige' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

    @fout-case
    Scenario: het indicatieGezagMinderjarige veld wordt gevraagd met fields waarde 'indicatieGezagMinderjarige' bij zoeken met '<zoek methode>'
      Als 'indicatieGezagMinderjarige' wordt gevraagd van personen gezocht met <zoek methode>
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
        | adresseerbaar object identificatie                    |
        | geslachtsnaam en geboortedatum                        |
        | geslachtsnaam, voornamen en gemeente van inschrijving |
        | nummeraanduiding identificatie                        |
        | postcode en huisnummer                                |
        | straatnaam, huisnummer en gemeente van inschrijving   |

  Regel: alle velden van indicatieGezagMinderjarige wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                  |
        | indicatieGezagMinderjarige.code         |
        | indicatieGezagMinderjarige.omschrijving |
        | indicatieGezagMinderjarige.nietBestaand |
