#language: nl

@input-validatie
Functionaliteit: geldige fields waarde voor het vragen van het indicatie curatele register veld

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Scenario: het indicatieCurateleRegister veld wordt gevraagd met fields waarde 'indicatieCurateleRegister'
      Als 'indicatieCurateleRegister' wordt gevraagd van personen gezocht met burgerservicenummer
      Dan heeft de response geen foutmelding
