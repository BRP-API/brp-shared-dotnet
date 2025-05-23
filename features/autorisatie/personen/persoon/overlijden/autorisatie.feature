# language: nl

@autorisatie
Functionaliteit: autorisatie gegevens van overlijden van Persoon

    @fout-case
    Abstract Scenario: Afnemer vraagt om veld <fields> waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
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
      | fields                         | missende autorisatie | ad hoc rubrieken |
      | overlijden                     | 60810 60820 60830    | 68510            |
      | overlijden                     | 60810                | 60820 60830      |
      | overlijden                     | 60820                | 60810 60830      |
      | overlijden                     | 60830                | 60810 60820      |
      | overlijden.datum               | 60810                | 60820 60830      |
      | overlijden.datum.langFormaat   | 60810                | 60820 60830      |
      | overlijden.datum.type          | 60810                | 60820 60830      |
      | overlijden.datum.datum         | 60810                | 60820 60830      |
      | overlijden.datum.onbekend      | 60810                | 60820 60830      |
      | overlijden.datum.jaar          | 60810                | 60820 60830      |
      | overlijden.datum.maand         | 60810                | 60820 60830      |
      | overlijden.land                | 60830                | 60810 60820      |
      | overlijden.land.code           | 60830                | 60810 60820      |
      | overlijden.land.omschrijving   | 60830                | 60810 60820      |
      | overlijden.plaats              | 60820                | 60810 60830      |
      | overlijden.plaats.code         | 60820                | 60810 60830      |
      | overlijden.plaats.omschrijving | 60820                | 60810 60830      |

    Abstract Scenario: Afnemer vraagt <fields>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <ad hoc rubrieken>        | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      En de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | geboortedatum (03.10) | geslachtsnaam (02.40) | voornamen (02.10) | geslachtsaanduiding (04.10) |
      | 19830526              | Maassen               | Pieter            | M                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan heeft de response 0 personen

      Voorbeelden:
      | fields                         | ad hoc rubrieken  |
      | overlijden                     | 60810 60820 60830 |
      | overlijden.datum               | 60810             |
      | overlijden.datum.langFormaat   | 60810             |
      | overlijden.datum.type          | 60810             |
      | overlijden.datum.datum         | 60810             |
      | overlijden.datum.onbekend      | 60810             |
      | overlijden.datum.jaar          | 60810             |
      | overlijden.datum.maand         | 60810             |
      | overlijden.land                | 60830             |
      | overlijden.land.code           | 60830             |
      | overlijden.land.omschrijving   | 60830             |
      | overlijden.plaats              | 60820             |
      | overlijden.plaats.code         | 60820             |
      | overlijden.plaats.omschrijving | 60820             |
