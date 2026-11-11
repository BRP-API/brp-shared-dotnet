#language: nl

Functionaliteit: Health check endpoint van de Autorisatie en Protocollering Proxy
  Als provider
  wil ik dat de Autorisatie en Protocollering Proxy een health check endpoint heeft
  zodat ik kan controleren of de proxy beschikbaar is

  Scenario: Health check endpoint van de Autorisatie en Protocollering Proxy is beschikbaar
    Wanneer een GET request wordt gedaan naar het health check endpoint van de Autorisatie en Protocollering Proxy
    Dan is de response healthy
