# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van het geslacht veld

  Abstract Scenario: het geslacht veld wordt gevraagd met fields waarde 'geslacht'
    Als 'geslacht' wordt gevraagd van personen gezocht met <zoek methode>
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

  Regel: het geslacht veld wordt geleverd als bestaande/niet-bestaande sub-velden hiervan wordt gevraagd

    Abstract Scenario: het <fields> veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | fields                | zoek methode                       |
        | geslacht.code         | burgerservicenummer                |
        | geslacht.omschrijving | geslachtsnaam en geboortedatum     |
        | geslacht.nietBestaand | adresseerbaar object identificatie |
