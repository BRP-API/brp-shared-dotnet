# language: nl

@autorisatie
Functionaliteit: autorisatie gegevens van Persoon

  @fout-case
  Abstract Scenario: Afnemer vraagt om veld <fields> waarvoor deze niet geautoriseerd is
    Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
    | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
    | <ad hoc rubrieken>              | N                        | 20201128                |
    En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
    | naam         | waarde |
    | afnemerID    | 000008 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | <fields>                        |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                                              |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                         |
    | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden.             |
    | detail   | U bent niet geautoriseerd om de volgende gegevens op te vragen met fields: <fields> |
    | status   | 403                                                                                 |
    | code     | unauthorizedField                                                                   |
    | instance | /haalcentraal/api/brp/personen                                                      |

    Voorbeelden:
    | fields                     | missende autorisatie | ad hoc rubrieken                                      |
    | aNummer                    | 10110                | 10120 10210 10240 10310 10410 50410 76810 80910 90410 |
    | geslacht                   | 10410                | 10110 10120 10210 10240 10310 50410 76810 80910 90410 |
    | geslacht.code              | 10410                | 10110 10120 10210 10240 10310 50410 76810 80910 90410 |
    | geslacht.omschrijving      | 10410                | 10110 10120 10210 10240 10310 50410 76810 80910 90410 |
    | datumEersteInschrijvingGBA | 76810                | 10110 10120 10210 10240 10310 10410 50410 80910 90410 |

  Abstract Scenario: Afnemer vraagt <fields>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
    Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
    | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
    | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
    En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
    | naam         | waarde |
    | afnemerID    | 000008 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | <fields>                        |
    Dan heeft de response 0 personen

    Voorbeelden:
    | fields                     | ad hoc rubrieken |
    | aNummer                    | 10110            |
    | geslacht                   | 10410            |
    | geslacht.code              | 10410            |
    | geslacht.omschrijving      | 10410            |
    | datumEersteInschrijvingGBA | 76810            |
