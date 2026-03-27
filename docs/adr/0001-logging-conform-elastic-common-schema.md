# Logging van de BRP API microservices, geïmplementeerd in .NET zijn conform de Elastic Common Schema 

## Status

voorstel

## Context

Om makkelijk te kunnen monitoren of de microservices van de BRP API goed functioneren en goed blijven functioneren, is het noodzakelijk dat de BRP API microservices gegevens hiervoor vastlegt. Een best practice om dit te realiseren is om de benodigde gegevens te loggen als gestructureerde data in json formaat (structured logging).

De logs van de BRP APIs zullen worden verwerkt met behulp van producten uit de ELK-suite. Om de log gegevens makkelijker te kunnen verwerken en beter te kunnen analyseren, te visualiseren en te correleren is het noodzakelijk dat de logs van de BRP API microservices zich conformeren aan één formaat. De [Elastic Common Schema](https://www.elastic.co/guide/en/ecs/current/ecs-reference.html) is hiervoor ontwikkeld en wordt beschouwd als het standaard formaat voor het verwerken van logs met behulp van de ELK-suite.

## Beslissing

Om log regels gestructureerd conform het Elastic Common Schema te formatteren, moet elk BRP API microservice geïmplementeerd in .NET gebruik maken van de volgende libraries:

- [Serilog](https://serilog.net/), een .NET logging library met als hoofddoel gegevens gestructureerd te loggen.
- [Elastic Common Schema Serilog Text Formatter](https://github.com/elastic/ecs-dotnet/tree/main/src/Elastic.CommonSchema.Serilog), een .NET library van Elasticsearch waarmee Serilog wordt geïnstrueerd om log regels te formatteren conform de Elastic Common Schema specificatie.

Het gebruik van deze libraries maakt het mogelijk om met een beperkte hoeveelheid custom code (voornamelijk code om Serilog en de ECS Text Formatter te configureren) gestructureerd te kunnen loggen conform de Elastic Common Schema specificatie. Voorbeelden van log regels die zijn gegenereerd door Serilog volgens de Elastic Common Schema zijn te vinden in de [Voorbeeld log regels](#voorbeeld-log-regels) paragraaf. De log regels en de velden in een log regel zijn, met uitzondering van de request.body.content, response.body.content en brp velden, automatisch gegenereerd en gevuld door Serilog met de Elastic Common Schema Serilog Text Formatter. 

Met Serilog kunnen .NET objecten als JSON objecten worden toegevoegd aan een log regel (= destructuring) in plaats van geserialiseerd als tekst. Het grote voordeel hiervan is dat er naar log regels én in log regels kan worden gezocht op basis van de veld namen en waarden binnen zo'n destructured object in plaats van door de inhoud van de log regels te parsen.

### Afspraken

- Voor elke request/response wordt ten hoogste één log regel gegenereerd
- De volgende log levels worden gehanteerd voor een log regel:
  - verbose voor een health check response
  - information voor een 2xx response
  - warning voor een 4xx response
  - error voor een 5xx response
- Voor het loggen van een exception moet de DiagnosticContext.SetException methode worden gebruikt. Dit zorgt ervoor dat de exceptie wordt weggeschreven in de ECS [error velden](https://www.elastic.co/guide/en/ecs/8.11/ecs-error.html) van een log regel
- Er worden twee log stromen gebruikt:
  - secured. Log regels binnen deze stroom mogen privacy gevoelige informatie bevatten zodat issues die optreden in een specifieke situatie kunnen worden opgelost zonder de situatie opnieuw te moeten reproduceren 
  - unsecured. Log regels binnen deze stroom mogen geen privacy gevoelige informatie bevatten. De inhoud van privacy gevoelige velden moeten worden gemaskeerd

Om te voorkomen dat in elke BRP API microservice, geïmplementeerd in .NET, deze afspraken opnieuw wordt geïmplementeerd, zijn er helper classes geïmplementeerd die kunnen worden hergebruikt om conform de gemaakte afspraken loggen. Deze helper classes zijn te vinden zijn in de Logging map van het Brp.Shared.Infrastructure library project.

## Custom log regel velden

Custom log regel velden worden door de [Elastic Common Schema Serilog Text Formatter](https://github.com/elastic/ecs-dotnet/tree/main/src/Elastic.CommonSchema.Serilog) weggeschreven onder het **labels** veld (string) of onder het **metadata** veld (object).

In de volgende paragrafen wordt een overzicht gegeven van de labels en metadata velden.

### labels velden

| naam      | type      | omschrijving | gelogd door |
| --------- | --------- | ------------ | ----------- |
| log_type  | string    | waarde die aangeeft of velden met privacy gevoelige gegevens (PII) zijn gemaskeerd.<br>- secure. Velden met PII gegevens zijn niet gemaskeerd<br>- insecure. Velden met PII gegevens zijn gemaskeerd | alle services |

### metadata velden

| naam                             | type   | omschrijving | gelogd door |
| -------------------------------- | ------ | ------------ | ----------- |
| autorisatie                      | object | bevat de volgende velden:<br>- gemeente<br>- regel<br>- niet_geautoriseerd<br>- niet_geauthenticeerd<br>- exceptie<br>- claims | Autorisatie & Protocollering |
| autorisatie.gemeente             | string | bij gemeente als afnemer bevat dit veld de melding: afnemer: [afnemer code] is gemeente '[gemeente code]' | |
| autorisatie.regel                | object | autorisatie gegevens die zijn gebruikt om de afnemer te autoriseren | |
| autorisatie.niet_geautoriseerd   | string | de reden waarom de afnemer niet is geautoriseerd | |
| autorisatie.niet_geauthentiseerd | string | de melding 'Forbidden for unknown reason' als de afnemer om onbekende reden niet kan worden geauthenticeerd | |
| autorisatie.exceptie             | object | het exceptie object dat wordt gegooid als de afnemer niet kan worden geauthentiseerd | |
| autorisatie.claims               | lijst  | de claims die met de request zijn meegestuurd | |
| protocollering                   | lijst  | de pl_id van de personen van wie gegevens zijn geleverd in de response | Autorisatie & Protocollering |
| request.body                     | object | de input parameters die meegestuurd met de request | alle services |
| request.headers                  | lijst  | de headers die zijn meegestuurd met de request | alle services |
| response.body                    | object | het problem details object dat wordt meegestuurd in de response wanneer de request niet kan worden afgehandeld | alle services |
| response.headers                 | lijst  | de headers die zijn meegestuurd met de response | alle services |

## Voorbeeld log regels

Deze paragraaf bevat voorbeeld log regels van de Autorisatie en Protocollering microservice, gegenereerd door Serilog en de Elastic Common Schema Serilog Text Formatter, voor de volgende gebeurtenissen:

- een succesvol afgehandeld request
- een request met ongeldig input data
- een request dat tot een onverwachte fout leidt

### Voorbeeld log regel voor een succesvol afgehandeld request

```json
{
    "@timestamp": "2024-08-30T08:34:07.8497851+02:00",
    "log.level": "Information",
    "message": "HTTP \"POST\" \"/haalcentraal/api/brphistorie/verblijfplaatshistorie\" responded 200 in 305.0777 ms",
    "ecs.version": "8.11.0",
    "log": {
        "logger": "Serilog.AspNetCore.RequestLoggingMiddleware"
    },
    "span.id": "0af571898810c02b",
    "trace.id": "dd3588bfa059a31b6b2ea5168e7b91cf",
    "labels": {
        "MessageTemplate": "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms",
        "ConnectionId": "0HN68NKKO70BO"
    },
    "agent": {
        "type": "Elastic.CommonSchema.Serilog",
        "version": "8.11.1+69a082298d546f804e5610128818fbf9154b9958"
    },
    "event": {
        "created": "2024-08-30T08:34:07.8497851+02:00",
        "duration": 305077726,
        "severity": 2,
        "timezone": "Central European Standard Time"
    },
    "host": {
        "os": {
            "full": "Linux 5.15.153.1-microsoft-standard-WSL2 #1 SMP Fri Mar 29 23:14:13 UTC 2024",
            "platform": "Unix",
            "version": "5.15.153.1"
        },
        "architecture": "X64",
        "hostname": "8322b0e2ea7e"
    },
    "http": {
        "request.id": "0HN68NKKO70BO:00000002",
        "request.method": "POST",
        "request.mime_type": "application/json",
        "response.mime_type": "application/json; charset=utf-8",
        "response.status_code": 200
    },
    "process": {
        "name": "dotnet",
        "pid": 1,
        "thread.id": 34,
        "thread.name": ".NET ThreadPool Worker",
        "title": ""
    },
    "service": {
        "name": "Brp.AutorisatieEnProtocollering.Proxy",
        "type": "dotnet",
        "version": "1.2.0"
    },
    "url": {
        "path": "/haalcentraal/api/brphistorie/verblijfplaatshistorie"
    },
    "user": {
        "domain": "8322b0e2ea7e",
        "name": "root"
    },
    "metadata": {
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
                "axios/1.7.3"
            ],
            "Accept-Encoding": [
                "gzip, compress, deflate, br"
            ],
            "Authorization": "***MASKED***",
            "Content-Type": [
                "application/json"
            ],
            "Content-Length": [
                "112"
            ]
        },
        "request.body": {
            "type": "RaadpleegMetPeriode",
            "burgerservicenummer": "***MASKED***",
            "datumVan": "2023-01-01",
            "datumTot": "2024-01-01"
        },
        "autorisatie": {
            "Regel": {
                "AutorisatieId": 1,
                "AfnemerCode": 8,
                "AdHocMedium": "N",
                "TabelRegelStartDatum": 20201128,
                "RubrieknummerAdHoc": "PXVP07"
            },
            "Claims": {
                "OIN": "000000099000000080000",
                "afnemerID": "000008"
            }
        },
        "response.headers": {
            "Content-Type": [
                "application/json; charset=utf-8"
            ],
            "Date": [
                "Fri, 30 Aug 2024 06:34:07 GMT"
            ],
            "Server": [
                "Kestrel"
            ],
            "Content-Length": [
                "23"
            ]
        }
    }
}
```

### Voorbeeld log regel voor een request met ongeldig input data

```json
{
    "@timestamp": "2024-08-30T08:29:55.5406805+02:00",
    "log.level": "Warning",
    "message": "HTTP \"POST\" \"/haalcentraal/api/brphistorie/verblijfplaatshistorie\" responded 400 in 356.5468 ms",
    "ecs.version": "8.11.0",
    "log": {
        "logger": "Serilog.AspNetCore.RequestLoggingMiddleware"
    },
    "span.id": "e04066537af10744",
    "trace.id": "c08c19ab182a89481ee4fb8436bd53e2",
    "labels": {
        "MessageTemplate": "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms",
        "ConnectionId": "0HN68NKKO70BM"
    },
    "agent": {
        "type": "Elastic.CommonSchema.Serilog",
        "version": "8.11.1+69a082298d546f804e5610128818fbf9154b9958"
    },
    "event": {
        "created": "2024-08-30T08:29:55.5406805+02:00",
        "duration": 356546811,
        "severity": 3,
        "timezone": "Central European Standard Time"
    },
    "host": {
        "os": {
            "full": "Linux 5.15.153.1-microsoft-standard-WSL2 #1 SMP Fri Mar 29 23:14:13 UTC 2024",
            "platform": "Unix",
            "version": "5.15.153.1"
        },
        "architecture": "X64",
        "hostname": "8322b0e2ea7e"
    },
    "http": {
        "request.id": "0HN68NKKO70BM:00000002",
        "request.method": "POST",
        "request.mime_type": "application/json",
        "response.mime_type": "application/problem+json",
        "response.status_code": 400
    },
    "process": {
        "name": "dotnet",
        "pid": 1,
        "thread.id": 13,
        "thread.name": ".NET ThreadPool Worker",
        "title": ""
    },
    "service": {
        "name": "Brp.AutorisatieEnProtocollering.Proxy",
        "type": "dotnet",
        "version": "1.2.0"
    },
    "url": {
        "path": "/haalcentraal/api/brphistorie/verblijfplaatshistorie"
    },
    "user": {
        "domain": "8322b0e2ea7e",
        "name": "root"
    },
    "metadata": {
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
                "axios/1.7.3"
            ],
            "Accept-Encoding": [
                "gzip, compress, deflate, br"
            ],
            "Authorization": "***MASKED***",
            "Content-Type": [
                "application/json"
            ],
            "Content-Length": [
                "90"
            ]
        },
        "request.body": {
            "type": "RaadpleegMetPeildatum",
            "burgerservicenummer": "***MASKED***",
            "peildatum": "2020-01-01"
        },
        "autorisatie": {
            "Claims": {
                "OIN": "000000099000000080000",
                "afnemerID": "000008",
                "gemeenteCode": "0800"
            }
        },
        "response.headers": {
            "Content-Type": [
                "application/problem+json"
            ],
            "Date": [
                "Fri, 30 Aug 2024 06:29:55 GMT"
            ],
            "Server": [
                "Kestrel"
            ],
            "Content-Length": [
                "415"
            ]
        },
        "response.body": {
            "type": "https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1",
            "title": "Een of meerdere parameters zijn niet correct.",
            "status": 400,
            "detail": "De foutieve parameter(s) zijn: burgerservicenummer.",
            "instance": "/haalcentraal/api/brphistorie/verblijfplaatshistorie",
            "code": "paramsValidation",
            "invalidParams": [
                {
                    "name": "burgerservicenummer",
                    "code": "pattern",
                    "reason": "Waarde voldoet niet aan patroon ^[0-9]{9}$."
                }
            ]
        }
    }
}
```

### Voorbeeld logregel voor een niet-geautoriseerd request

```
{
    "@timestamp": "2024-08-30T08:33:05.4182647+02:00",
    "log.level": "Warning",
    "message": "HTTP \"POST\" \"/haalcentraal/api/brphistorie/verblijfplaatshistorie\" responded 403 in 888.5858 ms",
    "ecs.version": "8.11.0",
    "log": {
        "logger": "Serilog.AspNetCore.RequestLoggingMiddleware"
    },
    "span.id": "e44fd85f0b5eafeb",
    "trace.id": "bf5d5a5adf9a97e2dd7117788c19ece6",
    "labels": {
        "MessageTemplate": "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms",
        "ConnectionId": "0HN68NKKO70BN"
    },
    "agent": {
        "type": "Elastic.CommonSchema.Serilog",
        "version": "8.11.1+69a082298d546f804e5610128818fbf9154b9958"
    },
    "event": {
        "created": "2024-08-30T08:33:05.4182647+02:00",
        "duration": 888585819,
        "severity": 3,
        "timezone": "Central European Standard Time"
    },
    "host": {
        "os": {
            "full": "Linux 5.15.153.1-microsoft-standard-WSL2 #1 SMP Fri Mar 29 23:14:13 UTC 2024",
            "platform": "Unix",
            "version": "5.15.153.1"
        },
        "architecture": "X64",
        "hostname": "8322b0e2ea7e"
    },
    "http": {
        "request.id": "0HN68NKKO70BN:00000002",
        "request.method": "POST",
        "request.mime_type": "application/json",
        "response.mime_type": "application/problem+json",
        "response.status_code": 403
    },
    "process": {
        "name": "dotnet",
        "pid": 1,
        "thread.id": 27,
        "thread.name": ".NET ThreadPool Worker",
        "title": ""
    },
    "service": {
        "name": "Brp.AutorisatieEnProtocollering.Proxy",
        "type": "dotnet",
        "version": "1.2.0"
    },
    "url": {
        "path": "/haalcentraal/api/brphistorie/verblijfplaatshistorie"
    },
    "user": {
        "domain": "8322b0e2ea7e",
        "name": "root"
    },
    "metadata": {
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
                "axios/1.7.3"
            ],
            "Accept-Encoding": [
                "gzip, compress, deflate, br"
            ],
            "Authorization": "***MASKED***",
            "Content-Type": [
                "application/json"
            ],
            "Content-Length": [
                "112"
            ]
        },
        "request.body": {
            "type": "RaadpleegMetPeriode",
            "burgerservicenummer": "***MASKED***",
            "datumVan": "2023-01-01",
            "datumTot": "2024-01-01"
        },
        "autorisatie": {
            "Regel": {
                "AutorisatieId": 1,
                "AfnemerCode": 8,
                "AdHocMedium": "N",
                "TabelRegelStartDatum": 20201128,
                "RubrieknummerAdHoc": "10120 80910 81010 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81330 81340 81350 580910 581010 581110 581115 581120 581130 581140 581150 581160 581170 581180 581190 581210 581310 581330 581340 581350 PAVP01 PAVP02 PAVP03 PAVP04"
            },
            "NietGeautoriseerd": "afnemer '8' is niet geautoriseerd voor verblijfplaatshistorie",
            "Claims": {
                "OIN": "000000099000000080000",
                "afnemerID": "000008"
            }
        },
        "response.headers": {
            "Content-Type": [
                "application/problem+json"
            ],
            "Date": [
                "Fri, 30 Aug 2024 06:33:05 GMT"
            ],
            "Server": [
                "Kestrel"
            ],
            "Content-Length": [
                "297"
            ]
        },
        "response.body": {
            "type": "https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3",
            "title": "U bent niet geautoriseerd voor het gebruik van deze API.",
            "status": 403,
            "detail": "Niet geautoriseerd voor verblijfplaatshistorie.",
            "instance": "/haalcentraal/api/brphistorie/verblijfplaatshistorie",
            "code": "unauthorized"
        }
    }
}
```

### Voorbeeld logregel voor de gezag api

```
{
    "@timestamp": "2025-01-06T16:04:45.530961543Z",
    "ecs.version": "8.11",
    "message": "HTTP POST /api/v1/opvragenBevoegdheidTotGezag responded 200 in 399 ms",
    "log.logger": "nl.rijksoverheid.mev.logging.LoggingFilter",
    "process.thread.name": "http-nio-8080-exec-3",
    "log.level": "INFO",
    "host.architecture": "amd64",
    "service.type": "brp-api",
    "host.os.type": "Linux",
    "service.name": "brp-api-gezag",
    "service.version": "1.7.0-20241220123107",
    "host.os.kernel": "6.10.4-linuxkit",
    "process.pid": "1",
    "event.dataset": "brp-api-gezag",
    "event.timezone": "GMT",
    "event.duration": "399441958",
	  "metadata": {
  		"request.body": {
  			"burgerservicenummer": [
  				"999970124"
  			]
  		},
  		"request.headers": {
  			"content-length": "44",
  			"postman-token": "9ae18a93-e3e7-4c7b-9f9a-bbdf22fec9cc",
  			"host": "localhost:5003",
  			"content-type": "application/json",
  			"connection": "keep-alive",
  			"accept-encoding": "gzip, deflate, br",
  			"user-agent": "PostmanRuntime/7.43.0",
  			"accept": "*/*"
  		},
  		"gezag_resultaten": [
  			{
  				"plId": 1645,
  				"type": "GezagNietVanToepassing*",
  				"toelichting": "Ingezeten - meerderjarig - soort gezag is NVT - gezag is niet van toepassing",
  				"route": "2m"
  			}
  		],
  		"pl_ids": [
  			1645,
  			1645,
  			1646,
  			1648,
  			1667,
  			1645,
  			1668,
  			1649,
  			1645,
  			1647,
  			1645,
  			1646
  		],
  		"response.headers": {
  			"Keep-Alive": "timeout=60",
  			"Connection": "keep-alive",
  			"Content-Length": "529",
  			"Date": "Mon, 06 Jan 2025 16:04:45 GMT",
  			"Content-Type": "application/json"
  		}
  	},
    "url.path": "/api/v1/opvragenBevoegdheidTotGezag",
    "event.category": "api",
    "event.end": "2025-01-06T16:04:45.528811876Z",
    "request.method": "POST",
    "response.mime_type": "application/json",
    "event.start": "2025-01-06T16:04:45.129369918Z",
    "event.kind": "event",
    "request.mime_type": "application/json",
    "response.status_code": "200",
    "labels.log_type": "secure"
}
```

### Voorbeeld logregel bij een request waar een onverwachte fout is opgetreden

- informatie over de exceptie wordt weggeschreven in het error veld
- Authorization header is gemaskeerd
- metadata veld bevat naam/waarde paren waarvan de naam niet overeenkomt met in het ECS gedefinieerde velden
- ECS velden http.request.body.content en http.response.body.content zijn niet gevuld

#### Geanonimiseerd variant

```json
{
    "@timestamp": "2024-08-30T08:06:47.8039263+02:00",
    "log.level": "Error",
    "message": "HTTP \"POST\" \"/haalcentraal/api/brphistorie/verblijfplaatshistorie\" responded 500 in 130.1929 ms",
    "ecs.version": "8.11.0",
    "log": {
        "logger": "Serilog.AspNetCore.RequestLoggingMiddleware"
    },
    "span.id": "1cb2c88a24a65daa",
    "trace.id": "9c062a7b87a668f26eca4ac8bf41b5bd",
    "labels": {
        "MessageTemplate": "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms",
        "ConnectionId": "0HN68N7N6VD3G"
    },
    "agent": {
        "type": "Elastic.CommonSchema.Serilog",
        "version": "8.11.1+69a082298d546f804e5610128818fbf9154b9958"
    },
    "error": {
        "message": "Specified method is not supported.",
        "stack_trace": "System.NotSupportedException: Specified method is not supported.\r\n   at async Task Brp.AutorisatieEnProtocollering.Proxy.Validatie.RequestValidatieMiddleware.Invoke(HttpContext httpContext) in C:/Projects/brp-api/brp-shared-dotnet/src/Brp.AutorisatieEnProtocollering.Proxy/Validatie/RequestValidatieMiddleware.cs:line 24\r\n   at async Task Microsoft.AspNetCore.Authorization.AuthorizationMiddleware.Invoke(HttpContext context)\r\n   at async Task Microsoft.AspNetCore.Authentication.AuthenticationMiddleware.Invoke(HttpContext context)\r\n   at async Task Brp.Shared.Infrastructure.Logging.RequestResponseLoggerMiddleware.Invoke(HttpContext context) in C:/Projects/brp-api/brp-shared-dotnet/src/Brp.Shared.Infrastructure/Logging/RequestResponseLoggerMiddleware.cs:line 45",
        "type": "System.NotSupportedException"
    },
    "event": {
        "created": "2024-08-30T08:06:47.8039263+02:00",
        "duration": 130192900,
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
        "request.id": "0HN68N7N6VD3G:00000002",
        "request.method": "POST",
        "request.mime_type": "application/json",
        "response.mime_type": "application/problem+json",
        "response.status_code": 500
    },
    "process": {
        "name": "Brp.AutorisatieEnProtocollering.Proxy",
        "pid": 11396,
        "thread.id": 12,
        "thread.name": ".NET ThreadPool Worker",
        "title": ""
    },
    "service": {
        "name": "Brp.AutorisatieEnProtocollering.Proxy",
        "type": "dotnet",
        "version": "1.2.0+c5323eeb1b00b5653d5300f47ca09c0b61e1ea89"
    },
    "url": {
        "path": "/haalcentraal/api/brphistorie/verblijfplaatshistorie"
    },
    "user": {
        "domain": "NUC11TNK",
        "name": "Melvin"
    },
    "metadata": {
        "request.headers": {
            "Accept": [
                "application/json"
            ],
            "Connection": [
                "keep-alive"
            ],
            "Host": [
                "localhost:5005"
            ],
            "User-Agent": [
                "axios/1.7.3"
            ],
            "Accept-Encoding": [
                "gzip, compress, deflate, br"
            ],
            "Authorization": "***MASKED***",
            "Content-Type": [
                "application/json"
            ],
            "Content-Length": [
                "57"
            ]
        },
        "request.body": {
            "type": "RaadpleegMetPeildatum",
            "peildatum": "2020-01-01"
        },
        "response.headers": {
            "Content-Type": [
                "application/problem+json"
            ],
            "Date": [
                "Fri, 30 Aug 2024 06:06:47 GMT"
            ],
            "Server": [
                "Kestrel"
            ],
            "Content-Length": [
                "182"
            ]
        },
        "response.body": {
            "type": "https://datatracker.ietf.org/doc/html/rfc7231#section-6.6.1",
            "title": "Internal Server error.",
            "status": 500,
            "instance": "/haalcentraal/api/brphistorie/verblijfplaatshistorie"
        },
        "ExceptionDetail": {
            "Type": "System.NotSupportedException",
            "HResult": -2146233067,
            "Message": "Specified method is not supported.",
            "Source": "Brp.AutorisatieEnProtocollering.Proxy",
            "TargetSite": "Void MoveNext()"
        }
    }
}
```

#### Niet geanonimiseerd variant

- informatie over de exceptie wordt weggeschreven in het error veld
- Authorization header is niet gemaskeerd
- metadata veld bevat naam/waarde paren waarvan de naam niet overeenkomt met in het ECS gedefinieerde velden
- ECS velden http.request.body.content en http.response.body.content zijn gevuld

```
{
    "@timestamp": "2024-08-30T08:06:47.8039263+02:00",
    "log.level": "Error",
    "message": "HTTP \"POST\" \"/haalcentraal/api/brphistorie/verblijfplaatshistorie\" responded 500 in 130.1929 ms",
    "ecs.version": "8.11.0",
    "log": {
        "logger": "Serilog.AspNetCore.RequestLoggingMiddleware"
    },
    "span.id": "1cb2c88a24a65daa",
    "trace.id": "9c062a7b87a668f26eca4ac8bf41b5bd",
    "labels": {
        "MessageTemplate": "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms",
        "ConnectionId": "0HN68N7N6VD3G"
    },
    "agent": {
        "type": "Elastic.CommonSchema.Serilog",
        "version": "8.11.1+69a082298d546f804e5610128818fbf9154b9958"
    },
    "error": {
        "message": "Specified method is not supported.",
        "stack_trace": "System.NotSupportedException: Specified method is not supported.\r\n   at async Task Brp.AutorisatieEnProtocollering.Proxy.Validatie.RequestValidatieMiddleware.Invoke(HttpContext httpContext) in C:/Projects/brp-api/brp-shared-dotnet/src/Brp.AutorisatieEnProtocollering.Proxy/Validatie/RequestValidatieMiddleware.cs:line 24\r\n   at async Task Microsoft.AspNetCore.Authorization.AuthorizationMiddleware.Invoke(HttpContext context)\r\n   at async Task Microsoft.AspNetCore.Authentication.AuthenticationMiddleware.Invoke(HttpContext context)\r\n   at async Task Brp.Shared.Infrastructure.Logging.RequestResponseLoggerMiddleware.Invoke(HttpContext context) in C:/Projects/brp-api/brp-shared-dotnet/src/Brp.Shared.Infrastructure/Logging/RequestResponseLoggerMiddleware.cs:line 45",
        "type": "System.NotSupportedException"
    },
    "event": {
        "created": "2024-08-30T08:06:47.8039263+02:00",
        "duration": 130192900,
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
        "request.body.content": "{\"type\":\"RaadpleegMetPeildatum\",\"peildatum\":\"2020-01-01\"}",
        "request.id": "0HN68N7N6VD3G:00000002",
        "request.method": "POST",
        "request.mime_type": "application/json",
        "response.body.content": "{\"type\":\"https://datatracker.ietf.org/doc/html/rfc7231#section-6.6.1\",\"title\":\"Internal Server error.\",\"status\":500,\"instance\":\"/haalcentraal/api/brphistorie/verblijfplaatshistorie\"}",
        "response.mime_type": "application/problem+json",
        "response.status_code": 500
    },
    "process": {
        "name": "Brp.AutorisatieEnProtocollering.Proxy",
        "pid": 11396,
        "thread.id": 12,
        "thread.name": ".NET ThreadPool Worker",
        "title": ""
    },
    "service": {
        "name": "Brp.AutorisatieEnProtocollering.Proxy",
        "type": "dotnet",
        "version": "1.2.0+c5323eeb1b00b5653d5300f47ca09c0b61e1ea89"
    },
    "url": {
        "path": "/haalcentraal/api/brphistorie/verblijfplaatshistorie"
    },
    "user": {
        "domain": "NUC11TNK",
        "name": "Melvin"
    },
    "metadata": {
        "request.headers": {
            "Accept": [
                "application/json"
            ],
            "Connection": [
                "keep-alive"
            ],
            "Host": [
                "localhost:5005"
            ],
            "User-Agent": [
                "axios/1.7.3"
            ],
            "Accept-Encoding": [
                "gzip, compress, deflate, br"
            ],
            "Authorization": [
                "Basic MDAwMDA4fDA4MDA6dGVtcHNvbHV0aW9uIQ=="
            ],
            "Content-Type": [
                "application/json"
            ],
            "Content-Length": [
                "57"
            ]
        },
        "request.body": {
            "type": "RaadpleegMetPeildatum",
            "peildatum": "2020-01-01"
        },
        "response.headers": {
            "Content-Type": [
                "application/problem+json"
            ],
            "Date": [
                "Fri, 30 Aug 2024 06:06:47 GMT"
            ],
            "Server": [
                "Kestrel"
            ],
            "Content-Length": [
                "182"
            ]
        },
        "response.body": {
            "type": "https://datatracker.ietf.org/doc/html/rfc7231#section-6.6.1",
            "title": "Internal Server error.",
            "status": 500,
            "instance": "/haalcentraal/api/brphistorie/verblijfplaatshistorie"
        },
        "ExceptionDetail": {
            "Type": "System.NotSupportedException",
            "HResult": -2146233067,
            "Message": "Specified method is not supported.",
            "Source": "Brp.AutorisatieEnProtocollering.Proxy",
            "TargetSite": "Void MoveNext()"
        }
    }
}
```
