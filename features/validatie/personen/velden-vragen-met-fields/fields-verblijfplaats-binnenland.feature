# language: nl
@input-validatie
Functionaliteit: geldige 'verblijfplaats binnenland' fields waarden voor het vragen van verblijfplaats velden

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                                         |
        | verblijfplaatsBinnenland                                       |
        | verblijfplaatsBinnenland.type                                  |
        | verblijfplaatsBinnenland.datumIngangGeldigheid                 |
        | verblijfplaatsBinnenland.datumVan                              |
        | verblijfplaatsBinnenland.verblijfadres                         |
        | verblijfplaatsBinnenland.adresseerbaarObjectIdentificatie      |
        | verblijfplaatsBinnenland.functieAdres                          |
        | verblijfplaatsBinnenland.nummeraanduidingIdentificatie         |
        | verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer |
        | verblijfplaatsBinnenland.verblijfadres.huisletter              |
        | verblijfplaatsBinnenland.verblijfadres.huisnummer              |
        | verblijfplaatsBinnenland.verblijfadres.huisnummertoevoeging    |
        | verblijfplaatsBinnenland.verblijfadres.korteStraatnaam         |
        | verblijfplaatsBinnenland.verblijfadres.officieleStraatnaam     |
        | verblijfplaatsBinnenland.verblijfadres.postcode                |
        | verblijfplaatsBinnenland.verblijfadres.woonplaats              |
        | verblijfplaatsBinnenland.verblijfadres.locatiebeschrijving     |

    @fout-case
    Abstract Scenario: een niet-bestaand verblijfplaats veld wordt gevraagd met fields waarde '<fields>'
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
        | fields                                        |
        | verblijfplaatsBinnenland.nietBestaand         |
        | verblijfplaatsBinnenland.land                 |
        | verblijfplaatsBinnenland.verblijfadres.regel1 |
        | verblijfplaatsBinnenland.verblijfadres.regel2 |
        | verblijfplaatsBinnenland.verblijfadres.regel3 |

  Regel: alle velden van verblijfplaatsBinnenland.datumIngangGeldigheid wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                                      |
        | verblijfplaatsBinnenland.datumIngangGeldigheid.langFormaat  |
        | verblijfplaatsBinnenland.datumIngangGeldigheid.type         |
        | verblijfplaatsBinnenland.datumIngangGeldigheid.datum        |
        | verblijfplaatsBinnenland.datumIngangGeldigheid.onbekend     |
        | verblijfplaatsBinnenland.datumIngangGeldigheid.jaar         |
        | verblijfplaatsBinnenland.datumIngangGeldigheid.maand        |
        | verblijfplaatsBinnenland.datumIngangGeldigheid.nietBestaand |

  Regel: alle velden van verblijfplaatsBinnenland.datumVan wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                         |
        | verblijfplaatsBinnenland.datumVan.langFormaat  |
        | verblijfplaatsBinnenland.datumVan.type         |
        | verblijfplaatsBinnenland.datumVan.datum        |
        | verblijfplaatsBinnenland.datumVan.onbekend     |
        | verblijfplaatsBinnenland.datumVan.jaar         |
        | verblijfplaatsBinnenland.datumVan.maand        |
        | verblijfplaatsBinnenland.datumVan.nietBestaand |

  Regel: alle velden van verblijfplaatsBinnenland.functieAdres wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                             |
        | verblijfplaatsBinnenland.functieAdres.code         |
        | verblijfplaatsBinnenland.functieAdres.omschrijving |
        | verblijfplaatsBinnenland.functieAdres.nietBestaand |

  Regel: alle velden van verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                                                      |
        | verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer.code         |
        | verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer.omschrijving |
        | verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer.nietBestaand |
