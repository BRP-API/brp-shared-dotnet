#language: nl

@input-validatie
Functionaliteit: persoon/persoon beperkt velden vragen met fields - fout cases

Regel: De fields parameter is een verplichte parameter

  @fout-case
  Scenario: De fields parameter ontbreekt bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name   | reason                  |
    | required | fields | Parameter is verplicht. |

  @fout-case
  Scenario: De fields parameter ontbreekt bij het zoeken van personen
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name   | reason                  |
    | required | fields | Parameter is verplicht. |

Regel: De fields parameter bevat een lijst met minimaal één veld pad

  @fout-case
  Scenario: De fields parameter bevat een lege lijst bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              |                                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name   | reason                          |
    | minItems | fields | Array bevat minder dan 1 items. |

  @fout-case
  Scenario: De fields parameter bevat een lege lijst bij het zoeken van personen
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        |                                     |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name   | reason                          |
    | minItems | fields | Array bevat minder dan 1 items. |

  @fout-case
  Scenario: De fields parameter bevat een string met veld paden gescheiden door een komma bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields (als string) | burgerservicenummer,geslacht    |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code  | name   | reason                   |
    | array | fields | Parameter is geen array. |

  @fout-case
  Scenario: De fields parameter bevat een string met veld paden gescheiden door een komma bij het zoeken van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam       | Kierkegaard                         |
    | geboortedatum       | 1956-11-15                          |
    | fields (als string) | burgerservicenummer,geslacht        |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code  | name   | reason                   |
    | array | fields | Parameter is geen array. |

Regel: De fields parameter bevat een lijst met maximaal 130 veld paden

  @fout-case
  Scenario: De fields parameter bevat meer dan 130 veld paden bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | <fields>                        |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name   | reason                          |
    | maxItems | fields | Array bevat meer dan 130 items. |

    Voorbeelden:
    | fields                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
    | aNummer,adressering,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land,adressering.aanhef,adressering.aanschrijfwijze,adressering.aanschrijfwijze.aanspreekvorm,adressering.aanschrijfwijze.naam,adressering.gebruikInLopendeTekst,burgerservicenummer,datumEersteInschrijvingGBA,datumInschrijvingInGemeente,europeesKiesrecht,europeesKiesrecht.aanduiding,europeesKiesrecht.einddatumUitsluiting,geboorte,geboorte.datum,geboorte.land,geboorte.plaats,gemeenteVanInschrijving,geslacht,immigratie,immigratie.datumVestigingInNederland,immigratie.indicatieVestigingVanuitBuitenland,immigratie.landVanwaarIngeschreven,immigratie.vanuitVerblijfplaatsOnbekend,indicatieCurateleRegister,indicatieGezagMinderjarige,kinderen,kinderen.burgerservicenummer,kinderen.geboorte,kinderen.geboorte.datum,kinderen.geboorte.land,kinderen.geboorte.plaats,kinderen.naam,kinderen.naam.adellijkeTitelPredicaat,kinderen.naam.geslachtsnaam,kinderen.naam.voorletters,kinderen.naam.voornamen,kinderen.naam.voorvoegsel,leeftijd,naam,naam.adellijkeTitelPredicaat,naam.geslachtsnaam,naam.volledigeNaam,naam.voorletters,naam.voornamen,naam.voorvoegsel,naam.aanduidingNaamgebruik,nationaliteiten,nationaliteiten.redenOpname,nationaliteiten.datumIngangGeldigheid,nationaliteiten.nationaliteit,opschortingBijhouding,opschortingBijhouding.datum,ouders,ouders.burgerservicenummer,ouders.datumIngangFamilierechtelijkeBetrekking,ouders.geboorte,ouders.geboorte.datum,ouders.geboorte.land,ouders.geboorte.plaats,ouders.geslacht,ouders.naam,ouders.naam.adellijkeTitelPredicaat,ouders.naam.geslachtsnaam,ouders.naam.voorletters,ouders.naam.voornamen,ouders.naam.voorvoegsel,ouders.ouderAanduiding,overlijden,overlijden.datum,overlijden.land,overlijden.plaats,partners,partners.aangaanHuwelijkPartnerschap,partners.aangaanHuwelijkPartnerschap.datum,partners.aangaanHuwelijkPartnerschap.land,partners.aangaanHuwelijkPartnerschap.plaats,partners.burgerservicenummer,partners.geboorte,partners.geboorte.datum,partners.geboorte.land,partners.geboorte.plaats,partners.geslacht,partners.naam,partners.naam.adellijkeTitelPredicaat,partners.naam.geslachtsnaam,partners.naam.voorletters,partners.naam.voornamen,partners.naam.voorvoegsel,partners.ontbindingHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap.datum,partners.soortVerbintenis,uitsluitingKiesrecht,uitsluitingKiesrecht.einddatum,uitsluitingKiesrecht.uitgeslotenVanKiesrecht,verblijfplaats,verblijfplaats.datumIngangGeldigheid,verblijfplaats.datumVan,verblijfplaats.verblijfadres,verblijfplaats.verblijfadres.land,verblijfplaats.verblijfadres.regel1,verblijfplaats.verblijfadres.regel2,verblijfplaats.verblijfadres.regel3,verblijfplaats.adresseerbaarObjectIdentificatie,verblijfplaats.functieAdres,verblijfplaats.nummeraanduidingIdentificatie,verblijfplaats.verblijfadres.aanduidingBijHuisnummer,verblijfplaats.verblijfadres.huisletter,verblijfplaats.verblijfadres.huisnummer,verblijfplaats.verblijfadres.huisnummertoevoeging,verblijfplaats.verblijfadres.korteStraatnaam,verblijfplaats.verblijfadres.officieleStraatnaam,verblijfplaats.verblijfadres.postcode,verblijfplaats.verblijfadres.woonplaats,verblijfplaats.verblijfadres.locatiebeschrijving,verblijfstitel,verblijfstitel.aanduiding,verblijfstitel.datumEinde,verblijfstitel.datumIngang,verblijfplaatsBinnenland,verblijfplaatsBinnenland.datumIngangGeldigheid,verblijfplaatsBinnenland.datumVan,verblijfplaatsBinnenland.verblijfadres,verblijfplaatsBinnenland.adresseerbaarObjectIdentificatie,verblijfplaatsBinnenland.functieAdres,verblijfplaatsBinnenland.nummeraanduidingIdentificatie,verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer,verblijfplaatsBinnenland.verblijfadres.huisletter,verblijfplaatsBinnenland.verblijfadres.huisnummer,verblijfplaatsBinnenland.verblijfadres.huisnummertoevoeging,verblijfplaatsBinnenland.verblijfadres.korteStraatnaam,verblijfplaatsBinnenland.verblijfadres.officieleStraatnaam,verblijfplaatsBinnenland.verblijfadres.postcode,verblijfplaatsBinnenland.verblijfadres.woonplaats,verblijfplaatsBinnenland.verblijfadres.locatiebeschrijving,adresseringBinnenland,adresseringBinnenland.adresregel1,adresseringBinnenland.adresregel2 |

  @fout-case
  Scenario: De fields parameter bevat meer dan 130 veld paden bij het zoeken van personen
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        | <fields>                            |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name   | reason                          |
    | maxItems | fields | Array bevat meer dan 130 items. |

    Voorbeelden:
    | fields                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
    | aNummer,adressering,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land,adressering.aanhef,adressering.aanschrijfwijze,adressering.aanschrijfwijze.aanspreekvorm,adressering.aanschrijfwijze.naam,adressering.gebruikInLopendeTekst,burgerservicenummer,datumEersteInschrijvingGBA,datumInschrijvingInGemeente,europeesKiesrecht,europeesKiesrecht.aanduiding,europeesKiesrecht.einddatumUitsluiting,geboorte,geboorte.datum,geboorte.land,geboorte.plaats,gemeenteVanInschrijving,geslacht,immigratie,immigratie.datumVestigingInNederland,immigratie.indicatieVestigingVanuitBuitenland,immigratie.landVanwaarIngeschreven,immigratie.vanuitVerblijfplaatsOnbekend,indicatieCurateleRegister,indicatieGezagMinderjarige,kinderen,kinderen.burgerservicenummer,kinderen.geboorte,kinderen.geboorte.datum,kinderen.geboorte.land,kinderen.geboorte.plaats,kinderen.naam,kinderen.naam.adellijkeTitelPredicaat,kinderen.naam.geslachtsnaam,kinderen.naam.voorletters,kinderen.naam.voornamen,kinderen.naam.voorvoegsel,leeftijd,naam,naam.adellijkeTitelPredicaat,naam.geslachtsnaam,naam.volledigeNaam,naam.voorletters,naam.voornamen,naam.voorvoegsel,naam.aanduidingNaamgebruik,nationaliteiten,nationaliteiten.redenOpname,nationaliteiten.datumIngangGeldigheid,nationaliteiten.nationaliteit,opschortingBijhouding,opschortingBijhouding.datum,ouders,ouders.burgerservicenummer,ouders.datumIngangFamilierechtelijkeBetrekking,ouders.geboorte,ouders.geboorte.datum,ouders.geboorte.land,ouders.geboorte.plaats,ouders.geslacht,ouders.naam,ouders.naam.adellijkeTitelPredicaat,ouders.naam.geslachtsnaam,ouders.naam.voorletters,ouders.naam.voornamen,ouders.naam.voorvoegsel,ouders.ouderAanduiding,overlijden,overlijden.datum,overlijden.land,overlijden.plaats,partners,partners.aangaanHuwelijkPartnerschap,partners.aangaanHuwelijkPartnerschap.datum,partners.aangaanHuwelijkPartnerschap.land,partners.aangaanHuwelijkPartnerschap.plaats,partners.burgerservicenummer,partners.geboorte,partners.geboorte.datum,partners.geboorte.land,partners.geboorte.plaats,partners.geslacht,partners.naam,partners.naam.adellijkeTitelPredicaat,partners.naam.geslachtsnaam,partners.naam.voorletters,partners.naam.voornamen,partners.naam.voorvoegsel,partners.ontbindingHuwelijkPartnerschap,partners.ontbindingHuwelijkPartnerschap.datum,partners.soortVerbintenis,uitsluitingKiesrecht,uitsluitingKiesrecht.einddatum,uitsluitingKiesrecht.uitgeslotenVanKiesrecht,verblijfplaats,verblijfplaats.datumIngangGeldigheid,verblijfplaats.datumVan,verblijfplaats.verblijfadres,verblijfplaats.verblijfadres.land,verblijfplaats.verblijfadres.regel1,verblijfplaats.verblijfadres.regel2,verblijfplaats.verblijfadres.regel3,verblijfplaats.adresseerbaarObjectIdentificatie,verblijfplaats.functieAdres,verblijfplaats.nummeraanduidingIdentificatie,verblijfplaats.verblijfadres.aanduidingBijHuisnummer,verblijfplaats.verblijfadres.huisletter,verblijfplaats.verblijfadres.huisnummer,verblijfplaats.verblijfadres.huisnummertoevoeging,verblijfplaats.verblijfadres.korteStraatnaam,verblijfplaats.verblijfadres.officieleStraatnaam,verblijfplaats.verblijfadres.postcode,verblijfplaats.verblijfadres.woonplaats,verblijfplaats.verblijfadres.locatiebeschrijving,verblijfstitel,verblijfstitel.aanduiding,verblijfstitel.datumEinde,verblijfstitel.datumIngang,verblijfplaatsBinnenland,verblijfplaatsBinnenland.datumIngangGeldigheid,verblijfplaatsBinnenland.datumVan,verblijfplaatsBinnenland.verblijfadres,verblijfplaatsBinnenland.adresseerbaarObjectIdentificatie,verblijfplaatsBinnenland.functieAdres,verblijfplaatsBinnenland.nummeraanduidingIdentificatie,verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer,verblijfplaatsBinnenland.verblijfadres.huisletter,verblijfplaatsBinnenland.verblijfadres.huisnummer,verblijfplaatsBinnenland.verblijfadres.huisnummertoevoeging,verblijfplaatsBinnenland.verblijfadres.korteStraatnaam,verblijfplaatsBinnenland.verblijfadres.officieleStraatnaam,verblijfplaatsBinnenland.verblijfadres.postcode,verblijfplaatsBinnenland.verblijfadres.woonplaats,verblijfplaatsBinnenland.verblijfadres.locatiebeschrijving,adresseringBinnenland,adresseringBinnenland.adresregel1,adresseringBinnenland.adresregel2 |

Regel: De fields parameter bevat veld paden die verwijzen naar een bestaand veld. Een veld pad is een string bestaande uit minimaal 1 en maximaal 200 karakters. Deze karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - cijfers (0-9)
      - punt (.) en de laag streepje teken (_)

  @fout-case
  Abstract Scenario: De fields parameter bevat een veld pad met ongeldige karakters bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | <fields>                        |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name      | reason                                                   |
    | pattern | fields[0] | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,200}$. |

    Voorbeelden:
    | fields                | sub-titel                   |
    | a*nummer              | veld pad bevat * karakter   |
    | burger service nummer | veld pad bevat spaties      |
    | ,burgerservicenummer  | veld pad is een lege string |

  @fout-case
  Scenario: De fields parameter bevat een veld pad met meer dan 200 valide karakters bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                                                                                                                                    |
    | type                | RaadpleegMetBurgerservicenummer                                                                                                                                                                           |
    | burgerservicenummer | 000000139                                                                                                                                                                                                 |
    | fields              | bestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbestaatooknietbesta |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name      | reason                                                   |
    | pattern | fields[0] | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,200}$. |

  @fout-case
  Scenario: De fields parameter bevat het pad naar een niet bestaand veld (onjuiste case) bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | anummer                         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code   | name      | reason                                       |
    | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

  @fout-case
  Scenario: De fields parameter bevat het pad naar een niet bestaand veld bij het zoeken van personen
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        | burgerservicenummer,aNummer         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[1].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code   | name      | reason                                       |
    | fields | fields[1] | Parameter bevat een niet bestaande veldnaam. |

  @fout-case
  Scenario: De fields parameter bevat het pad naar een bestaand veld dat niet kan worden opgevraagd bij het gebruikte zoek personen operatie
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        | burgerservicenummer,gezag           |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[1].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code   | name      | reason                                       |
    | fields | fields[1] | Parameter bevat een niet bestaande veldnaam. |

  @fout-case
  Abstract Scenario: Automatisch geleverd veld <fields> mag niet worden gevraagd bij raadplegen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | <fields>                        |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code   | name      | reason                                        |
    | fields | fields[0] | Parameter bevat een niet toegestane veldnaam. |

    Voorbeelden:
    | fields                                                                               |
    | adressering.inOnderzoek                                                              |
    | adressering.inOnderzoek.aanhef                                                       |
    | adressering.inOnderzoek.aanschrijfwijze                                              |
    | adressering.inOnderzoek.adresregel1                                                  |
    | adressering.inOnderzoek.adresregel2                                                  |
    | adressering.inOnderzoek.adresregel3                                                  |
    | adressering.inOnderzoek.datumIngangOnderzoekPartner                                  |
    | adressering.inOnderzoek.datumIngangOnderzoekPartner.langFormaat                      |
    | adressering.inOnderzoek.datumIngangOnderzoekPartner.type                             |
    | adressering.inOnderzoek.datumIngangOnderzoekPartner.datum                            |
    | adressering.inOnderzoek.datumIngangOnderzoekPartner.onbekend                         |
    | adressering.inOnderzoek.datumIngangOnderzoekPartner.jaar                             |
    | adressering.inOnderzoek.datumIngangOnderzoekPartner.maand                            |
    | adressering.inOnderzoek.datumIngangOnderzoekPersoon                                  |
    | adressering.inOnderzoek.datumIngangOnderzoekPersoon.langFormaat                      |
    | adressering.inOnderzoek.datumIngangOnderzoekPersoon.type                             |
    | adressering.inOnderzoek.datumIngangOnderzoekPersoon.datum                            |
    | adressering.inOnderzoek.datumIngangOnderzoekPersoon.onbekend                         |
    | adressering.inOnderzoek.datumIngangOnderzoekPersoon.jaar                             |
    | adressering.inOnderzoek.datumIngangOnderzoekPersoon.maand                            |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats                           |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat               |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.type                      |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum                     |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.onbekend                  |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.jaar                      |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.maand                     |
    | adressering.inOnderzoek.gebruikInLopendeTekst                                        |
    | adressering.inOnderzoek.land                                                         |
    | adressering.indicatieVastgesteldVerblijftNietOpAdres                                 |
    | geboorte.inOnderzoek                                                                 |
    | geboorte.inOnderzoek.datumIngangOnderzoek                                            |
    | geboorte.inOnderzoek.datumIngangOnderzoek.langFormaat                                |
    | geboorte.inOnderzoek.datumIngangOnderzoek.type                                       |
    | geboorte.inOnderzoek.datumIngangOnderzoek.datum                                      |
    | geboorte.inOnderzoek.datumIngangOnderzoek.onbekend                                   |
    | geboorte.inOnderzoek.datumIngangOnderzoek.jaar                                       |
    | geboorte.inOnderzoek.datumIngangOnderzoek.maand                                      |
    | geboorte.inOnderzoek.datum                                                           |
    | geboorte.inOnderzoek.land                                                            |
    | geboorte.inOnderzoek.plaats                                                          |
    | geheimhoudingPersoonsgegevens                                                        |
    | immigratie.inOnderzoek                                                               |
    | immigratie.inOnderzoek.datumIngangOnderzoek                                          |
    | immigratie.inOnderzoek.datumIngangOnderzoek.langFormaat                              |
    | immigratie.inOnderzoek.datumIngangOnderzoek.type                                     |
    | immigratie.inOnderzoek.datumIngangOnderzoek.datum                                    |
    | immigratie.inOnderzoek.datumIngangOnderzoek.onbekend                                 |
    | immigratie.inOnderzoek.datumIngangOnderzoek.jaar                                     |
    | immigratie.inOnderzoek.datumIngangOnderzoek.maand                                    |
    | immigratie.inOnderzoek.datumVestigingInNederland                                     |
    | immigratie.inOnderzoek.indicatieVestigingVanuitBuitenland                            |
    | immigratie.inOnderzoek.landVanwaarIngeschreven                                       |
    | immigratie.inOnderzoek.vanuitVerblijfplaatsOnbekend                                  |
    | inOnderzoek                                                                          |
    | inOnderzoek.burgerservicenummer                                                      |
    | inOnderzoek.datumIngangOnderzoekGemeente                                             |
    | inOnderzoek.datumIngangOnderzoekGemeente.langFormaat                                 |
    | inOnderzoek.datumIngangOnderzoekGemeente.type                                        |
    | inOnderzoek.datumIngangOnderzoekGemeente.datum                                       |
    | inOnderzoek.datumIngangOnderzoekGemeente.onbekend                                    |
    | inOnderzoek.datumIngangOnderzoekGemeente.jaar                                        |
    | inOnderzoek.datumIngangOnderzoekGemeente.maand                                       |
    | inOnderzoek.datumIngangOnderzoekGezag                                                |
    | inOnderzoek.datumIngangOnderzoekGezag.langFormaat                                    |
    | inOnderzoek.datumIngangOnderzoekGezag.type                                           |
    | inOnderzoek.datumIngangOnderzoekGezag.datum                                          |
    | inOnderzoek.datumIngangOnderzoekGezag.onbekend                                       |
    | inOnderzoek.datumIngangOnderzoekGezag.jaar                                           |
    | inOnderzoek.datumIngangOnderzoekGezag.maand                                          |
    | inOnderzoek.datumIngangOnderzoekPersoon                                              |
    | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat                                  |
    | inOnderzoek.datumIngangOnderzoekPersoon.type                                         |
    | inOnderzoek.datumIngangOnderzoekPersoon.datum                                        |
    | inOnderzoek.datumIngangOnderzoekPersoon.onbekend                                     |
    | inOnderzoek.datumIngangOnderzoekPersoon.jaar                                         |
    | inOnderzoek.datumIngangOnderzoekPersoon.maand                                        |
    | inOnderzoek.datumInschrijvingInGemeente                                              |
    | inOnderzoek.gemeenteVanInschrijving                                                  |
    | inOnderzoek.geslacht                                                                 |
    | inOnderzoek.indicatieCurateleRegister                                                |
    | inOnderzoek.indicatieGezagMinderjarige                                               |
    | inOnderzoek.leeftijd                                                                 |
    | kinderen.geboorte.inOnderzoek                                                        |
    | kinderen.geboorte.inOnderzoek.datumIngangOnderzoek                                   |
    | kinderen.geboorte.inOnderzoek.datumIngangOnderzoek.langFormaat                       |
    | kinderen.geboorte.inOnderzoek.datumIngangOnderzoek.type                              |
    | kinderen.geboorte.inOnderzoek.datumIngangOnderzoek.datum                             |
    | kinderen.geboorte.inOnderzoek.datumIngangOnderzoek.onbekend                          |
    | kinderen.geboorte.inOnderzoek.datumIngangOnderzoek.jaar                              |
    | kinderen.geboorte.inOnderzoek.datumIngangOnderzoek.maand                             |
    | kinderen.geboorte.inOnderzoek.datum                                                  |
    | kinderen.geboorte.inOnderzoek.land                                                   |
    | kinderen.geboorte.inOnderzoek.plaats                                                 |
    | kinderen.inOnderzoek                                                                 |
    | kinderen.inOnderzoek.datumIngangOnderzoek                                            |
    | kinderen.inOnderzoek.datumIngangOnderzoek.langFormaat                                |
    | kinderen.inOnderzoek.datumIngangOnderzoek.type                                       |
    | kinderen.inOnderzoek.datumIngangOnderzoek.datum                                      |
    | kinderen.inOnderzoek.datumIngangOnderzoek.onbekend                                   |
    | kinderen.inOnderzoek.datumIngangOnderzoek.jaar                                       |
    | kinderen.inOnderzoek.datumIngangOnderzoek.maand                                      |
    | kinderen.inOnderzoek.burgerservicenummer                                             |
    | kinderen.naam.inOnderzoek                                                            |
    | kinderen.naam.inOnderzoek.datumIngangOnderzoek                                       |
    | kinderen.naam.inOnderzoek.datumIngangOnderzoek.langFormaat                           |
    | kinderen.naam.inOnderzoek.datumIngangOnderzoek.type                                  |
    | kinderen.naam.inOnderzoek.datumIngangOnderzoek.datum                                 |
    | kinderen.naam.inOnderzoek.datumIngangOnderzoek.onbekend                              |
    | kinderen.naam.inOnderzoek.datumIngangOnderzoek.jaar                                  |
    | kinderen.naam.inOnderzoek.datumIngangOnderzoek.maand                                 |
    | kinderen.naam.inOnderzoek.adellijkeTitelPredicaat                                    |
    | kinderen.naam.inOnderzoek.geslachtsnaam                                              |
    | kinderen.naam.inOnderzoek.voorletters                                                |
    | kinderen.naam.inOnderzoek.voornamen                                                  |
    | kinderen.naam.inOnderzoek.voorvoegsel                                                |
    | naam.inOnderzoek                                                                     |
    | naam.inOnderzoek.datumIngangOnderzoek                                                |
    | naam.inOnderzoek.datumIngangOnderzoek.langFormaat                                    |
    | naam.inOnderzoek.datumIngangOnderzoek.type                                           |
    | naam.inOnderzoek.datumIngangOnderzoek.datum                                          |
    | naam.inOnderzoek.datumIngangOnderzoek.onbekend                                       |
    | naam.inOnderzoek.datumIngangOnderzoek.jaar                                           |
    | naam.inOnderzoek.datumIngangOnderzoek.maand                                          |
    | naam.inOnderzoek.adellijkeTitelPredicaat                                             |
    | naam.inOnderzoek.geslachtsnaam                                                       |
    | naam.inOnderzoek.voorletters                                                         |
    | naam.inOnderzoek.voornamen                                                           |
    | naam.inOnderzoek.voorvoegsel                                                         |
    | naam.inOnderzoek.aanduidingNaamgebruik                                               |
    | naam.inOnderzoek.volledigeNaam                                                       |
    | nationaliteiten.inOnderzoek                                                          |
    | nationaliteiten.inOnderzoek.datumIngangOnderzoek                                     |
    | nationaliteiten.inOnderzoek.datumIngangOnderzoek.langFormaat                         |
    | nationaliteiten.inOnderzoek.datumIngangOnderzoek.type                                |
    | nationaliteiten.inOnderzoek.datumIngangOnderzoek.datum                               |
    | nationaliteiten.inOnderzoek.datumIngangOnderzoek.onbekend                            |
    | nationaliteiten.inOnderzoek.datumIngangOnderzoek.jaar                                |
    | nationaliteiten.inOnderzoek.datumIngangOnderzoek.maand                               |
    | nationaliteiten.inOnderzoek.nationaliteit                                            |
    | nationaliteiten.inOnderzoek.redenOpname                                              |
    | nationaliteiten.inOnderzoek.type                                                     |
    | opschortingBijhouding                                                                |
    | opschortingBijhouding.reden                                                          |
    | opschortingBijhouding.reden.code                                                     |
    | opschortingBijhouding.reden.omschrijving                                             |
    | opschortingBijhouding.datum                                                          |
    | opschortingBijhouding.datum.langFormaat                                              |
    | opschortingBijhouding.datum.type                                                     |
    | opschortingBijhouding.datum.datum                                                    |
    | opschortingBijhouding.datum.onbekend                                                 |
    | opschortingBijhouding.datum.jaar                                                     |
    | opschortingBijhouding.datum.maand                                                    |
    | ouders.geboorte.inOnderzoek                                                          |
    | ouders.geboorte.inOnderzoek.datumIngangOnderzoek                                     |
    | ouders.geboorte.inOnderzoek.datumIngangOnderzoek.langFormaat                         |
    | ouders.geboorte.inOnderzoek.datumIngangOnderzoek.type                                |
    | ouders.geboorte.inOnderzoek.datumIngangOnderzoek.datum                               |
    | ouders.geboorte.inOnderzoek.datumIngangOnderzoek.onbekend                            |
    | ouders.geboorte.inOnderzoek.datumIngangOnderzoek.jaar                                |
    | ouders.geboorte.inOnderzoek.datumIngangOnderzoek.maand                               |
    | ouders.geboorte.inOnderzoek.datum                                                    |
    | ouders.geboorte.inOnderzoek.land                                                     |
    | ouders.geboorte.inOnderzoek.plaats                                                   |
    | ouders.inOnderzoek                                                                   |
    | ouders.inOnderzoek.datumIngangOnderzoek                                              |
    | ouders.inOnderzoek.datumIngangOnderzoek.langFormaat                                  |
    | ouders.inOnderzoek.datumIngangOnderzoek.type                                         |
    | ouders.inOnderzoek.datumIngangOnderzoek.datum                                        |
    | ouders.inOnderzoek.datumIngangOnderzoek.onbekend                                     |
    | ouders.inOnderzoek.datumIngangOnderzoek.jaar                                         |
    | ouders.inOnderzoek.datumIngangOnderzoek.maand                                        |
    | ouders.inOnderzoek.burgerservicenummer                                               |
    | ouders.inOnderzoek.datumIngangFamilierechtelijkeBetrekking                           |
    | ouders.inOnderzoek.geslacht                                                          |
    | ouders.naam.inOnderzoek                                                              |
    | ouders.naam.inOnderzoek.datumIngangOnderzoek                                         |
    | ouders.naam.inOnderzoek.datumIngangOnderzoek.langFormaat                             |
    | ouders.naam.inOnderzoek.datumIngangOnderzoek.type                                    |
    | ouders.naam.inOnderzoek.datumIngangOnderzoek.datum                                   |
    | ouders.naam.inOnderzoek.datumIngangOnderzoek.onbekend                                |
    | ouders.naam.inOnderzoek.datumIngangOnderzoek.jaar                                    |
    | ouders.naam.inOnderzoek.datumIngangOnderzoek.maand                                   |
    | ouders.naam.inOnderzoek.adellijkeTitelPredicaat                                      |
    | ouders.naam.inOnderzoek.geslachtsnaam                                                |
    | ouders.naam.inOnderzoek.voorletters                                                  |
    | ouders.naam.inOnderzoek.voornamen                                                    |
    | ouders.naam.inOnderzoek.voorvoegsel                                                  |
    | overlijden.inOnderzoek                                                               |
    | overlijden.inOnderzoek.datumIngangOnderzoek                                          |
    | overlijden.inOnderzoek.datumIngangOnderzoek.langFormaat                              |
    | overlijden.inOnderzoek.datumIngangOnderzoek.type                                     |
    | overlijden.inOnderzoek.datumIngangOnderzoek.datum                                    |
    | overlijden.inOnderzoek.datumIngangOnderzoek.onbekend                                 |
    | overlijden.inOnderzoek.datumIngangOnderzoek.jaar                                     |
    | overlijden.inOnderzoek.datumIngangOnderzoek.maand                                    |
    | overlijden.inOnderzoek.datum                                                         |
    | overlijden.inOnderzoek.land                                                          |
    | overlijden.inOnderzoek.plaats                                                        |
    | partners.aangaanHuwelijkPartnerschap.inOnderzoek                                     |
    | partners.aangaanHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek                |
    | partners.aangaanHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek.langFormaat    |
    | partners.aangaanHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek.type           |
    | partners.aangaanHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek.datum          |
    | partners.aangaanHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek.onbekend       |
    | partners.aangaanHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek.jaar           |
    | partners.aangaanHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek.maand          |
    | partners.aangaanHuwelijkPartnerschap.inOnderzoek.datum                               |
    | partners.aangaanHuwelijkPartnerschap.inOnderzoek.land                                |
    | partners.aangaanHuwelijkPartnerschap.inOnderzoek.plaats                              |
    | partners.geboorte.inOnderzoek                                                        |
    | partners.geboorte.inOnderzoek.datumIngangOnderzoek                                   |
    | partners.geboorte.inOnderzoek.datumIngangOnderzoek.langFormaat                       |
    | partners.geboorte.inOnderzoek.datumIngangOnderzoek.type                              |
    | partners.geboorte.inOnderzoek.datumIngangOnderzoek.datum                             |
    | partners.geboorte.inOnderzoek.datumIngangOnderzoek.onbekend                          |
    | partners.geboorte.inOnderzoek.datumIngangOnderzoek.jaar                              |
    | partners.geboorte.inOnderzoek.datumIngangOnderzoek.maand                             |
    | partners.geboorte.inOnderzoek.datum                                                  |
    | partners.geboorte.inOnderzoek.land                                                   |
    | partners.geboorte.inOnderzoek.plaats                                                 |
    | partners.inOnderzoek                                                                 |
    | partners.inOnderzoek.datumIngangOnderzoek                                            |
    | partners.inOnderzoek.datumIngangOnderzoek.langFormaat                                |
    | partners.inOnderzoek.datumIngangOnderzoek.type                                       |
    | partners.inOnderzoek.datumIngangOnderzoek.datum                                      |
    | partners.inOnderzoek.datumIngangOnderzoek.onbekend                                   |
    | partners.inOnderzoek.datumIngangOnderzoek.jaar                                       |
    | partners.inOnderzoek.datumIngangOnderzoek.maand                                      |
    | partners.inOnderzoek.burgerservicenummer                                             |
    | partners.inOnderzoek.geslacht                                                        |
    | partners.inOnderzoek.soortVerbintenis                                                |
    | partners.naam.inOnderzoek                                                            |
    | partners.naam.inOnderzoek.datumIngangOnderzoek                                       |
    | partners.naam.inOnderzoek.datumIngangOnderzoek.langFormaat                           |
    | partners.naam.inOnderzoek.datumIngangOnderzoek.type                                  |
    | partners.naam.inOnderzoek.datumIngangOnderzoek.datum                                 |
    | partners.naam.inOnderzoek.datumIngangOnderzoek.onbekend                              |
    | partners.naam.inOnderzoek.datumIngangOnderzoek.jaar                                  |
    | partners.naam.inOnderzoek.datumIngangOnderzoek.maand                                 |
    | partners.naam.inOnderzoek.adellijkeTitelPredicaat                                    |
    | partners.naam.inOnderzoek.geslachtsnaam                                              |
    | partners.naam.inOnderzoek.voorletters                                                |
    | partners.naam.inOnderzoek.voornamen                                                  |
    | partners.naam.inOnderzoek.voorvoegsel                                                |
    | partners.ontbindingHuwelijkPartnerschap.inOnderzoek                                  |
    | partners.ontbindingHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek             |
    | partners.ontbindingHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek.langFormaat |
    | partners.ontbindingHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek.type        |
    | partners.ontbindingHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek.datum       |
    | partners.ontbindingHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek.onbekend    |
    | partners.ontbindingHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek.jaar        |
    | partners.ontbindingHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek.maand       |
    | partners.ontbindingHuwelijkPartnerschap.inOnderzoek.datum                            |
    | rni                                                                                  |
    | rni.deelnemer                                                                        |
    | rni.deelnemer.code                                                                   |
    | rni.omschrijvingVerdrag                                                              |
    | rni.categorie                                                                        |
    | verblijfplaats.indicatieVastgesteldVerblijftNietOpAdres                              |
    | verblijfplaats.inOnderzoek                                                           |
    | verblijfplaats.inOnderzoek.datumIngangOnderzoek                                      |
    | verblijfplaats.inOnderzoek.datumIngangOnderzoek.langFormaat                          |
    | verblijfplaats.inOnderzoek.datumIngangOnderzoek.type                                 |
    | verblijfplaats.inOnderzoek.datumIngangOnderzoek.datum                                |
    | verblijfplaats.inOnderzoek.datumIngangOnderzoek.onbekend                             |
    | verblijfplaats.inOnderzoek.datumIngangOnderzoek.jaar                                 |
    | verblijfplaats.inOnderzoek.datumIngangOnderzoek.maand                                |
    | verblijfplaats.inOnderzoek.datumIngangGeldigheid                                     |
    | verblijfplaats.inOnderzoek.datumVan                                                  |
    | verblijfplaats.inOnderzoek.type                                                      |
    | verblijfplaats.inOnderzoek.adresseerbaarObjectIdentificatie                          |
    | verblijfplaats.inOnderzoek.functieAdres                                              |
    | verblijfplaats.inOnderzoek.nummeraanduidingIdentificatie                             |
    | verblijfstitel.inOnderzoek                                                           |
    | verblijfstitel.inOnderzoek.datumIngangOnderzoek                                      |
    | verblijfstitel.inOnderzoek.datumIngangOnderzoek.langFormaat                          |
    | verblijfstitel.inOnderzoek.datumIngangOnderzoek.type                                 |
    | verblijfstitel.inOnderzoek.datumIngangOnderzoek.datum                                |
    | verblijfstitel.inOnderzoek.datumIngangOnderzoek.onbekend                             |
    | verblijfstitel.inOnderzoek.datumIngangOnderzoek.jaar                                 |
    | verblijfstitel.inOnderzoek.datumIngangOnderzoek.maand                                |
    | verblijfstitel.inOnderzoek.aanduiding                                                |
    | verblijfstitel.inOnderzoek.datumEinde                                                |
    | verblijfstitel.inOnderzoek.datumIngang                                               |
    | verblijfplaats.verblijfadres.inOnderzoek                                             |
    | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek                        |
    | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat            |
    | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.type                   |
    | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.datum                  |
    | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.onbekend               |
    | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.jaar                   |
    | verblijfplaats.verblijfadres.inOnderzoek.datumIngangOnderzoek.maand                  |
    | verblijfplaats.verblijfadres.inOnderzoek.land                                        |
    | verblijfplaats.verblijfadres.inOnderzoek.regel1                                      |
    | verblijfplaats.verblijfadres.inOnderzoek.regel2                                      |
    | verblijfplaats.verblijfadres.inOnderzoek.regel3                                      |
    | verblijfplaats.verblijfadres.inOnderzoek.aanduidingBijHuisnummer                     |
    | verblijfplaats.verblijfadres.inOnderzoek.huisletter                                  |
    | verblijfplaats.verblijfadres.inOnderzoek.huisnummer                                  |
    | verblijfplaats.verblijfadres.inOnderzoek.huisnummertoevoeging                        |
    | verblijfplaats.verblijfadres.inOnderzoek.korteStraatnaam                             |
    | verblijfplaats.verblijfadres.inOnderzoek.officieleStraatnaam                         |
    | verblijfplaats.verblijfadres.inOnderzoek.postcode                                    |
    | verblijfplaats.verblijfadres.inOnderzoek.woonplaats                                  |
    | verblijfplaats.verblijfadres.inOnderzoek.locatiebeschrijving                         |
    | verblijfplaatsBinnenland.indicatieVastgesteldVerblijftNietOpAdres                    |
    | verblijfplaatsBinnenland.inOnderzoek                                                 |
    | verblijfplaatsBinnenland.inOnderzoek.datumIngangOnderzoek                            |
    | verblijfplaatsBinnenland.inOnderzoek.datumIngangOnderzoek.langFormaat                |
    | verblijfplaatsBinnenland.inOnderzoek.datumIngangOnderzoek.type                       |
    | verblijfplaatsBinnenland.inOnderzoek.datumIngangOnderzoek.datum                      |
    | verblijfplaatsBinnenland.inOnderzoek.datumIngangOnderzoek.onbekend                   |
    | verblijfplaatsBinnenland.inOnderzoek.datumIngangOnderzoek.jaar                       |
    | verblijfplaatsBinnenland.inOnderzoek.datumIngangOnderzoek.maand                      |
    | verblijfplaatsBinnenland.inOnderzoek.datumIngangGeldigheid                           |
    | verblijfplaatsBinnenland.inOnderzoek.datumVan                                        |
    | verblijfplaatsBinnenland.inOnderzoek.type                                            |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek                                   |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.datumIngangOnderzoek              |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat  |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.datumIngangOnderzoek.type         |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.datumIngangOnderzoek.datum        |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.datumIngangOnderzoek.onbekend     |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.datumIngangOnderzoek.jaar         |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.datumIngangOnderzoek.maand        |
    | verblijfplaatsBinnenland.inOnderzoek.adresseerbaarObjectIdentificatie                |
    | verblijfplaatsBinnenland.inOnderzoek.functieAdres                                    |
    | verblijfplaatsBinnenland.inOnderzoek.nummeraanduidingIdentificatie                   |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.aanduidingBijHuisnummer           |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.huisletter                        |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.huisnummer                        |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.huisnummertoevoeging              |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.korteStraatnaam                   |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.officieleStraatnaam               |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.postcode                          |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.woonplaats                        |
    | verblijfplaatsBinnenland.verblijfadres.inOnderzoek.locatiebeschrijving               |
    | verificatie                                                                          |
    | verificatie.datum                                                                    |
    | verificatie.datum.langFormaat                                                        |
    | verificatie.datum.type                                                               |
    | verificatie.datum.datum                                                              |
    | verificatie.datum.onbekend                                                           |
    | verificatie.datum.jaar                                                               |
    | verificatie.datum.maand                                                              |
    | verificatie.omschrijving                                                             |
    | adresseringBinnenland.inOnderzoek                                                    |
    | adresseringBinnenland.inOnderzoek.aanhef                                             |
    | adresseringBinnenland.inOnderzoek.aanschrijfwijze                                    |
    | adresseringBinnenland.inOnderzoek.adresregel1                                        |
    | adresseringBinnenland.inOnderzoek.adresregel2                                        |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner                        |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner.langFormaat            |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner.type                   |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner.datum                  |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner.onbekend               |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner.jaar                   |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner.maand                  |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon                        |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon.langFormaat            |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon.type                   |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon.datum                  |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon.onbekend               |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon.jaar                   |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon.maand                  |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats                 |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat     |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats.type            |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum           |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats.onbekend        |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats.jaar            |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats.maand           |
    | adresseringBinnenland.inOnderzoek.gebruikInLopendeTekst                              |
    | adresseringBinnenland.indicatieVastgesteldVerblijftNietOpAdres                       |

  @fout-case
  Abstract Scenario: Automatisch geleverd veld <fields> mag niet worden gevraagd bij zoeken
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Kierkegaard                         |
    | geboortedatum | 1956-11-15                          |
    | fields        | <fields>                            |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code   | name      | reason                                        |
    | fields | fields[0] | Parameter bevat een niet toegestane veldnaam. |

    Voorbeelden:
    | fields                                                                           |
    | adressering.inOnderzoek                                                          |
    | adressering.inOnderzoek.adresregel1                                              |
    | adressering.inOnderzoek.adresregel2                                              |
    | adressering.inOnderzoek.adresregel3                                              |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats                       |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat           |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.type                  |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum                 |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.onbekend              |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.jaar                  |
    | adressering.inOnderzoek.datumIngangOnderzoekVerblijfplaats.maand                 |
    | adressering.inOnderzoek.land                                                     |
    | adressering.indicatieVastgesteldVerblijftNietOpAdres                             |
    | adresseringBinnenland.inOnderzoek                                                |
    | adresseringBinnenland.inOnderzoek.aanhef                                         |
    | adresseringBinnenland.inOnderzoek.aanschrijfwijze                                |
    | adresseringBinnenland.inOnderzoek.adresregel1                                    |
    | adresseringBinnenland.inOnderzoek.adresregel2                                    |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner                    |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner.langFormaat        |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner.type               |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner.datum              |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner.onbekend           |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner.jaar               |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPartner.maand              |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon                    |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon.langFormaat        |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon.type               |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon.datum              |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon.onbekend           |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon.jaar               |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekPersoon.maand              |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats             |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats.langFormaat |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats.type        |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats.datum       |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats.onbekend    |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats.jaar        |
    | adresseringBinnenland.inOnderzoek.datumIngangOnderzoekVerblijfplaats.maand       |
    | adresseringBinnenland.inOnderzoek.gebruikInLopendeTekst                          |
    | adresseringBinnenland.indicatieVastgesteldVerblijftNietOpAdres                   |
    | geboorte.inOnderzoek                                                             |
    | geboorte.inOnderzoek.datumIngangOnderzoek                                        |
    | geboorte.inOnderzoek.datumIngangOnderzoek.langFormaat                            |
    | geboorte.inOnderzoek.datumIngangOnderzoek.type                                   |
    | geboorte.inOnderzoek.datumIngangOnderzoek.datum                                  |
    | geboorte.inOnderzoek.datumIngangOnderzoek.onbekend                               |
    | geboorte.inOnderzoek.datumIngangOnderzoek.jaar                                   |
    | geboorte.inOnderzoek.datumIngangOnderzoek.maand                                  |
    | geboorte.inOnderzoek.datum                                                       |
    | geheimhoudingPersoonsgegevens                                                    |
    | naam.inOnderzoek                                                                 |
    | naam.inOnderzoek.datumIngangOnderzoek                                            |
    | naam.inOnderzoek.datumIngangOnderzoek.langFormaat                                |
    | naam.inOnderzoek.datumIngangOnderzoek.type                                       |
    | naam.inOnderzoek.datumIngangOnderzoek.datum                                      |
    | naam.inOnderzoek.datumIngangOnderzoek.onbekend                                   |
    | naam.inOnderzoek.datumIngangOnderzoek.jaar                                       |
    | naam.inOnderzoek.datumIngangOnderzoek.maand                                      |
    | naam.inOnderzoek.adellijkeTitelPredicaat                                         |
    | naam.inOnderzoek.geslachtsnaam                                                   |
    | naam.inOnderzoek.voorletters                                                     |
    | naam.inOnderzoek.voornamen                                                       |
    | naam.inOnderzoek.voorvoegsel                                                     |
    | naam.inOnderzoek.aanduidingNaamgebruik                                           |
    | naam.inOnderzoek.volledigeNaam                                                   |
    | opschortingBijhouding                                                            |
    | opschortingBijhouding.reden                                                      |
    | opschortingBijhouding.reden.code                                                 |
    | opschortingBijhouding.reden.omschrijving                                         |
    | opschortingBijhouding.datum                                                      |
    | opschortingBijhouding.datum.langFormaat                                          |
    | opschortingBijhouding.datum.type                                                 |
    | opschortingBijhouding.datum.datum                                                |
    | opschortingBijhouding.datum.onbekend                                             |
    | opschortingBijhouding.datum.jaar                                                 |
    | opschortingBijhouding.datum.maand                                                |
    | rni                                                                              |
    | rni.deelnemer                                                                    |
    | rni.deelnemer.code                                                               |
    | rni.omschrijvingVerdrag                                                          |
    | rni.categorie                                                                    |
    | verificatie                                                                      |
    | verificatie.datum                                                                |
    | verificatie.datum.langFormaat                                                    |
    | verificatie.datum.type                                                           |
    | verificatie.datum.datum                                                          |
    | verificatie.datum.onbekend                                                       |
    | verificatie.datum.jaar                                                           |
    | verificatie.datum.maand                                                          |
    | verificatie.omschrijving                                                         |
    | inOnderzoek                                                                      |
    | inOnderzoek.burgerservicenummer                                                  |
    | inOnderzoek.datumIngangOnderzoekPersoon                                          |
    | inOnderzoek.datumIngangOnderzoekPersoon.langFormaat                              |
    | inOnderzoek.datumIngangOnderzoekPersoon.type                                     |
    | inOnderzoek.datumIngangOnderzoekPersoon.datum                                    |
    | inOnderzoek.datumIngangOnderzoekPersoon.onbekend                                 |
    | inOnderzoek.datumIngangOnderzoekPersoon.jaar                                     |
    | inOnderzoek.datumIngangOnderzoekPersoon.maand                                    |
    | inOnderzoek.geslacht                                                             |
    | inOnderzoek.leeftijd                                                             |
