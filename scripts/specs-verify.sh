#!/bin/bash

PARAMS="{ \
    \"logFileToAssert\": \"./test-data/logs/brp-autorisatie-protocollering.json\", \
    \"oAuth\": { \
        \"enable\": true \
    } \
}"

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie-summary.txt \
                -f summary \
                features/docs \
                --tags "not @integratie"

# personen endpoint

npx cucumber-js -f json:./test-reports/cucumber-js/personen/input-validatie/test-result.json \
                -f summary:./test-reports/cucumber-js/personen/input-validatie/test-result-summary.txt \
                -f summary \
                features/validatie/personen \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:./test-reports/cucumber-js/personen/autorisatie/test-result.json \
                -f summary:./test-reports/cucumber-js/personen/autorisatie/test-result-summary.txt \
                -f summary \
                features/autorisatie/personen \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:./test-reports/cucumber-js/personen/protocollering/test-result.json \
                -f summary:./test-reports/cucumber-js/personen/protocollering/test-result-summary.txt \
                -f summary \
                features/protocollering/personen \
                --world-parameters "$PARAMS"

# reisdocumenten endpoint

npx cucumber-js -f json:./test-reports/cucumber-js/reisdocumenten/input-validatie/test-result.json \
                -f summary:./test-reports/cucumber-js/reisdocumenten/input-validatie/test-result-summary.txt \
                -f summary \
                features/validatie/reisdocumenten \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:./test-reports/cucumber-js/reisdocumenten/autorisatie/test-result.json \
                -f summary:./test-reports/cucumber-js/reisdocumenten/autorisatie/test-result-summary.txt \
                -f summary \
                features/autorisatie/reisdocumenten \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:./test-reports/cucumber-js/reisdocumenten/protocollering/test-result.json \
                -f summary:./test-reports/cucumber-js/reisdocumenten/protocollering/test-result-summary.txt \
                -f summary \
                features/protocollering/reisdocumenten \
                --world-parameters "$PARAMS"

# verblijfplaatshistorie endpoint

npx cucumber-js -f json:./test-reports/cucumber-js/verblijfplaatshistorie/input-validatie/test-result.json \
                -f summary:./test-reports/cucumber-js/verblijfplaatshistorie/input-validatie/test-result-summary.txt \
                -f summary \
                features/validatie/verblijfplaatshistorie \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:./test-reports/cucumber-js/verblijfplaatshistorie/autorisatie/test-result.json \
                -f summary:./test-reports/cucumber-js/verblijfplaatshistorie/autorisatie/test-result-summary.txt \
                -f summary \
                features/autorisatie/verblijfplaatshistorie \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:./test-reports/cucumber-js/verblijfplaatshistorie/protocollering/test-result.json \
                -f summary:./test-reports/cucumber-js/verblijfplaatshistorie/protocollering/test-result-summary.txt \
                -f summary \
                features/protocollering/verblijfplaatshistorie \
                --world-parameters "$PARAMS"
