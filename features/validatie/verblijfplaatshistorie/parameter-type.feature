#language: nl

Functionaliteit: test dat raadplegen verblijfplaatshistorie een correcte melding geeft bij een aanroep met onjuiste type parameter


  Rule: type is een verplichte parameter met mogelijke waarden RaadpleegMetPeildatum en RaadpleegMetPeriode

    @fout-case
    Scenario: zoek zonder opgeven van parameters
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam | waarde |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: type.                        |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name | reason                  |
      | required | type | Parameter is verplicht. |

    @fout-case
    Scenario: zoek zonder parameter type
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde     |
      | burgerservicenummer | 000000012  |
      | peildatum           | 2020-01-01 |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: type.                        |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name | reason                  |
      | required | type | Parameter is verplicht. |

    @fout-case
    Abstract Scenario: zoek met onjuiste waarde voor parameter type
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde     |
      | type                | <type>     |
      | burgerservicenummer | 000000012  |
      | peildatum           | 2020-01-01 |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: type.                        |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code  | name | reason                           |
      | value | type | Waarde is geen geldig zoek type. |

      Voorbeelden:
      | type                            |
      | onjuist                         |
      | RaadpleegMetBurgerservicenummer |
      |                                 |
      | raadpleegmetperiode             |
      | RaadpleegMetPeriodes            |
