# language: nl

@autorisatie
Functionaliteit: autorisatie verblijfplaatshistorie raadplegen met peildatum

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | straatnaam (11.10) |
      | 0530                 | 0530010000000001                         | Eerste straat      |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0530                              | 20000101                           |

  Regel: Wanneer verblijfplaatshistorie wordt geraadpleegd waarvoor de gebruiker niet geautoriseerd is, wordt een foutmelding gegeven
    Om verblijfplaatshistorie te mogen vragen moet de afnemer geautoriseerd zijn voor virtuele rubriek PX.VP.07

    @geen-protocollering
    Abstract Scenario: Afnemer vraagt verblijfplaatshistorie, en <omschrijving>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam      | waarde |
      | afnemerID | 000008 |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2023-05-26            |
      Dan heeft de response 1 verblijfplaats

      Voorbeelden:
      | ad hoc rubrieken                                                                                                                                                                                                                            | omschrijving                                                                                    |
      | PXVP07                                                                                                                                                                                                                                      | heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen                    |
      | 10120 80910 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81330 81340 81350 PAVP01 PAVP02 PAVP03 PAVP04 PXVP07                                                                                              | is alleen geautoriseerd voor actuele verblijfplaatsgegevens en ook voor verblijfplaatshistorie  |
      | 10120 80910 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81330 81340 81350 580910 581115 581120 581130 581140 581150 581160 581170 581180 581190 581210 581310 581330 581340 581350 PAVP01 PAVP02 PAVP03 PAVP04 PXVP07 | is geautoriseerd voor een deel van de verblijfplaatsgegevens en ook voor verblijfplaatshistorie |
      | 10120 80910 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 580910 581010 581110 581115 581120 581130 581140 581150 581160 581170 581180 581190 581210 PAVP01 PAVP02 PAVP03 PAVP04 PXVP07                           | is geautoriseerd voor binnenlandse verblijfplaatsgegevens en ook voor verblijfplaatshistorie    |

    @fout-case
    Scenario: Afnemer vraagt verblijfplaatshistorie, maar is niet geautoriseerd voor PX.VP.07 en wel voor alle losse rubrieken
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60)                                                                                                                                                                                                                                | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120 80910 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81330 81340 81350 580910 581010 581110 581115 581120 581130 581140 581150 581160 581170 581180 581190 581210 581310 581330 581340 581350 PAVP01 PAVP02 PAVP03 PAVP04 | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam      | waarde |
      | afnemerID | 000008 |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2023-05-26            |
      Dan heeft de response de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3 |
      | title    | U bent niet geautoriseerd voor het gebruik van deze API.    |
      | status   | 403                                                         |
      | detail   | Niet geautoriseerd voor verblijfplaatshistorie.             |
      | code     | unauthorized                                                |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |


  Regel: Een gemeente als afnemer is geautoriseerd voor alle verblijfplaats gegevens
    Wanneer gemeenteCode in de 'claim' in de OAuth token gevuld is,
    dan wordt niet gekeken naar de autorisatie van de afnemer

    @geen-protocollering     
    Abstract Scenario: Gemeente vraagt om verblijfplaatshistorie en <omschrijving>
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | <ad hoc rubrieken>              | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2023-05-26            |
      Dan heeft de response 1 verblijfplaats

      Voorbeelden:
      | ad hoc rubrieken                                                                                                                                                                                                                            | omschrijving                                                                                    |
      | PXVP07                                                                                                                                                                                                                                      | heeft uitsluitend de autorisatie die nodig is om deze vraag te mogen stellen                    |
      | 10120 80910 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81330 81340 81350 PAVP01 PAVP02 PAVP03 PAVP04 PXVP07                                                                                              | is alleen geautoriseerd voor actuele verblijfplaatsgegevens en voor verblijfplaatshistorie      |
      | 10120 80910 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81330 81340 81350 580910 581115 581120 581130 581140 581150 581160 581170 581180 581190 581210 581310 581330 581340 581350 PAVP01 PAVP02 PAVP03 PAVP04 PXVP07 | is geautoriseerd voor een deel van de verblijfplaatsgegevens en voor verblijfplaatshistorie     |
      | 10120 80910 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 580910 581010 581110 581115 581120 581130 581140 581150 581160 581170 581180 581190 581210 PAVP01 PAVP02 PAVP03 PAVP04 PXVP07                           | is alleen geautoriseerd voor binnenlandse verblijfplaatsgegevens en voor verblijfplaatshistorie |
