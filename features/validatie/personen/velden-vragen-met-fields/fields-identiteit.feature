# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van identiteit velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het burgerservicenummer veld wordt gevraagd met fields waarde 'burgerservicenummer'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | zoek methode                                          |
        | burgerservicenummer                                   |
        | adresseerbaar object identificatie                    |
        | geslachtsnaam en geboortedatum                        |
        | geslachtsnaam, voornamen en gemeente van inschrijving |
        | nummeraanduiding identificatie                        |
        | postcode en huisnummer                                |
        | straatnaam, huisnummer en gemeente van inschrijving   |

    Abstract Scenario: het aNummer veld wordt gevraagd met fields waarde 'aNummer'
      Als 'aNummer' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

    @fout-case
    Abstract Scenario: het aNummer veld wordt gevraagd met fields waarde 'aNummer' bij zoeken met '<zoek methode>'
      Als 'aNummer' wordt gevraagd van personen gezocht met <zoek methode>
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
