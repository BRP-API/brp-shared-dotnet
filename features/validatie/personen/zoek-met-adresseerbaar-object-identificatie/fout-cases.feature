#language: nl

@input-validatie
Functionaliteit: Zoek met adresseerbaar object identificatie - fout cases

Regel: adresseerbaarObjectIdentificatie is een verplichte parameter

  @fout-case
  Scenario: De adresseerbaarObjectIdentificatie parameter is niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam   | waarde                                  |
    | type   | ZoekMetAdresseerbaarObjectIdentificatie |
    | fields | burgerservicenummer                     |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                           |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1      |
    | title    | Een of meerdere parameters zijn niet correct.                    |
    | status   | 400                                                              |
    | detail   | De foutieve parameter(s) zijn: adresseerbaarObjectIdentificatie. |
    | code     | paramsValidation                                                 |
    | instance | /haalcentraal/api/brp/personen                                   |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name                             | reason                  |
    | required | adresseerbaarObjectIdentificatie | Parameter is verplicht. |

  @fout-case
  Scenario: Een lege string is opgegeven als adresseerbaar object identificatie waarde
    Als personen wordt gezocht met de volgende parameters
    | naam                             | waarde                                  |
    | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
    | adresseerbaarObjectIdentificatie |                                         |
    | fields                           | burgerservicenummer                     |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                           |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1      |
    | title    | Een of meerdere parameters zijn niet correct.                    |
    | status   | 400                                                              |
    | detail   | De foutieve parameter(s) zijn: adresseerbaarObjectIdentificatie. |
    | code     | paramsValidation                                                 |
    | instance | /haalcentraal/api/brp/personen                                   |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name                             | reason                  |
    | required | adresseerbaarObjectIdentificatie | Parameter is verplicht. |

Regel: Een adresseerbaarObjectIdentificatie is een string bestaande uit exact 16 cijfers

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                             | waarde                                  |
    | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
    | adresseerbaarObjectIdentificatie | <adresseerbaarObjectIdentificatie>      |
    | fields                           | burgerservicenummer                     |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                           |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1      |
    | title    | Een of meerdere parameters zijn niet correct.                    |
    | status   | 400                                                              |
    | detail   | De foutieve parameter(s) zijn: adresseerbaarObjectIdentificatie. |
    | code     | paramsValidation                                                 |
    | instance | /haalcentraal/api/brp/personen                                   |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name                             | reason                                                |
    | pattern | adresseerbaarObjectIdentificatie | Waarde voldoet niet aan patroon ^(?!0{16})[0-9]{16}$. |

    Voorbeelden:
    | adresseerbaarObjectIdentificatie  | titel                                                                                 |
    | 123456789012345                   | De opgegeven adresseerbaarObjectIdentificatie is een string met minder dan 16 cijfers |
    | 12345678901234567                 | De opgegeven adresseerbaarObjectIdentificatie is een string met meer dan 16 cijfers   |
    | <script>1234567890123456</script> | De opgegeven adresseerbaarObjectIdentificatie bevat niet-cijfer karakters             |

Regel: Een gemeenteVanInschrijving waarde bestaat uit 4 cijfers

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                             | waarde                                  |
    | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
    | adresseerbaarObjectIdentificatie | 0599010000219679                        |
    | fields                           | burgerservicenummer                     |
    | gemeenteVanInschrijving          | <gemeente code>                         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: gemeenteVanInschrijving.     |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name                    | reason                                      |
    | pattern | gemeenteVanInschrijving | Waarde voldoet niet aan patroon ^[0-9]{4}$. |

    Voorbeelden:
    | titel                                                                    | gemeente code                          |
    | De opgegeven gemeenteVanInschrijving waarde is minder dan 4 cijfers lang | 123                                    |
    | De opgegeven gemeenteVanInschrijving waarde is meer dan 4 cijfers lang   | 12345                                  |
    | De opgegeven gemeenteVanInschrijving waarde bevat ongeldige karakters    | <script>alert('hello world');</script> |

Regel: inclusiefOverledenPersonen is een boolean (true of false waarde)

  @fout-case
  Abstract Scenario: Een ongeldig waarde is opgegeven voor de 'inclusiefOverledenPersonen' parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                             | waarde                                  |
    | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
    | adresseerbaarObjectIdentificatie | 0599010000219679                        |
    | fields                           | burgerservicenummer                     |
    | inclusiefOverledenPersonen       | <inclusief overleden personen>          |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: inclusiefOverledenPersonen.  |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name                       | reason                  |
    | boolean | inclusiefOverledenPersonen | Waarde is geen boolean. |

    Voorbeelden:
    | inclusief overleden personen |
    |                              |
    | geen boolean                 |

Regel: Alleen gespecificeerde parameters bij het opgegeven zoektype mogen worden gebruikt

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                             | waarde                                  |
    | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
    | adresseerbaarObjectIdentificatie | 0599200051001501                        |
    | <parameter>                      | <waarde>                                |
    | fields                           | burgerservicenummer                     |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: <encoded parameter>.         |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code         | name                | reason                      |
    | unknownParam | <encoded parameter> | Parameter is niet verwacht. |

    Voorbeelden:
    | titel                                          | parameter                              | encoded parameter                                          | waarde     |
    | zoeken met parameter uit ander zoektype        | voornamen                              | voornamen                                                  | Pietje     |
    | typfout in naam optionele parameter            | gemeenteVanInschijving                 | gemeenteVanInschijving                                     | 0363       |
    | zoeken met niet gespecificeerde parameter      | bestaatNiet                            | bestaatNiet                                                | een waarde |
    | zoeken met parameter met javascript in de naam | <script>alert('hello world');</script> | &lt;script&gt;alert(&#39;hello world&#39;);&lt;/script&gt; | een waarde |
