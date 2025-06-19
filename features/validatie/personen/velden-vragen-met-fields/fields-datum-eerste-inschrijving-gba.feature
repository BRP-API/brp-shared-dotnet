# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van het datumEersteInschrijvingGBA veld

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Scenario: het datumEersteInschrijvingGBA veld wordt gevraagd met fields waarde 'datumEersteInschrijvingGBA'
      Als 'datumEersteInschrijvingGBA' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

  Regel: alle velden van datumEersteInschrijvingGBA wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het datumEersteInschrijvingGBA veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                  |
        | datumEersteInschrijvingGBA.langFormaat  |
        | datumEersteInschrijvingGBA.type         |
        | datumEersteInschrijvingGBA.datum        |
        | datumEersteInschrijvingGBA.onbekend     |
        | datumEersteInschrijvingGBA.jaar         |
        | datumEersteInschrijvingGBA.maand        |
        | datumEersteInschrijvingGBA.nietBestaand |
