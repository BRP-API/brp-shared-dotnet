# language: nl

@autorisatie
Functionaliteit: autorisatie adressering adresregels Persoon

  Regel: Vragen met fields om een adres in adressering wanneer de gebruiker niet geautoriseerd is voor (een) betreffend adresgegeven, geeft een foutmelding

    Abstract Scenario: Afnemer vraagt om <fields> en heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 <minimale autorisatie>    | N                        | 20201128                |
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
      | fields                            | minimale autorisatie |
      | adressering.adresregel1           | PAVP03               |
      | adressering.adresregel2           | PAVP04               |
      | adressering.adresregel3           | 81350                |
      | adressering.land                  | 81310                |
      | adresseringBinnenland.adresregel1 | PAVP03               |
      | adresseringBinnenland.adresregel2 | PAVP04               |

    @fout-case
    Abstract Scenario: Afnemer vraagt om <fields> en is niet geautoriseerd voor <missende autorisatie>
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
      | fields                            | ad hoc rubrieken                                                                                                    | missende autorisatie |
      | adressering.adresregel1           | 10120 81110 81120 81130 81140 81150 81210 81310 81330 81340 81350 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP04  | adresregel1 (PAVP03) |
      | adressering.adresregel2           | 10120 81110 81120 81130 81140 81150 81210 81310 81330 81340 81350 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP03  | adresregel2 (PAVP04) |
      | adressering.adresregel3           | 10120 81110 81120 81130 81140 81150 81210 81310 81330 81340 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP03 PAVP04 | adresregel3 (81350)  |
      | adressering.land                  | 10120 81110 81120 81130 81140 81150 81210 81330 81340 81350 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP03 PAVP04 | land (81310)         |
      | adresseringBinnenland.adresregel1 | 10120 81110 81120 81130 81140 81150 81210 81310 81330 81340 81350 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP04  | adresregel1 (PAVP03) |
      | adresseringBinnenland.adresregel2 | 10120 81110 81120 81130 81140 81150 81210 81310 81330 81340 81350 PANM03 PANM04 PANM05 PANM06 PAVP01 PAVP02 PAVP03  | adresregel2 (PAVP04) |
