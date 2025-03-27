# language: nl
@input-validatie
Functionaliteit: geldige fields waarde voor het vragen van het leeftijd veld

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het leeftijd veld wordt gevraagd met fields waarde 'leeftijd'
      Als 'leeftijd' wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | zoek methode                                          |
        | burgerservicenummer                                   |
        | adresseerbaar object identificatie                    |
        | geslachtsnaam en geboortedatum                        |
        | geslachtsnaam, voornamen en gemeente van inschrijving |
        | nummeraanduiding identificatie                        |
        | postcode en huisnummer                                |
        | straatnaam, huisnummer en gemeente van inschrijving   |
