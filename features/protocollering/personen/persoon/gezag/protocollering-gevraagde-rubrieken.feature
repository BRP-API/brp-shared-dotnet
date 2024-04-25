#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor gezag

  Regel: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP

    Scenario: Met fields vragen om gezag wordt vastgelegd als gevraagde rubrieken PAGZ01
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | pl_id |
      | 1001  |
      En de response van de downstream api heeft de volgende headers
      | x-geleverde-pls |
      | 1001            |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | gezag                           |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | PAGZ01                      |
