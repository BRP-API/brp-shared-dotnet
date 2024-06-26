#language: nl

@protocollering
Functionaliteit: Als burger wil ik zien wie welke gegegevens van mij heeft gezien of gebruikt
  Zoeken en raadplegen van gegevens van burgers worden "geprotocolleerd" (formeel gelogd).

  Protocollering moet gebeuren op twee niveau's:
  - bij de RvIG op het niveau van afnemende organisaties
  - bij de afnemende organisatie op het niveau van gebruikers

  Deze feature beschrijft alleen de werking van protocollering op het niveau van afnemende organisaties bij de bron (RvIG)

  Daarin worden de volgende gegevens vastgelegd:
  - request_id: unieke identificatie van de berichtuitwisseling
  - request_datum: tijdstip waarop de protocollering is vastgelegd
  - afnemer_code: identificatiecode van de afnemende organisatie, zoals die is opgenomen in de gestuurde Oauth 2 token
  - anummer: het A-nummer van de persoon waarvan gegevens zijn gevraagd of geleverd
  - request_zoek_rubrieken: lijst van alle parameters die in het request gebruikt zijn, vertaald naar LO-BRP elementnummers
  - request_gevraagde_rubrieken: lijst van alle gegevens die met fields gevraagd zijn, vertaald naar LO-BRP elementnummers
  - verwerkt: vaste waarde false (boolean)

  Zowel request_zoek_rubrieken als request_gevraagde_rubrieken bevatten de LO-BRP elementnummers als 6 cijferig rubrieknummer (incl. voorloopnul), gescheiden door komma spatie, en oplopend gesorteerd.

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | pl_id |
    | 1001  |
    En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
    | pl_id |
    | 1002  |
    En de response van de downstream api heeft de volgende headers
    | x-geleverde-pls |
    | 1001            |

  Regel: Gebruikte parameters worden vertaald naar rubrieknummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.

    Scenario: Raadpleeg een persoon op burgerservicenummer
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | naam                            |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 010120                 |

  Regel: Zoekrubrieken worden oplopend gesorteerd op rubrieknummer en gescheiden door komma en spatie

    Scenario: Zoek persoon met alleen de verplichte parameters
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | voornamen     | Jan Peter                           |
      | fields        | burgerservicenummer                 |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 010210, 010240, 010310 |

  Regel: Gebruik van de parameter inclusiefOverledenPersonen wordt niet vastgelegd in veld 'request_zoek_rubrieken'.

    Scenario: Zoek persoon met inclusiefOverledenPersonen
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                              |
      | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam              | Maassen                             |
      | geboortedatum              | 1983-05-26                          |
      | inclusiefOverledenPersonen | true                                |
      | fields                     | burgerservicenummer,naam.voornamen  |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 010240, 010310         |

  Regel: Gevraagde velden in fields worden vertaald naar rubrieknummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_gevraagde_rubrieken'.

    Abstract Scenario: Gevraagde veld <fields veld> wordt vastgelegd in 'request_gevraagde_rubrieken' als <rubrieknummer>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                      | gevraagde rubrieken |
      | naam.voornamen              | 010210              |
      | geboorte.datum              | 010310              |
      | geboorte.datum.type         | 010310              |
      | geboorte.datum.datum        | 010310              |
      | geboorte.datum.langFormaat  | 010310              |
      | geboorte.datum.jaar         | 010310              |
      | geboorte.datum.maand        | 010310              |
      | geboorte.datum.onbekend     | 010310              |
      | geslacht                    | 010410              |
      | geslacht.code               | 010410              |
      | geslacht.omschrijving       | 010410              |
      | partners.naam.geslachtsnaam | 050240              |

  Regel: Gevraagde rubrieken worden oplopend gesorteerd en gescheiden door komma en spatie

    Scenario: Gevraagde veld <fields veld> wordt vastgelegd in 'request_gevraagde_rubrieken' als <rubrieknummer>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                                                                                 |
      | type                | RaadpleegMetBurgerservicenummer                                                                                                        |
      | burgerservicenummer | 000000024                                                                                                                              |
      | fields              | geboorte.datum,adressering.adresregel2,partners.naam.voornamen,adressering.gebruikInLopendeTekst,naam.geslachtsnaam,adressering.aanhef |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken                    |
      | 010240, 010310, 050210, PANM03, PANM06, PAVP04 |

  Regel: Wanneer met fields een hele groep wordt gevraagd, worden alle velden in die groep opgenomen in het veld 'request_gevraagde_rubrieken'.

    Abstract Scenario: vragen om hele groep <groep>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <groep>                         |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | groep                                | gevraagde rubrieken    |
      | geboorte                             | 010310, 010320, 010330 |
      | overlijden                           | 060810, 060820, 060830 |
      | europeesKiesrecht                    | 133110, 133130         |
      | partners.aangaanHuwelijkPartnerschap | 050610, 050620, 050630 |

    Scenario: vragen om hele relatie <relatie>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <relatie>                       |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | relatie  | gevraagde rubrieken                                                                                                    |
      | partners | 050120, 050210, 050220, 050230, 050240, 050310, 050320, 050330, 050410, 050610, 050620, 050630, 050710, 051510, PAHP01 |
      | kinderen | 090120, 090210, 090220, 090230, 090240, 090310, 090320, 090330, PAKD01                                                 |


  Regel: Wanneer een gevraagd veld niet geleverd wordt (bijv. omdat het geen waarde heeft), wordt het wel in het veld 'request_gevraagde_rubrieken' opgenomen.
    
    Abstract Scenario: Vragen om <fields> en <omschrijving>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | omschrijving                               | fields                                         | gevraagde rubrieken                                    |
      | persoon heeft geen adellijkeTitelPredicaat | naam                                           | 010210, 010220, 010230, 010240, 016110, PANM01, PANM02 |
      | persoon heeft geen partner                 | partners.geboorte                              | 050310, 050320, 050330                                 |
      | persoon is niet overleden                  | overlijden.datum                               | 060810                                                 |
      | persoon heeft geen verblijfstitel          | verblijfstitel.aanduiding                      | 103910                                                 |
      | persoon heeft geen kind                    | kinderen.naam.voornamen                        | 090210                                                 |
      | persoon heeft alleen ouder 1               | ouders.datumIngangFamilierechtelijkeBetrekking | 026210, 036210                                         |

  Regel: Wanneer een veld ongevraagd geleverd wordt, wordt het niet in 'request_gevraagde_rubrieken' opgenomen.
    Dit betreft geheimhouding, opschorting, in onderzoek, RNI en verificatie

    Scenario: Persoon heeft geheimhouding, opschorting, in onderzoek, RNI en verificatie
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                 |
      | type                | RaadpleegMetBurgerservicenummer        |
      | burgerservicenummer | 000000024                              |
      | fields              | burgerservicenummer,naam.geslachtsnaam |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | 010120, 010240              |

  Regel: Wanneer een veld wordt gevraagd dat wordt bepaald uit een of meerdere andere velden, dan worden alle daarvoor nodige velden in 'request_gevraagde_rubrieken' opgenomen.

    Abstract Scenario: Vragen om <fields>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields             | gevraagde rubrieken |
      | leeftijd           | PAGL01              |
      | naam.voorletters   | PANM01              |
      | naam.volledigeNaam | PANM02              |

  Regel: Wanneer in het antwoord meerdere personen worden geleverd, dan wordt er per geleverde persoon een protocolleringsrecord opgenomen

    Scenario: Zoek persoon met alle mogelijke parameters
      Gegeven de response van de downstream api heeft de volgende headers
      | x-geleverde-pls |
      | 1001,1002       |
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                      |
      | type                    | ZoekMetGeslachtsnaamEnGeboortedatum         |
      | geslachtsnaam           | Maassen                                     |
      | geboortedatum           | 1983-05-26                                  |
      | voorvoegsel             | van                                         |
      | gemeenteVanInschrijving | 0599                                        |
      | fields                  | burgerservicenummer,naam.voornamen,geslacht |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken         | request_gevraagde_rubrieken |
      | 010230, 010240, 010310, 080910 | 010120, 010210, 010410      |
      En heeft de persoon met burgerservicenummer '000000048' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken         | request_gevraagde_rubrieken |
      | 010230, 010240, 010310, 080910 | 010120, 010210, 010410      |
