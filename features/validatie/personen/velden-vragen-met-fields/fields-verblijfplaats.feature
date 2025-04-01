# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van verblijfplaats velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                               |
        | verblijfplaats                                       |
        | verblijfplaats.type                                  |
        | verblijfplaats.datumIngangGeldigheid                 |
        | verblijfplaats.datumVan                              |
        | verblijfplaats.verblijfadres                         |
        | verblijfplaats.verblijfadres.land                    |
        | verblijfplaats.verblijfadres.regel1                  |
        | verblijfplaats.verblijfadres.regel2                  |
        | verblijfplaats.verblijfadres.regel3                  |
        | verblijfplaats.adresseerbaarObjectIdentificatie      |
        | verblijfplaats.functieAdres                          |
        | verblijfplaats.nummeraanduidingIdentificatie         |
        | verblijfplaats.verblijfadres.aanduidingBijHuisnummer |
        | verblijfplaats.verblijfadres.huisletter              |
        | verblijfplaats.verblijfadres.huisnummer              |
        | verblijfplaats.verblijfadres.huisnummertoevoeging    |
        | verblijfplaats.verblijfadres.korteStraatnaam         |
        | verblijfplaats.verblijfadres.officieleStraatnaam     |
        | verblijfplaats.verblijfadres.postcode                |
        | verblijfplaats.verblijfadres.woonplaats              |
        | verblijfplaats.verblijfadres.locatiebeschrijving     |

    @fout-case
    Scenario: een niet-bestaand verblijfplaats veld wordt gevraagd met fields waarde 'verblijfplaats.nietBestaand'
      Als 'verblijfplaats.nietBestaand' wordt gevraagd van personen gezocht met burgerservicenummer
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

  Regel: alle velden van verblijfplaats.datumIngangGeldigheid wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                            |
        | verblijfplaats.datumIngangGeldigheid.langFormaat  |
        | verblijfplaats.datumIngangGeldigheid.type         |
        | verblijfplaats.datumIngangGeldigheid.datum        |
        | verblijfplaats.datumIngangGeldigheid.onbekend     |
        | verblijfplaats.datumIngangGeldigheid.jaar         |
        | verblijfplaats.datumIngangGeldigheid.maand        |
        | verblijfplaats.datumIngangGeldigheid.nietBestaand |

  Regel: alle velden van verblijfplaats.datumVan wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                               |
        | verblijfplaats.datumVan.langFormaat  |
        | verblijfplaats.datumVan.type         |
        | verblijfplaats.datumVan.datum        |
        | verblijfplaats.datumVan.onbekend     |
        | verblijfplaats.datumVan.jaar         |
        | verblijfplaats.datumVan.maand        |
        | verblijfplaats.datumVan.nietBestaand |

  Regel: alle velden van verblijfplaats.land wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                         |
        | verblijfplaats.verblijfadres.land.code         |
        | verblijfplaats.verblijfadres.land.omschrijving |
        | verblijfplaats.verblijfadres.land.nietBestaand |

  Regel: alle velden van verblijfplaats.functieAdres wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                   |
        | verblijfplaats.functieAdres.code         |
        | verblijfplaats.functieAdres.omschrijving |
        | verblijfplaats.functieAdres.nietBestaand |

  Regel: alle velden van verblijfplaats.verblijfadres.aanduidingBijHuisnummer wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                                            |
        | verblijfplaats.verblijfadres.aanduidingBijHuisnummer.code         |
        | verblijfplaats.verblijfadres.aanduidingBijHuisnummer.omschrijving |
        | verblijfplaats.verblijfadres.aanduidingBijHuisnummer.nietBestaand |
