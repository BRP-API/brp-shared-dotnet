# language: nl
@input-validatie
Functionaliteit: datumInschrijvinginGemeente veld vragen met fields bij raadplegen met burgerservicenummer

  Regel: bij het vragen van datumInschrijvingInGemeente of bestaande/niet-bestaande velden van datumInschrijvingInGemeente wordt alle velden van datumInschrijvingInGemeente geleverd

    Abstract Scenario: het datumInschrijvingInGemeente veld wordt gevraagd met fields waarde '<fields>'
      Als het '<fields>' veld van een persoon
      Dan heeft de response 0 personen

      Voorbeelden:
        | fields                                   |
        | datumInschrijvingInGemeente              |
        | datumInschrijvingInGemeente.langFormaat  |
        | datumInschrijvingInGemeente.type         |
        | datumInschrijvingInGemeente.datum        |
        | datumInschrijvingInGemeente.onbekend     |
        | datumInschrijvingInGemeente.jaar         |
        | datumInschrijvingInGemeente.maand        |
        | datumInschrijvingInGemeente.nietBestaand |
