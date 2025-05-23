# language: nl

@autorisatie
Functionaliteit: autorisatie gegevens van leeftijd van persoon bij zoeken

    Achtergrond:
      Gegeven de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |

    @fout-case
    Abstract Scenario: Afnemer vraagt om veld <fields> waarvoor deze niet geautoriseerd is
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken> 81120 81160  | N                        | 20201128                |
      Als personen wordt gezocht met de volgende parameters
      | naam       | waarde                      |
      | type       | ZoekMetPostcodeEnHuisnummer |
      | postcode   | 2628HJ                      |
      | huisnummer | 2                           |
      | fields     | <fields>                    |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                                              |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                         |
      | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden.             |
      | detail   | U bent niet geautoriseerd om de volgende gegevens op te vragen met fields: <fields> |
      | status   | 403                                                                                 |
      | code     | unauthorizedField                                                                   |
      | instance | /haalcentraal/api/brp/personen                                                      |

      Voorbeelden:
      | fields   | missende autorisatie | ad hoc rubrieken                                |
      | leeftijd | PAGL01               | 10120 10210 10310 10320 10330 20310 30310 50310 |

    Abstract Scenario: Afnemer vraagt <fields>, en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken> 81120 81160  | N                        | 20201128                |
      Als personen wordt gezocht met de volgende parameters
      | naam       | waarde                      |
      | type       | ZoekMetPostcodeEnHuisnummer |
      | postcode   | 2628HJ                      |
      | huisnummer | 2                           |
      | fields     | <fields>                    |
      Dan heeft de response 0 personen

      Voorbeelden:
      | fields   | ad hoc rubrieken |
      | leeftijd | PAGL01           |
