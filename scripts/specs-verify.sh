#!/bin/bash

echo "### Cucumber Test Reports"

EXIT_CODE=0

echo "#### Step definitions validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie-summary.txt \
                -f summary \
                features/docs \
                -p UnitTest \
                > /dev/null
if [[ $? -ne 0 ]]; then EXIT_CODE=1; fi

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-integratie.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-integratie-summary.txt \
                -f summary \
                features/docs \
                -p Integratie \
                > /dev/null
if [[ $? -ne 0 ]]; then EXIT_CODE=1; fi

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-informatie-api.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-informatie-api-summary.txt \
                -f summary \
                features/docs \
                -p InfoApi \
                > /dev/null
if [[ $? -ne 0 ]]; then EXIT_CODE=1; fi

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-data-api.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-data-api-summary.txt \
                -f summary \
                features/docs \
                -p DataApi \
                > /dev/null
if [[ $? -ne 0 ]]; then EXIT_CODE=1; fi

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-gezag-api.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-gezag-api-summary.txt \
                -f summary \
                features/docs \
                -p GezagApi \
                > /dev/null
if [[ $? -ne 0 ]]; then EXIT_CODE=1; fi

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-gezag-api-deprecated.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-gezag-api-deprecated-summary.txt \
                -f summary \
                features/docs \
                -p GezagApiDeprecated \
                > /dev/null
if [[ $? -ne 0 ]]; then EXIT_CODE=1; fi

# personen endpoint

echo "#### personen input validatie, autorisatie en protocollering"

npx cucumber-js -f json:./test-reports/cucumber-js/personen/test-result.json \
                -f summary:./test-reports/cucumber-js/personen/test-result-summary.txt \
                -f summary \
                features/validatie/personen \
                features/autorisatie/personen \
                features/protocollering/personen \
                features/accept-gezag-version-header.feature \
                -p AenP \
                > /dev/null
if [[ $? -ne 0 ]]; then EXIT_CODE=1; fi

# reisdocumenten endpoint

echo "#### reisdocumenten input validatie, autorisatie en protocollering"

npx cucumber-js -f json:./test-reports/cucumber-js/reisdocumenten/test-result.json \
                -f summary:./test-reports/cucumber-js/reisdocumenten/test-result-summary.txt \
                -f summary \
                features/validatie/reisdocumenten \
                features/autorisatie/reisdocumenten \
                features/protocollering/reisdocumenten \
                -p AenP \
                > /dev/null
if [[ $? -ne 0 ]]; then EXIT_CODE=1; fi

# verblijfplaatshistorie endpoint

echo "#### verblijfplaatshistorie input validatie, autorisatie en protocollering"

npx cucumber-js -f json:./test-reports/cucumber-js/verblijfplaatshistorie/test-result.json \
                -f summary:./test-reports/cucumber-js/verblijfplaatshistorie/test-result-summary.txt \
                -f summary \
                features/validatie/verblijfplaatshistorie \
                features/autorisatie/verblijfplaatshistorie \
                features/protocollering/verblijfplaatshistorie \
                -p AenP \
                > /dev/null
if [[ $? -ne 0 ]]; then EXIT_CODE=1; fi

# bewoningen endpoint

echo "#### bewoningen input validatie, autorisatie en protocollering"

npx cucumber-js -f json:./test-reports/cucumber-js/bewoningen/test-result.json \
                -f summary:./test-reports/cucumber-js/bewoningen/test-result-summary.txt \
                -f summary \
                features/validatie/bewoningen \
                features/autorisatie/bewoning \
                features/protocollering/bewoning \
                -p AenP \
                > /dev/null
if [[ $? -ne 0 ]]; then EXIT_CODE=1; fi

# Exit with error code if any command failed
exit $EXIT_CODE
