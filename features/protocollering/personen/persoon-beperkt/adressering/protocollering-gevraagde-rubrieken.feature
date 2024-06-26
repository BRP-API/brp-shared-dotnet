#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor adresregels

  Regel: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën, of een alphanumerieke code voor informatievragen.

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken <gevraagde rubrieken>
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | pl_id |
      | 1001  |
      En de response van de downstream api heeft de volgende headers
      | x-geleverde-pls |
      | 1001            |
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | <fields>                            |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                            | gevraagde rubrieken            |
      | adressering.adresregel1           | PAVP03                         |
      | adressering.adresregel2           | PAVP04                         |
      | adressering.adresregel3           | 081350                         |
      | adressering.land                  | 081310                         |
      | adressering.land.code             | 081310                         |
      | adressering.land.omschrijving     | 081310                         |
      | adressering                       | 081310, 081350, PAVP03, PAVP04 |
      | adresseringBinnenland.adresregel1 | PAVP03                         |
      | adresseringBinnenland.adresregel2 | PAVP04                         |
      | adresseringBinnenland             | PAVP03, PAVP04                 |
