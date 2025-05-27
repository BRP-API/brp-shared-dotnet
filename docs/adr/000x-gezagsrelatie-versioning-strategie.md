# ADR 000x: versioning strategie voor de gezagsrelatie type

## Status
Voorstel

## Context
De definitie van de gezagsrelatie type moet worden gewijzigd. De gezagsrelatie 'tweehoofdig ouderlijk gezag' is niet de correcte benaming en moet worden hernoemd naar 'gezamenlijk ouderlijk gezag'.

Verder kan het voorkomen dat een ouder in een gezagsrelatie geen burgerservicenummer heeft. Van een ouder is wel altijd zijn naamgegevens bekend. Het verplichte burgerservicenummer veld van de ouder type moet hierdoor optioneel worden gemaakt en het naam veld verplicht.

Deze twee wijzigingen kunnen echter niet worden geïmplementeerd zonder het introduceren van een breaking change.

## Beslissing
Omdat het huidige aantal consumers dat de gezagsrelaties van een persoon bevraagt nog relatief beperkt is, is er gezocht naar een oplossing die geen impact heeft op consumers die nog geen gezagsrelaties van een persoon vraagt.

We hebben daarom besloten om de wijzigingen aan de gezagsrelatie type door te voeren alsof het non-breaking changes zijn. De personen API zal aan de hand van de claims meegestuurd in een request bepalen of de afnemer een legacy gezag consumer is. In dit geval wordt bij het vragen van gezagsrelaties de oude variant hiervan geleverd. Wanneer een legacy gezag consumer de nieuwe gezagsrelatie variant wilt ontvangen, dan moet hij bij een request de header 'accept-gezag-version' met waarde '2' meesturen.

## Consequenties
**Voordelen:**
- Afnemers die nog geen gezagsrelaties van een persoon bevraagt hebben geen last van de breaking changes.
- Huidige gezagsrelatie afnemers kunnen binnen de opgegeven sunset periode bepalen wanneer zij hun applicaties aanpassen voor de nieuwe gezagsrelatie type.

**Nadelen:**
- De gekozen oplossing is niet geheel waterdicht. Wanneer een legacy gezag consumer niet wordt gedetecteerd, dan zal deze consumer last hebben van de breaking change.
- Wanneer een legacy gezag consumer de 'accept-gezag-version' header met een request meestuurt, dan moet deze niet door de API gateway worden gefilterd. Anders kan niet worden gedetecteerd dat een legacy gezag consumer de nieuwe gezagsrelatie type wenst te ontvangen.

## Overwogen alternatieven
TODO

## Afspraken
De Autorisatie en Protocollering service bepaalt aan de hand van een configuratie setting of een request is gestuurd door een legacy gezag consumer. Indien dit niet het geval is, dan wordt door de Autorisatie en Protocollering service de 'accept-gezag-version' header met waarde '2' toegevoegd aan de request voordat deze wordt gerouteerd naar de informatie service, data service en gezag API. De gezag API zal voor elke request met de 'accept-gezag-version' header een response met de nieuwe gezagsrelatie type leveren. Bij een request zonder de 'accept-gezag-version' header wordt een response met de oude gezagsrelatie type geleverd.

De volgende sequence diagram geeft dit proces schematisch weer.

``` mermaid
sequenceDiagram
    consumer->>AP:request zonder<br>accept-gezag-version header
    alt is legacy gezag consumer
    AP->>Info:request zonder<br>accept-gezag-version header
    Info->>Data:request zonder<br>accept-gezag-version header
    Data->>Gezag:request zonder<br>accept-gezag-version header
    Gezag->>Data:response met<br>oude gezag
    Data->>Info:response met<br>oude gezag
    Info->>AP:response met<br>oude gezag
    AP->>consumer:response met<br>oude gezag
    else is geen legacy gezag consumer
    AP->>Info:request met<br>accept-gezag-version header
    Info->>Data:request met<br>accept-gezag-version header
    Data->>Gezag:request met<br>accept-gezag-version header
    Gezag->>Data:response met<br>nieuwe gezag
    Data->>Info:response met<br>nieuwe gezag
    Info->>AP:response met<br>nieuwe gezag
    AP->>consumer:response met<br>nieuwe gezag
    end
    consumer->>AP:request met<br>accept-gezag-version header
    AP->>Info:request met<br>accept-gezag-version header
    Info->>Data:request met<br>accept-gezag-version header
    Data->>Gezag:request met<br>accept-gezag-version header
    Gezag->>Data:response met<br>nieuwe gezag
    Data->>Info:response met<br>nieuwe gezag
    Info->>AP:response met<br>nieuwe gezag
    AP->>consumer:response met<br>nieuwe gezag
```

Om het gedrag van de BRP API met en zonder de 'accept-gezag-version' header te testen is aan de World class (features/step_definitions/world.js) de boolean property 'addAcceptGezagVersionHeader' toegevoeg. Standaard (waarde = false) wordt er bij elke request geen 'accept-gezag-version' header meegestuurd. Ook zijn er in cucumber.js de twee Cucumber profielen, testOud en testNieuw, gedefinieerd om het uitvoeren van de nieuwe/deprecated features/scenarios samen met de niet-gewijzigde features/scenarios te vereenvoudigen.
Voor het uitvoeren van alle nieuwe (2.7.0) features/scenarios en de niet-gewijzigde features/scenarios ziet de cucumber aanroep er als volgt uit: `npx cucumber-js features -p testNieuw` en voor het uitvoeren van alle deprecated features/scenarios en de niet-gewijzigde features/scenarios ziet de cucumber aanroep er als volgt uit: `npx cucumber-js features -p testOud`.
Hiervoor moeten de nieuwe features/scenarios worden getagd met `@2.7.0` en de de deprecated features/scenarios met `@deprecated`.
