# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van (sub-velden) van het adressering veld

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als het '<fields>' veld wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                  | zoek methode                                          |
        | adressering             | adresseerbaar object identificatie                    |
        | adressering.adresregel1 | geslachtsnaam en geboortedatum                        |
        | adressering.adresregel2 | geslachtsnaam, voornamen en gemeente van inschrijving |
        | adressering.adresregel3 | nummeraanduiding identificatie                        |
        | adressering.land        | postcode en huisnummer                                |

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als het '<fields>' veld wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                    |
        | adressering                               |
        | adressering.adresregel1                   |
        | adressering.adresregel2                   |
        | adressering.adresregel3                   |
        | adressering.land                          |
        | adressering.aanhef                        |
        | adressering.aanschrijfwijze               |
        | adressering.aanschrijfwijze.aanspreekvorm |
        | adressering.aanschrijfwijze.naam          |
        | adressering.gebruikInLopendeTekst         |

    @fout-case
    Abstract Scenario: De fields parameter bevat een niet-bestaand adressering veld
      Als het '<fields>' veld wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response een foutmelding
        | naam     | waarde                                                      |
        | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
        | title    | Een of meerdere parameters zijn niet correct.               |
        | status   |                                                         400 |
        | detail   | De foutieve parameter(s) zijn: fields[0].                   |
        | code     | paramsValidation                                            |
        | instance | /haalcentraal/api/brp/personen                              |
      En de volgende invalidParams foutmeldingen
        | code   | name      | reason                                       |
        | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

      Voorbeelden:
        | fields                                  | zoek methode                       |
        | adressering.adresregels                 | burgerservicenummer                |
        | adressering.Aanhef                      | adresseerbaar object identificatie |
        | adressering.aanschrijfwijze.bestaatNiet | postcode en huisnummer             |

  Regel: alle velden van adressering.land wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als het '<fields>' veld wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                        | zoek methode                                        |
        | adressering.land.code         | burgerservicenummer                                 |
        | adressering.land.omschrijving | straatnaam, huisnummer en gemeente van inschrijving |
        | adressering.land.nietBestaand | adresseerbaar object identificatie                  |
