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
                --tags "not @integratie" \
                --tags "not @skip-verify" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt

# personen endpoint

echo "#### personen input validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/personen/input-validatie/test-result.json \
                -f summary:./test-reports/cucumber-js/personen/input-validatie/test-result-summary.txt \
                -f summary \
                features/validatie/personen \
                --world-parameters "$PARAMS" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/personen/input-validatie/test-result-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt

echo "#### personen autorisatie validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/personen/autorisatie/test-result.json \
                -f summary:./test-reports/cucumber-js/personen/autorisatie/test-result-summary.txt \
                -f summary \
                features/autorisatie/personen \
                --world-parameters "$PARAMS" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/personen/autorisatie/test-result-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt

echo "#### personen protocollering validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/personen/protocollering/test-result.json \
                -f summary:./test-reports/cucumber-js/personen/protocollering/test-result-summary.txt \
                -f summary \
                features/protocollering/personen \
                --world-parameters "$PARAMS" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/personen/protocollering/test-result-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt

# reisdocumenten endpoint

echo "#### reisdocumenten input validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/reisdocumenten/input-validatie/test-result.json \
                -f summary:./test-reports/cucumber-js/reisdocumenten/input-validatie/test-result-summary.txt \
                -f summary \
                features/validatie/reisdocumenten \
                --world-parameters "$PARAMS" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/reisdocumenten/input-validatie/test-result-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt

echo "#### reisdocumenten autorisatie validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/reisdocumenten/autorisatie/test-result.json \
                -f summary:./test-reports/cucumber-js/reisdocumenten/autorisatie/test-result-summary.txt \
                -f summary \
                features/autorisatie/reisdocumenten \
                --world-parameters "$PARAMS" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/reisdocumenten/autorisatie/test-result-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt

echo "#### reisdocumenten protocollering validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/reisdocumenten/protocollering/test-result.json \
                -f summary:./test-reports/cucumber-js/reisdocumenten/protocollering/test-result-summary.txt \
                -f summary \
                features/protocollering/reisdocumenten \
                --world-parameters "$PARAMS" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/reisdocumenten/protocollering/test-result-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt

# verblijfplaatshistorie endpoint

echo "#### verblijfplaatshistorie input validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/verblijfplaatshistorie/input-validatie/test-result.json \
                -f summary:./test-reports/cucumber-js/verblijfplaatshistorie/input-validatie/test-result-summary.txt \
                -f summary \
                features/validatie/verblijfplaatshistorie \
                --world-parameters "$PARAMS" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/verblijfplaatshistorie/input-validatie/test-result-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt

echo "#### verblijfplaatshistorie autorisatie validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/verblijfplaatshistorie/autorisatie/test-result.json \
                -f summary:./test-reports/cucumber-js/verblijfplaatshistorie/autorisatie/test-result-summary.txt \
                -f summary \
                features/autorisatie/verblijfplaatshistorie \
                --world-parameters "$PARAMS" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/verblijfplaatshistorie/autorisatie/test-result-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt

echo "#### verblijfplaatshistorie protocollering validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/verblijfplaatshistorie/protocollering/test-result.json \
                -f summary:./test-reports/cucumber-js/verblijfplaatshistorie/protocollering/test-result-summary.txt \
                -f summary \
                features/protocollering/verblijfplaatshistorie \
                --world-parameters "$PARAMS" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/verblijfplaatshistorie/protocollering/test-result-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt

# bewoningen endpoint

echo "#### bewoningen input validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/bewoningen/input-validatie/test-result.json \
                -f summary:./test-reports/cucumber-js/bewoningen/input-validatie/test-result-summary.txt \
                -f summary \
                features/validatie/bewoningen \
                --world-parameters "$PARAMS" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/bewoningen/input-validatie/test-result-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt

echo "#### bewoningen autorisatie validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/bewoningen/autorisatie/test-result.json \
                -f summary:./test-reports/cucumber-js/bewoningen/autorisatie/test-result-summary.txt \
                -f summary \
                features/autorisatie/bewoning \
                --world-parameters "$PARAMS" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/bewoningen/autorisatie/test-result-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt

echo "#### bewoningen protocollering validatie"

npx cucumber-js -f json:./test-reports/cucumber-js/bewoningen/protocollering/test-result.json \
                -f summary:./test-reports/cucumber-js/bewoningen/protocollering/test-result-summary.txt \
                -f summary \
                features/protocollering/bewoning \
                --world-parameters "$PARAMS" \
                > /dev/null

node ./scripts/generate-step-summary.js ./test-reports/cucumber-js/bewoningen/protocollering/test-result-summary.txt ./test-reports/cucumber-js/step-summary.txt
cat ./test-reports/cucumber-js/step-summary.txt
