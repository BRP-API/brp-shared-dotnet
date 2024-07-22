# Logging van de BRP API microservices, geïmplementeerd in .NET zijn conform de Elastic Common Schema 

## Status

voorstel

## Context

Om makkelijk te kunnen monitoren of de microservices van de BRP API goed functioneren en goed blijft functioneren, is het noodzakelijk dat de BRP API microservices gegevens hiervoor vastlegt. Een best practice om dit te realiseren is om de benodigde gegevens te loggen als gestructureerde data in json formaat (structured logging).

De logs van de BRP APIs zullen worden verwerkt met behulp van producten uit de ELK-suite. Om de log gegevens makkelijker te kunnen verwerken en beter te kunnen analyseren, te visualiseren en te correleren is het noodzakelijk dat de logs van de BRP API microservices zich conformeren aan één formaat. De [Elastic Common Schema](https://www.elastic.co/guide/en/ecs/current/ecs-reference.html) is hiervoor ontwikkeld en wordt beschouwd als het standaard formaat voor het verwerken van logs met behulp van de ELK-suite.

## Beslissing

Om log regels gestructureerd conform het Elastic Common Schema te formatteren, moet elk BRP API microservice geïmplementeerd in .NET gebruik maken van de volgende libraries:

- [Serilog](https://serilog.net/), een .NET logging library met als hoofddoel gegevens gestructureerd te loggen.
- [Elastic Common Schema Serilog Text Formatter](https://github.com/elastic/ecs-dotnet/tree/main/src/Elastic.CommonSchema.Serilog), een .NET library van Elasticsearch waarmee Serilog wordt geïnstrueerd om log regels te formatteren conform de Elastic Common Schema specificatie.

Het gebruik van deze libraries maakt het mogelijk om met een beperkte hoeveelheid custom code (voornamelijk code om Serilog en de ECS Text Formatter te configureren) gestructureerd te kunnen loggen conform de Elastic Common Schema specificatie. Voorbeelden van log regels die zijn gegenereerd door Serilog volgens de Elastic Common Schema zijn te vinden in de [Voorbeeld log regels](#voorbeeld-log-regels) paragraaf. De log regels en de velden in een log regel zijn, met uitzondering van de request.body.content, response.body.content en brp velden, automatisch gegenereerd en gevuld door Serilog met de Elastic Common Schema Serilog Text Formatter. 

Met Serilog kunnen .NET objecten als JSON objecten worden toegevoegd aan een log regel (= destructuring) in plaats van geserialiseerd als tekst. Het grote voordeel hiervan is dat er naar log regels én in log regels kan worden gezocht op basis van de veld namen en waarden binnen zo'n destructured object in plaats van door de inhoud van de log regels te parsen. Het brp veld is het destructured object waarin de BRP API microservices hun log gegevens vastleggen.

### Afspraken

- Voor elke request/response wordt ten hoogste één log regel gegenereerd
- Een health check request/response wordt niet gelogd
- De volgende log levels worden gehanteerd voor een log regel:
  - information voor een 2xx response
  - warning voor een 4xx response
  - error voor een 5xx response
- Voor het loggen van een exception moet de DiagnosticContext.SetException methode worden gebruikt. Dit zorgt ervoor dat de exceptie wordt weggeschreven in de ECS [error velden](https://www.elastic.co/guide/en/ecs/8.11/ecs-error.html) van een log regel
- Er worden twee log stromen gebruikt:
  - secured. Log regels binnen deze stroom mogen privacy gevoelige informatie bevatten zodat issues die optreden in een specifieke situatie kunnen worden opgelost zonder de situatie opnieuw te moeten reproduceren 
  - unsecured. Log regels binnen deze stroom mogen geen privacy gevoelige informatie bevatten. De inhoud van privacy gevoelige velden moeten worden gemaskeerd

## Voorbeeld log regels

Deze paragraaf bevat voorbeeld log regels van de Autorisatie en Protocollering microservice, gegenereerd door Serilog en de Elastic Common Schema Serilog Text Formatter, voor de volgende gebeurtenissen:

- een succesvol afgehandeld request
- een request met ongeldig input data
- een request dat tot een onverwachte fout leidt

### Voorbeeld log regel voor een succesvol afgehandeld request

```json
{
    "@timestamp": "2024-07-11T11:05:22.7945983+02:00",
    "log.level": "Information",
    "message": "HTTP \"POST\" \"/haalcentraal/api/brphistorie/verblijfplaatshistorie\" responded 200 in 2710.5636 ms",
    "ecs.version": "8.11.0",
    "log": {
        "logger": "Serilog.AspNetCore.RequestLoggingMiddleware"
    },
    "span.id": "d68926c5209d59ca",
    "trace.id": "eb2f31761eb14d0827751dd95ff25781",
    "labels": {
        "MessageTemplate": "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms",
        "ConnectionId": "0HN51H2BFFNBP"
    },
    "agent": {
        "type": "Elastic.CommonSchema.Serilog",
        "version": "8.11.1+69a082298d546f804e5610128818fbf9154b9958"
    },
    "event": {
        "created": "2024-07-11T11:05:22.7945983+02:00",
        "duration": 2710563630,
        "severity": 2,
        "timezone": "Central European Standard Time"
    },
    "host": {
        "os": {
            "full": "Linux 5.15.90.1-microsoft-standard-WSL2 #1 SMP Fri Jan 27 02:56:13 UTC 2023",
            "platform": "Unix",
            "version": "5.15.90.1"
        },
        "architecture": "X64",
        "hostname": "fe1fbfd2ff7e"
    },
    "http": {
        "request.id": "0HN51H2BFFNBP:00000002",
        "request.method": "POST",
        "response.mime_type": "application/json; charset=utf-8",
        "response.status_code": 200
    },
    "process": {
        "name": "dotnet",
        "pid": 1,
        "thread.id": 8,
        "thread.name": ".NET ThreadPool Worker",
        "title": ""
    },
    "service": {
        "name": "Brp.AutorisatieEnProtocollering.Proxy",
        "type": "dotnet",
        "version": "1.2.0+202407021819"
    },
    "url": {
        "path": "/haalcentraal/api/brphistorie/verblijfplaatshistorie"
    },
    "user": {
        "domain": "fe1fbfd2ff7e",
        "name": "root"
    },
    "brp": {
        "autorisatie": "afnemer: 8 is gemeente '800'",
        "claims": {
            "OIN": "000000099000000080000",
            "afnemerID": "000008",
            "gemeenteCode": "0800"
        },
        "protocollering": "[\"1\"]",
        "request.headers": {
            "Accept": [
                "application/json"
            ],
            "Connection": [
                "keep-alive"
            ],
            "Host": [
                "localhost:8080"
            ],
            "User-Agent": [
                "axios/1.7.2"
            ],
            "Accept-Encoding": [
                "gzip, compress, deflate, br"
            ],
            "Authorization": [
                "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjY3N0Q0NUFENjFBMjI0NjQwNDc1QzAxNDYzRkY3NEY3IiwidHlwIjoiYXQrand0In0.eyJpc3MiOiJodHRwOi8vaWRlbnRpdHlzZXJ2ZXI6NjAwMCIsIm5iZiI6MTcyMDY4ODcxOSwiaWF0IjoxNzIwNjg4NzE5LCJleHAiOjE3MjA2OTIzMTksImF1ZCI6Imh0dHA6Ly9pZGVudGl0eXNlcnZlcjo2MDAwL3Jlc291cmNlcyIsInNjb3BlIjpbIjAwMDAwMDA5OTAwMDAwMDA4MDAwMCJdLCJjbGllbnRfaWQiOiJjbGllbnQgbWV0IGdlbWVlbnRlY29kZSAoZWlnZW4gZ2VtZWVudGUpIiwiY2xhaW1zIjpbIk9JTj0wMDAwMDAwOTkwMDAwMDAwODAwMDAiLCJhZm5lbWVySUQ9MDAwMDA4IiwiZ2VtZWVudGVDb2RlPTA4MDAiXSwianRpIjoiOEVDNEZBRkJGMTVERDQzMDY3OEVFRDNERTI3QzI1ODUifQ.TAgJI6zg8jHbTFd3ncllN-DYqozg4G4S7xKit4mzg8NYMx5ljV3cX8KudVKeX4N2wFbGByVHTxnmYiZQ0L6l8Bd6mtZffyOHX9U4V4AApKsAOeNLqbSNj1pqxg93YWv8d9UlbjPl_EG-0tWRNvN24BIhk9Pp01WIrzeWKkxQP5-4qQwYus697_QnDAYXXttUPwtJZfMWfVL0pW9FcTo6aA45xYrPdEfQULXaOv4Iah18dVE71S4p6sGpzfB4IPcPjpomd7w3XWJrU3Pxy2mKPbMZCaeMrLSxkM_CsjeSdPUaZibF6FiY_MWqm7ebEo5XqcB6r27NxMDz0aY0qFrohA"
            ],
            "Content-Type": [
                "application/json"
            ],
            "Content-Length": [
                "112"
            ]
        },
        "request.body": {
            "type": "RaadpleegMetPeriode",
            "burgerservicenummer": "000000012",
            "datumVan": "2010-01-01",
            "datumTot": "2011-01-01"
        },
        "response.headers": {
            "Content-Type": [
                "application/json; charset=utf-8"
            ],
            "Date": [
                "Thu, 11 Jul 2024 09:05:20 GMT"
            ],
            "Server": [
                "Kestrel"
            ],
            "Content-Length": [
                "663"
            ]
        }
    }
}
```

### Voorbeeld log regel voor een request met ongeldig input data

```json
{
    "@timestamp": "2024-07-11T11:11:31.4110883+02:00",
    "log.level": "Warning",
    "message": "HTTP \"POST\" \"/haalcentraal/api/brphistorie/verblijfplaatshistorie\" responded 400 in 62.2947 ms",
    "ecs.version": "8.11.0",
    "log": {
        "logger": "Serilog.AspNetCore.RequestLoggingMiddleware"
    },
    "span.id": "b4001845f120368f",
    "trace.id": "acc16d1189be223e7ef382e4b4eb3305",
    "labels": {
        "MessageTemplate": "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms",
        "ConnectionId": "0HN51H2BFFNBQ"
    },
    "agent": {
        "type": "Elastic.CommonSchema.Serilog",
        "version": "8.11.1+69a082298d546f804e5610128818fbf9154b9958"
    },
    "event": {
        "created": "2024-07-11T11:11:31.4110883+02:00",
        "duration": 62294685,
        "severity": 3,
        "timezone": "Central European Standard Time"
    },
    "host": {
        "os": {
            "full": "Linux 5.15.90.1-microsoft-standard-WSL2 #1 SMP Fri Jan 27 02:56:13 UTC 2023",
            "platform": "Unix",
            "version": "5.15.90.1"
        },
        "architecture": "X64",
        "hostname": "fe1fbfd2ff7e"
    },
    "http": {
        "request.id": "0HN51H2BFFNBQ:00000002",
        "request.method": "POST",
        "response.mime_type": "application/problem+json",
        "response.status_code": 400
    },
    "process": {
        "name": "dotnet",
        "pid": 1,
        "thread.id": 20,
        "thread.name": ".NET ThreadPool Worker",
        "title": ""
    },
    "service": {
        "name": "Brp.AutorisatieEnProtocollering.Proxy",
        "type": "dotnet",
        "version": "1.2.0+202407021819"
    },
    "url": {
        "path": "/haalcentraal/api/brphistorie/verblijfplaatshistorie"
    },
    "user": {
        "domain": "fe1fbfd2ff7e",
        "name": "root"
    },
    "brp": {
        "claims": {
            "OIN": "000000099000000080000",
            "afnemerID": "000008",
            "gemeenteCode": "0800"
        },
        "request.headers": {
            "Connection": [
                "close"
            ],
            "Host": [
                "localhost:8080"
            ],
            "User-Agent": [
                "vscode-restclient"
            ],
            "Accept-Encoding": [
                "gzip, deflate"
            ],
            "Authorization": [
                "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjY3N0Q0NUFENjFBMjI0NjQwNDc1QzAxNDYzRkY3NEY3IiwidHlwIjoiYXQrand0In0.eyJpc3MiOiJodHRwOi8vaWRlbnRpdHlzZXJ2ZXI6NjAwMCIsIm5iZiI6MTcyMDY4OTA4OCwiaWF0IjoxNzIwNjg5MDg4LCJleHAiOjE3MjA2OTI2ODgsImF1ZCI6Imh0dHA6Ly9pZGVudGl0eXNlcnZlcjo2MDAwL3Jlc291cmNlcyIsInNjb3BlIjpbIjAwMDAwMDA5OTAwMDAwMDA4MDAwMCJdLCJjbGllbnRfaWQiOiJjbGllbnQgbWV0IGdlbWVlbnRlY29kZSAoZWlnZW4gZ2VtZWVudGUpIiwiY2xhaW1zIjpbIk9JTj0wMDAwMDAwOTkwMDAwMDAwODAwMDAiLCJhZm5lbWVySUQ9MDAwMDA4IiwiZ2VtZWVudGVDb2RlPTA4MDAiXSwianRpIjoiQjM3RDNDRTE3NkRFMjc0OTQ5MTdCMTQxODk1MUIwQzUifQ.qi6pxB03qNYJyuC5K_2ntAg8Ft9B1IfMzfmvn0tWAm-STVdjBEFmxfKLTaFRSqAvH87oxgWG3edpO0mgh09HPbatJi3zCOwDA8ipEq0JLry58Ck6YYZhRcHivQdE-mAJJSwBcBCkc2NbZz7oguxrBKKzqkCu283hnxF9D5akdwCMU01WxDGQHP4Vd9qvvKysU7A6atWIfSWt3InOAenakV85Dgmqfvnq9YetrwatXn3TVgPIxtJy_OnPQsPzXc2KivINAaPUd9RxifVX8-6ueVq8_STIxwkhH7qmNq4b4Vyk7oUlRqsaJ8xEe9GQDYhYD1lfLzvK-z6TuFTsaCRJew"
            ],
            "baggage": [
                "sentry-environment=release,sentry-release=1.8.2,sentry-public_key=01c918981c1d900a22d02793e241de70,sentry-trace_id=234dfd798c8ca1dad651e0f3608c2874"
            ],
            "Content-Type": [
                "application/json"
            ],
            "Content-Length": [
                "82"
            ],
            "sentry-trace": [
                "234dfd798c8ca1dad651e0f3608c2874-dd19796342bc6366"
            ]
        },
        "request.body": {
            "type": "RaadpleegMetPeildatum",
            "burgerservicenummer": "000000012"
        },
        "response.headers": {
            "Content-Type": [
                "application/problem+json"
            ]
        },
        "response.body": {
            "type": "https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1",
            "title": "Een of meerdere parameters zijn niet correct.",
            "status": 400,
            "detail": "De foutieve parameter(s) zijn: peildatum.",
            "instance": "/haalcentraal/api/brphistorie/verblijfplaatshistorie",
            "code": "paramsValidation",
            "invalidParams": [
                {
                    "name": "peildatum",
                    "code": "required",
                    "reason": "Parameter is verplicht."
                }
            ]
        }
    }
}
```

### Voorbeeld log regel voor een request dat tot een onverwachte fout leidt

```json
{
    "@timestamp": "2024-07-11T09:19:50.6031497+00:00",
    "log.level": "Error",
    "message": "HTTP \"POST\" \"/haalcentraal/api/brphistorie/verblijfplaatshistorie\" responded 500 in 0.6077 ms",
    "ecs.version": "8.11.0",
    "log": {
        "logger": "Serilog.AspNetCore.RequestLoggingMiddleware"
    },
    "span.id": "38c1923b93e53cd1",
    "trace.id": "38730d24f403191afcc96e37209b137e",
    "labels": {
        "MessageTemplate": "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms",
        "ConnectionId": "0HN51H9ULC4NM"
    },
    "agent": {
        "type": "Elastic.CommonSchema.Serilog",
        "version": "8.11.1+69a082298d546f804e5610128818fbf9154b9958"
    },
    "error": {
        "message": "",
        "stack_trace": "System.InvalidOperationException\n   at async Task Historie.Informatie.Service.Middlewares.OverwriteResponseBodyMiddleware.Invoke(HttpContext context) in /src/Historie.Informatie.Service/Middlewares/OverwriteResponseBodyMiddleware.cs:line 25\n   at async Task Brp.Shared.Infrastructure.Logging.RequestResponseLoggerMiddleware.Invoke(HttpContext context) in /src/Brp.Shared.Infrastructure/Logging/RequestResponseLoggerMiddleware.cs:line 45",
        "type": "System.InvalidOperationException"
    },
    "event": {
        "created": "2024-07-11T09:19:50.6031497+00:00",
        "duration": 607745,
        "severity": 4,
        "timezone": "Coordinated Universal Time"
    },
    "host": {
        "os": {
            "full": "Linux 5.15.90.1-microsoft-standard-WSL2 #1 SMP Fri Jan 27 02:56:13 UTC 2023",
            "platform": "Unix",
            "version": "5.15.90.1"
        },
        "architecture": "X64",
        "hostname": "baae6d7269ea"
    },
    "http": {
        "request.id": "0HN51H9ULC4NM:00000004",
        "request.method": "POST",
        "response.mime_type": "application/problem+json",
        "response.status_code": 500
    },
    "process": {
        "name": "dotnet",
        "pid": 1,
        "thread.id": 14,
        "thread.name": ".NET ThreadPool Worker",
        "title": ""
    },
    "service": {
        "name": "Historie.Informatie.Service",
        "type": "dotnet",
        "version": "2.0.0"
    },
    "url": {
        "path": "/haalcentraal/api/brphistorie/verblijfplaatshistorie"
    },
    "user": {
        "domain": "baae6d7269ea",
        "name": "root"
    },
    "metadata": {
        "ExceptionDetail": {
            "Type": "System.InvalidOperationException",
            "HResult": -2146233079,
            "Message": "",
            "Source": "Historie.Informatie.Service",
            "TargetSite": "Void MoveNext()"
        }
    },
    "brp": {
        "request.headers": {
            "Accept": [
                "application/json"
            ],
            "Connection": [
                "keep-alive"
            ],
            "Host": [
                "historie-informatie-service:5000"
            ],
            "User-Agent": [
                "axios/1.7.2"
            ],
            "Accept-Encoding": [
                "gzip, compress, deflate, br"
            ],
            "Authorization": [
                "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjY3N0Q0NUFENjFBMjI0NjQwNDc1QzAxNDYzRkY3NEY3IiwidHlwIjoiYXQrand0In0.eyJpc3MiOiJodHRwOi8vaWRlbnRpdHlzZXJ2ZXI6NjAwMCIsIm5iZiI6MTcyMDY4OTU5MCwiaWF0IjoxNzIwNjg5NTkwLCJleHAiOjE3MjA2OTMxOTAsImF1ZCI6Imh0dHA6Ly9pZGVudGl0eXNlcnZlcjo2MDAwL3Jlc291cmNlcyIsInNjb3BlIjpbIjAwMDAwMDA5OTAwMDAwMDA4MDAwMCJdLCJjbGllbnRfaWQiOiJjbGllbnQgbWV0IGdlbWVlbnRlY29kZSAoZWlnZW4gZ2VtZWVudGUpIiwiY2xhaW1zIjpbIk9JTj0wMDAwMDAwOTkwMDAwMDAwODAwMDAiLCJhZm5lbWVySUQ9MDAwMDA4IiwiZ2VtZWVudGVDb2RlPTA4MDAiXSwianRpIjoiQkI0REFFODgyRjcwOUVGMTU1NzQ5NDZGMDEwRDYwQ0UifQ.KuKxHpk3Mt1RKjRZhccCNLmI3lP6476DB7Vdc8JSyO3eOgfTXgbymUO8EzkRWgxNm9G8m6P7u9E5s8HzWRA5v6V1KPBh-DXgYuPsPuZRny7KEJh6Qtw1yIh8Q5iQ3rWRb4ZFTwWKy_IwqWWS8gB-medD1kqIWv720HjTd2ESJDA4CfRmsFMb9NFPgTi7EM6veADrlDQsEZEfAPpnd72b0Z-bEm0S8bQ7K3UQ_IOlAoocnsQWaYeq2OcFD3xZGqpb8zDKsyuSmmjGg0eKCXWTKXdT61fKliJp7EDlxoZb5kU8ATeq40aP8u3STz15UempOBeVKlE7EWzQk7QPHCk5_Q"
            ],
            "Content-Type": [
                "application/json"
            ],
            "traceparent": [
                "00-38730d24f403191afcc96e37209b137e-3e673e9852fefcdb-00"
            ],
            "Content-Length": [
                "112"
            ]
        },
        "request.body": {
            "type": "RaadpleegMetPeriode",
            "burgerservicenummer": "000000012",
            "datumVan": "2010-01-01",
            "datumTot": "2011-01-01"
        },
        "response.headers": {
            "Content-Type": [
                "application/problem+json"
            ]
        },
        "response.body": {
            "type": "https://datatracker.ietf.org/doc/html/rfc7231#section-6.6.1",
            "title": "Internal Server error.",
            "status": 500,
            "instance": "/haalcentraal/api/brphistorie/verblijfplaatshistorie"
        }
    }
}
```
