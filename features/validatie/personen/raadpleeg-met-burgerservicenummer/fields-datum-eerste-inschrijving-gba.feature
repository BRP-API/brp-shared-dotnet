# language: nl
@input-validatie
Functionaliteit: datumEersteInschrijvingGBA veld vragen met fields bij raadplegen met burgerservicenummer

  Regel: bij het vragen van datumEersteInschrijvingGBA of bestaande/niet-bestaande velden van datumEersteInschrijvingGBA wordt alle velden van datumEersteInschrijvingGBA geleverd

    Abstract Scenario: het datumEersteInschrijvingGBA veld wordt gevraagd met fields waarde '<fields>'
      Als het '<fields>' veld van een persoon
      Dan heeft de response 0 personen

      Voorbeelden:
        | fields                                  |
        | datumEersteInschrijvingGBA              |
        | datumEersteInschrijvingGBA.langFormaat  |
        | datumEersteInschrijvingGBA.type         |
        | datumEersteInschrijvingGBA.datum        |
        | datumEersteInschrijvingGBA.onbekend     |
        | datumEersteInschrijvingGBA.jaar         |
        | datumEersteInschrijvingGBA.maand        |
        | datumEersteInschrijvingGBA.nietBestaand |
