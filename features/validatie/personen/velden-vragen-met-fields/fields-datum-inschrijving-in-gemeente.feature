# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van het datumInschrijvinginGemeente veld

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het datumInschrijvingInGemeente veld wordt gevraagd met fields waarde 'datumInschrijvingInGemeente'
      Als het 'datumInschrijvingInGemeente' veld wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

  Regel: alle velden van datumInschrijvingInGemeente wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het datumInschrijvingInGemeente veld wordt gevraagd met fields waarde '<fields>'
      Als het '<fields>' veld wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                                   |
        | datumInschrijvingInGemeente.langFormaat  |
        | datumInschrijvingInGemeente.type         |
        | datumInschrijvingInGemeente.datum        |
        | datumInschrijvingInGemeente.onbekend     |
        | datumInschrijvingInGemeente.jaar         |
        | datumInschrijvingInGemeente.maand        |
        | datumInschrijvingInGemeente.nietBestaand |
