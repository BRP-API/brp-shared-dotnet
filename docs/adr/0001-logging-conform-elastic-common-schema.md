# Logging in de BRP APIs geïmplementeerd in .NET conform de Elastic Common Schema 

## Status

voorstel

## Context

Om te kunnen monitoren of een BRP API goed functioneert en goed blijft functioneren, is het noodzakelijk dat de verschillende sub-systemen waaruit een BRP API bestaat op een zodanige manier gaan loggen zodat het makkelijk wordt om dit uit de logs te halen. De best practice om dit te realiseren, is de log berichten niet als platte tekst te formatteren, maar als gestructureerd data in json formaat.

De logs van de BRP APIs zullen worden verwerkt met behulp van producten uit de ELK-suite. Om de log gegevens makkelijker te kunnen verwerken en beter te kunnen analyseren, visualiseren en te correleren is het noodzakelijk dat de logs van de verschillende sub-systemen van een BRP API zich conformeren aan één formaat. De [Elastic Common Schema](https://www.elastic.co/guide/en/ecs/current/ecs-reference.html) is hiervoor ontwikkeld en wordt beschouw als de standaard formaat voor het verwerken van logs met behulp van de ELK-suite.

## Beslissing

Om log regels gestructureerd conform de Elastic Common Schema te formatteren, moet elk sub-systeem van een BRP API die wordt geïmplementeerd met behulp van .NET gebruik maken van de volgende libraries:

- [Serilog](https://serilog.net/), een .NET logging library dat met als hoofddoel is geïmplementeerd om log gegevens gestructureerd te kunnen loggen.
- [Elastic Common Schema Serilog Text Formatter](https://github.com/elastic/ecs-dotnet/tree/main/src/Elastic.CommonSchema.Serilog), een .NET library van Elasticsearch waarmee Serilog wordt geïnstrueerd om log regels te formatteren conform de Elastic Common Schema specificatie.

Het gebruiken van deze libraries maakt het mogelijk om met beperkte hoeveelheid custom code (voornamelijk code om Serilog en de ECS Text Formatter te configureren) gestructureerd te kunnen loggen conform de Elastic Common Schema specificatie. Voorbeelden van log regels gegenereerd volgens de Elastic Common Schema zijn te vinden in de [Voorbeeld log regels](#voorbeeld-log-regels) paragraaf. De log regels (elke request = 1 log regel) en de velden in de log regels zijn met uitzondering van de request.body.content, response.body.content en metadata velden automatisch gegenereerd en gevuld door Serilog de Elastic Common Schema Text Formatter. 

Met behulp van Serilog is het ook mogelijk om custom objecten als een data structuur toe te laten voegen aan een log regel (= destructuring) in plaats van geserialiseerd als tekst. Het grote voordeel hiervan is dat er naar en in log regels kan worden gezocht op basis van veld namen en waarden binnen zo'n data structuur in plaats van door log regels te parsen. Een voorbeeld van een destructured object is de metadata.request.body veld van de [Voorbeeld log regel voor een succesvol afgehandeld request](#voorbeeld-log-regel-voor-een-succesvol-afgehandeld-request) 

## Voorbeeld log regels

Deze paragraaf bevat ter illustratie van de werking van Serilog met de Elastic Common Schema Text Formatter, voorbeeld log regels van de Reisdocumenten proxy voor de volgende gebeurtenissen:

- een succesvol afgehandeld request
- een request met ongeldig input data
- een request dat tot een onverwachte fout leidt

De volgende tabel is een overzicht van de velden die qua naamgeving en/of inhoud verschillen van de velden die staan beschreven onder paragraaf 2.2 Definitie logging van het 230425 Logging BRP API v0.8 document

| Serilog + ECS | ECS volgens logging document | opmerkingen |
|---------------|------------------------------|-------------|
| http.request.id | request.id | |
| service.version | version | |
| agent.type & agent.version | agent.name | |
| host.hostname | hostname | |
| | token | TODO |
| http.request.body.content | request.body.stringified | gewenste type en fields velden staan in de destructured metadata.request.body veld |
| http.response.body.content |http.response.body| |
| error | TODO?| in ECS is voor excepties het error object gedefinieerd met stack_trace veld voor de stack trace. Dit wordt automatisch door Serilog + ECS gevuld | 

### Voorbeeld log regel voor een succesvol afgehandeld request

```json
{
    "@timestamp": "2024-02-06T17:51:57.0807865+01:00",
    "log.level": "Information",
    "message": "HTTP \"POST\" \"/haalcentraal/api/reisdocumenten/reisdocumenten\" responded 200 in 381.5390 ms",
    "ecs.version": "8.6.0",
    "log": {
        "logger": "Serilog.AspNetCore.RequestLoggingMiddleware"
    },
    "span.id": "9bc7cd8933c7de41",
    "trace.id": "44f299b86683bc456a4a92adc70d771b",
    "labels": {
        "MessageTemplate": "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms",
        "ConnectionId": "0HN176FMTA88H"
    },
    "agent": {
        "type": "Elastic.CommonSchema.Serilog",
        "version": "8.6.1+88f2bc81a0b7440e4059e323e610bb03df61862c"
    },
    "event": {
        "created": "2024-02-06T17:51:57.0807865+01:00",
        "duration": 381539000,
        "severity": 2,
        "timezone": "W. Europe Standard Time"
    },
    "host": {
        "os": {
            "full": "Microsoft Windows 10.0.22631",
            "platform": "Win32NT",
            "version": "10.0.22631.0"
        },
        "architecture": "X64",
        "hostname": "NUC11TNK"
    },
    "http": {
        "request.body.content": "{\"type\":\"RaadpleegMetReisdocumentnummer\",\"reisdocumentnummer\":[\"NE3663258\"],\"fields\":[\"reisdocumentnummer\",\"houder\"]}",
        "request.id": "0HN176FMTA88H:00000001",
        "request.method": "POST",
        "request.mime_type": "application/json",
        "response.body.content": "{\"type\":\"RaadpleegMetReisdocumentnummer\",\"reisdocumenten\":[{\"reisdocumentnummer\":\"NE3663258\",\"houder\":{\"burgerservicenummer\":\"000000152\"}}]}",
        "response.mime_type": "application/json; charset=utf-8",
        "response.status_code": 200
    },
    "process": {
        "name": "ReisdocumentProxy",
        "pid": 35308,
        "thread.id": 14,
        "thread.name": ".NET TP Worker",
        "title": ""
    },
    "service": {
        "name": "ReisdocumentProxy",
        "type": "dotnet",
        "version": "2.0.3+2024020616.1.35fdf372a72da9ddb15726107b6b5ee21a39753f"
    },
    "url": {
        "path": "/haalcentraal/api/reisdocumenten/reisdocumenten"
    },
    "user": {
        "domain": "NUC11TNK",
        "name": "......"
    },
    "metadata": {
        "request.headers": [
            "[Accept, application/json]",
            "[Connection, keep-alive]",
            "[Host, localhost:5000]",
            "[User-Agent, axios/1.6.7]",
            "[Accept-Encoding, gzip, compress, deflate, br]",
            "[Authorization, Basic MDAwMDA4fDgwMDp0ZW1wc29sdXRpb24h]",
            "[Content-Type, application/json]",
            "[Content-Length, 117]"
        ],
        "request.body": {
            "Reisdocumentnummer": [
                "NE3663258"
            ],
            "Fields": [
                "reisdocumentnummer",
                "houder"
            ],
            "AdditionalProperties": {},
            "$type": "RaadpleegMetReisdocumentnummer"
        }
    }
}
```

### Voorbeeld log regel voor een request met ongeldig input data

```json
{
    "@timestamp": "2024-02-06T18:03:33.1953642+01:00",
    "log.level": "Warning",
    "message": "HTTP \"POST\" \"/haalcentraal/api/reisdocumenten/reisdocumenten\" responded 400 in 12.3939 ms",
    "ecs.version": "8.6.0",
    "log": {
        "logger": "Serilog.AspNetCore.RequestLoggingMiddleware"
    },
    "span.id": "a420527657191fd8",
    "trace.id": "aba894608d0865f38ff8be55ee2830a0",
    "labels": {
        "MessageTemplate": "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms",
        "ConnectionId": "0HN176FMTA88I"
    },
    "agent": {
        "type": "Elastic.CommonSchema.Serilog",
        "version": "8.6.1+88f2bc81a0b7440e4059e323e610bb03df61862c"
    },
    "event": {
        "created": "2024-02-06T18:03:33.1953642+01:00",
        "duration": 12393900,
        "severity": 3,
        "timezone": "W. Europe Standard Time"
    },
    "host": {
        "os": {
            "full": "Microsoft Windows 10.0.22631",
            "platform": "Win32NT",
            "version": "10.0.22631.0"
        },
        "architecture": "X64",
        "hostname": "NUC11TNK"
    },
    "http": {
        "request.body.content": "{\"type\":\"RaadpleegMetReisdocumentnummer\",\"fields\":[\"reisdocumentnummer\"]}",
        "request.id": "0HN176FMTA88I:00000001",
        "request.method": "POST",
        "request.mime_type": "application/json",
        "response.body.content": "{\"invalidParams\":[{\"name\":\"reisdocumentnummer\",\"code\":\"required\",\"reason\":\"Parameter is verplicht.\"}],\"type\":\"https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1\",\"title\":\"Een of meerdere parameters zijn niet correct.\",\"status\":400,\"detail\":\"De foutieve parameter(s) zijn: reisdocumentnummer.\",\"instance\":\"/haalcentraal/api/reisdocumenten/reisdocumenten\",\"code\":\"paramsValidation\"}",
        "response.mime_type": "application/problem+json",
        "response.status_code": 400
    },
    "process": {
        "name": "ReisdocumentProxy",
        "pid": 35308,
        "thread.id": 26,
        "thread.name": ".NET TP Worker",
        "title": ""
    },
    "service": {
        "name": "ReisdocumentProxy",
        "type": "dotnet",
        "version": "2.0.3+2024020616.1.35fdf372a72da9ddb15726107b6b5ee21a39753f"
    },
    "url": {
        "path": "/haalcentraal/api/reisdocumenten/reisdocumenten"
    },
    "user": {
        "domain": "NUC11TNK",
        "name": "......"
    },
    "metadata": {
        "request.headers": [
            "[Accept, application/json]",
            "[Connection, keep-alive]",
            "[Host, localhost:5000]",
            "[User-Agent, axios/1.6.7]",
            "[Accept-Encoding, gzip, compress, deflate, br]",
            "[Authorization, Basic MDAwMDA4fDgwMDp0ZW1wc29sdXRpb24h]",
            "[Content-Type, application/json]",
            "[Content-Length, 73]"
        ]
    }
}
```

### Voorbeeld log regel voor een request dat tot een onverwachte fout leidt

```json
{
    "@timestamp": "2024-02-06T18:04:30.0958902+01:00",
    "log.level": "Error",
    "message": "HTTP \"POST\" \"/haalcentraal/api/reisdocumenten/reisdocumenten\" responded 500 in 50.5894 ms",
    "ecs.version": "8.6.0",
    "log": {
        "logger": "Serilog.AspNetCore.RequestLoggingMiddleware"
    },
    "span.id": "f12cce8e45b5b51e",
    "trace.id": "626d7942f74d8ece6354f1ce386e7b75",
    "labels": {
        "MessageTemplate": "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms",
        "ConnectionId": "0HN176MNDPLPG"
    },
    "agent": {
        "type": "Elastic.CommonSchema.Serilog",
        "version": "8.6.1+88f2bc81a0b7440e4059e323e610bb03df61862c"
    },
    "error": {
        "message": "Operation is not valid due to the current state of the object.",
        "stack_trace": "System.InvalidOperationException: Operation is not valid due to the current state of the object.\r\n   at async Task ReisdocumentProxy.Middlewares.OverwriteResponseBodyMiddleware.Invoke(HttpContext context) in C:/Projects/haal-centraal/nieuw/Haal-Centraal-Reisdocumenten-bevragen/src/ReisdocumentProxy/Middlewares/OverwriteResponseBodyMiddleware.cs:line 99",
        "type": "System.InvalidOperationException"
    },
    "event": {
        "created": "2024-02-06T18:04:30.0958902+01:00",
        "duration": 50589400,
        "severity": 4,
        "timezone": "W. Europe Standard Time"
    },
    "host": {
        "os": {
            "full": "Microsoft Windows 10.0.22631",
            "platform": "Win32NT",
            "version": "10.0.22631.0"
        },
        "architecture": "X64",
        "hostname": "NUC11TNK"
    },
    "http": {
        "request.body.content": "{\"type\":\"RaadpleegMetReisdocumentnummer\",\"reisdocumentnummer\":[\"NE3663258\"],\"fields\":[\"reisdocumentnummer\",\"houder\"]}",
        "request.id": "0HN176MNDPLPG:00000001",
        "request.method": "POST",
        "request.mime_type": "application/json",
        "response.body.content": "{\"type\":\"https://datatracker.ietf.org/doc/html/rfc7231#section-6.6.1\",\"title\":\"Internal Server error.\",\"status\":500,\"instance\":\"/haalcentraal/api/reisdocumenten/reisdocumenten\"}",
        "response.mime_type": "application/problem+json",
        "response.status_code": 500
    },
    "process": {
        "name": "ReisdocumentProxy",
        "pid": 32512,
        "thread.id": 9,
        "thread.name": ".NET TP Worker",
        "title": ""
    },
    "service": {
        "name": "ReisdocumentProxy",
        "type": "dotnet",
        "version": "2.0.3+2024020617.1.35fdf372a72da9ddb15726107b6b5ee21a39753f"
    },
    "url": {
        "path": "/haalcentraal/api/reisdocumenten/reisdocumenten"
    },
    "user": {
        "domain": "NUC11TNK",
        "name": "......"
    },
    "metadata": {
        "request.headers": [
            "[Accept, application/json]",
            "[Connection, keep-alive]",
            "[Host, localhost:5000]",
            "[User-Agent, axios/1.6.7]",
            "[Accept-Encoding, gzip, compress, deflate, br]",
            "[Authorization, Basic MDAwMDA4fDgwMDp0ZW1wc29sdXRpb24h]",
            "[Content-Type, application/json]",
            "[Content-Length, 117]"
        ],
        "ExceptionDetail": {
            "Type": "System.InvalidOperationException",
            "HResult": -2146233079,
            "Message": "Operation is not valid due to the current state of the object.",
            "Source": "ReisdocumentProxy",
            "TargetSite": "Void MoveNext()"
        }
    }
}
```
