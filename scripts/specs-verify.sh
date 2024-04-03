#!/bin/bash

npx cucumber-js -f json:./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie.json \
                -f summary:./test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie-summary.txt \
                -f summary \
                features/docs \
                --tags "not @integratie"

npx cucumber-js -f json:./test-reports/cucumber-js/personen/input-validatie/test-result.json \
                -f summary:./test-reports/cucumber-js/personen/input-validatie/test-result-summary.txt \
                -f summary \
                features/validatie/personen

npx cucumber-js -f json:./test-reports/cucumber-js/personen/autorisatie/test-result.json \
                -f summary:./test-reports/cucumber-js/personen/autorisatie/test-result-summary.txt \
                -f summary \
                features/autorisatie/personen \
                --tags @fout-case
