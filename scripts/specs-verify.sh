#!/bin/bash

PARAMS="{ \
    \"apiUrl\": \"http://localhost:8080/haalcentraal/api\", \
    \"logFileToAssert\": \"./test-data/logs/brp-autorisatie-protocollering.json\", \
    \"oAuth\": { \
        \"enable\": true \
    } \
}"

echo "### Cucumber Test Reports"

echo "#### Step definitions validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie-summary.txt \
                -f summary \
                features/docs \
                -p UnitTest \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-integratie.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-integratie-summary.txt \
                -f summary \
                features/docs \
                -p Integratie \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-informatie-api.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-informatie-api-summary.txt \
                -f summary \
                features/docs \
                -p InfoApi \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-data-api.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-data-api-summary.txt \
                -f summary \
                features/docs \
                -p DataApi \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-gezag-api.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-gezag-api-summary.txt \
                -f summary \
                features/docs \
                -p GezagApi \
                > /dev/null

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-gezag-api-deprecated.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-gezag-api-deprecated-summary.txt \
                -f summary \
                features/docs \
                -p GezagApiDeprecated \
                > /dev/null

# personen endpoint

echo "#### personen input validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/personen/input-validatie/test-result.json \
                -f summary:./test-reports/cucumber-js/personen/input-validatie/test-result-summary.txt \
                -f summary \
                features/validatie/personen \
                --world-parameters "$PARAMS" \
                > /dev/null

echo "#### personen autorisatie validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/personen/autorisatie/test-result.json \
                -f summary:./test-reports/cucumber-js/personen/autorisatie/test-result-summary.txt \
                -f summary \
                features/autorisatie/personen \
                --world-parameters "$PARAMS" \
                > /dev/null

echo "#### personen protocollering validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/personen/protocollering/test-result.json \
                -f summary:./test-reports/cucumber-js/personen/protocollering/test-result-summary.txt \
                -f summary \
                features/protocollering/personen \
                --world-parameters "$PARAMS" \
                > /dev/null

# reisdocumenten endpoint

echo "#### reisdocumenten input validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/reisdocumenten/input-validatie/test-result.json \
                -f summary:./test-reports/cucumber-js/reisdocumenten/input-validatie/test-result-summary.txt \
                -f summary \
                features/validatie/reisdocumenten \
                --world-parameters "$PARAMS" \
                > /dev/null

echo "#### reisdocumenten autorisatie validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/reisdocumenten/autorisatie/test-result.json \
                -f summary:./test-reports/cucumber-js/reisdocumenten/autorisatie/test-result-summary.txt \
                -f summary \
                features/autorisatie/reisdocumenten \
                --world-parameters "$PARAMS" \
                > /dev/null

echo "#### reisdocumenten protocollering validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/reisdocumenten/protocollering/test-result.json \
                -f summary:./test-reports/cucumber-js/reisdocumenten/protocollering/test-result-summary.txt \
                -f summary \
                features/protocollering/reisdocumenten \
                --world-parameters "$PARAMS" \
                > /dev/null

# verblijfplaatshistorie endpoint

echo "#### verblijfplaatshistorie input validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/verblijfplaatshistorie/input-validatie/test-result.json \
                -f summary:./test-reports/cucumber-js/verblijfplaatshistorie/input-validatie/test-result-summary.txt \
                -f summary \
                features/validatie/verblijfplaatshistorie \
                --world-parameters "$PARAMS" \
                > /dev/null

echo "#### verblijfplaatshistorie autorisatie validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/verblijfplaatshistorie/autorisatie/test-result.json \
                -f summary:./test-reports/cucumber-js/verblijfplaatshistorie/autorisatie/test-result-summary.txt \
                -f summary \
                features/autorisatie/verblijfplaatshistorie \
                --world-parameters "$PARAMS" \
                > /dev/null

echo "#### verblijfplaatshistorie protocollering validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/verblijfplaatshistorie/protocollering/test-result.json \
                -f summary:./test-reports/cucumber-js/verblijfplaatshistorie/protocollering/test-result-summary.txt \
                -f summary \
                features/protocollering/verblijfplaatshistorie \
                --world-parameters "$PARAMS" \
                > /dev/null

# bewoningen endpoint

echo "#### bewoningen input validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/bewoningen/input-validatie/test-result.json \
                -f summary:./test-reports/cucumber-js/bewoningen/input-validatie/test-result-summary.txt \
                -f summary \
                features/validatie/bewoningen \
                --world-parameters "$PARAMS" \
                > /dev/null

echo "#### bewoningen autorisatie validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/bewoningen/autorisatie/test-result.json \
                -f summary:./test-reports/cucumber-js/bewoningen/autorisatie/test-result-summary.txt \
                -f summary \
                features/autorisatie/bewoning \
                --world-parameters "$PARAMS" \
                > /dev/null

echo "#### bewoningen protocollering validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/bewoningen/protocollering/test-result.json \
                -f summary:./test-reports/cucumber-js/bewoningen/protocollering/test-result-summary.txt \
                -f summary \
                features/protocollering/bewoning \
                --world-parameters "$PARAMS" \
                > /dev/null
