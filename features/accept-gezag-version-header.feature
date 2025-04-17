# language: nl
Functionaliteit: toevoegen van de accept-gezag-version header aan een gezag bevraging
  Als provider
  wil ik dat voor nieuwe gezag afnemers de accept-gezag-version header wordt toegevoegd aan hun bevraging
  zodat de gezag API in dit geval de nieuwe versie van gezagsrelatie levert

  Een bestaande afnemer is een afnemer die staat op de bestaande afnemerslijst

  Achtergrond:
    Gegeven adres 'A1'
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      |                 0599 |                         0599010000219679 |

  Scenario: een gezag bevraging wordt gedaan door een nieuwe afnemer
    Gegeven een nieuwe afnemer is geautoriseerd voor het vragen van 'gezag'
    Als 'gezag' wordt gevraagd van personen gezocht met <zoek methode>
    Dan bevat de request naar de gezag API de header 'accept-gezag-version' met waarde '2'

    Voorbeelden:
      | zoek methode                                |
      | burgerservicenummer '000000012'             |
      | adresseerbaar object identificatie van 'A1' |

  Scenario: een gezag bevraging wordt gedaan door een bestaande afnemer
    Gegeven een bestaande afnemer is geautoriseerd voor het vragen van gezag
    Als 'gezag' wordt gevraagd van personen gezocht met <zoek methode>
    Dan bevat de request naar de gezag API geen 'accept-gezag-version' header

    Voorbeelden:
      | zoek methode                                |
      | burgerservicenummer '000000012'             |
      | adresseerbaar object identificatie van 'A1' |

  Scenario: een gezag bevraging met 'accept-gezag-version' header wordt gedaan door een bestaande afnemer
    Gegeven een bestaande afnemer is geautoriseerd voor het vragen van gezag
    Als 'gezag' wordt gevraagd van personen gezocht met <zoek methode> en headers
      | accept-gezag-version |
      |                    2 |
    Dan bevat de request naar de gezag API de header 'accept-gezag-version' met waarde '2'

    Voorbeelden:
      | zoek methode                                |
      | burgerservicenummer '000000012'             |
      | adresseerbaar object identificatie van 'A1' |
