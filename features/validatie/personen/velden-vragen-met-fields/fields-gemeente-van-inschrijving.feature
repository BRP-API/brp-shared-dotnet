# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van het gemeente van inschrijving veld

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Scenario: het gemeenteVanInschrijving veld wordt gevraagd met fields waarde 'gemeente'
      Als 'gemeenteVanInschrijving' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

  Regel: alle velden van gemeenteVanInschrijving wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                               |
        | gemeenteVanInschrijving.code         |
        | gemeenteVanInschrijving.omschrijving |
        | gemeenteVanInschrijving.nietBestaand |
