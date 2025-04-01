# language: nl
@input-validatie
Functionaliteit: geldige 'adressering binnenland' fields waarden voor het vragen van adressering velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                            | zoek methode                                          |
        | adresseringBinnenland             | adresseerbaar object identificatie                    |
        | adresseringBinnenland.adresregel1 | geslachtsnaam en geboortedatum                        |
        | adresseringBinnenland.adresregel2 | geslachtsnaam, voornamen en gemeente van inschrijving |

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                              |
        | adresseringBinnenland                               |
        | adresseringBinnenland.adresregel1                   |
        | adresseringBinnenland.adresregel2                   |
        | adresseringBinnenland.aanhef                        |
        | adresseringBinnenland.aanschrijfwijze               |
        | adresseringBinnenland.aanschrijfwijze.aanspreekvorm |
        | adresseringBinnenland.aanschrijfwijze.naam          |
        | adresseringBinnenland.gebruikInLopendeTekst         |

    @fout-case
    Abstract Scenario: een niet-bestaand adressering veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met <zoek methode>
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
        | fields                                              | zoek methode                                          |
        | adresseringBinnenland.adresregels                   | burgerservicenummer                                   |
        | adresseringBinnenland.adresregel3                   | geslachtsnaam en geboortedatum                        |
        | adresseringBinnenland.land                          | postcode en huisnummer                                |
        | adresseringBinnenland.aanhef                        | adresseerbaar object identificatie                    |
        | adresseringBinnenland.aanschrijfwijze               | geslachtsnaam, voornamen en gemeente van inschrijving |
        | adresseringBinnenland.aanschrijfwijze.aanspreekvorm | nummeraanduiding identificatie                        |
        | adresseringBinnenland.aanschrijfwijze.naam          | straatnaam, huisnummer en gemeente van inschrijving   |
        | adresseringBinnenland.gebruikInLopendeTekst         | geslachtsnaam en geboortedatum                        |
