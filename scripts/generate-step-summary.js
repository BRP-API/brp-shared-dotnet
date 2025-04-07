const fs = require('fs');
const path = require('path');
const { processFile } = require('./process-cucumber-file');

const outputFile = path.join(__dirname, './../test-reports/cucumber-js/step-summary.txt');
fs.writeFileSync(outputFile, '', 'utf8');

const fileMap = new Map([
    ["./../test-reports/cucumber-js/step-definitions/test-result-zonder-dependency-integratie-summary.txt", "docs (zonder integratie)"],
    ["./../test-reports/cucumber-js/step-definitions/test-result-integratie-summary.txt", "docs (integratie)"],
    ["./../test-reports/cucumber-js/step-definitions/test-result-informatie-api-summary.txt", "docs informatie api context"],
    ["./../test-reports/cucumber-js/step-definitions/test-result-data-api-summary.txt", "docs data api context"],
    ["./../test-reports/cucumber-js/step-definitions/test-result-gezag-api-summary.txt", "docs gezag api context"],
    ["./../test-reports/cucumber-js/step-definitions/test-result-gezag-api-deprecated-summary.txt", "docs gezag api deprecated context"],
    ["./../test-reports/cucumber-js/personen/input-validatie/test-result-summary.txt", "personen (input validatie)"],
    ["./../test-reports/cucumber-js/personen/autorisatie/test-result-summary.txt", "personen (autorisatie)"],
    ["./../test-reports/cucumber-js/personen/protocollering/test-result-summary.txt", "personen (protocollering)"],
    ["./../test-reports/cucumber-js/reisdocumenten/input-validatie/test-result-summary.txt", "reisdocumenten (input validatie)"],
    ["./../test-reports/cucumber-js/reisdocumenten/autorisatie/test-result-summary.txt", "reisdocumenten (autorisatie)"],
    ["./../test-reports/cucumber-js/reisdocumenten/protocollering/test-result-summary.txt", "reisdocumenten (protocollering"],
    ["./../test-reports/cucumber-js/verblijfplaatshistorie/input-validatie/test-result-summary.txt", "verblijfplaatshistorie (input validatie)"],
    ["./../test-reports/cucumber-js/verblijfplaatshistorie/autorisatie/test-result-summary.txt", "verblijfplaatshistorie (autorisatie)"],
    ["./../test-reports/cucumber-js/verblijfplaatshistorie/protocollering/test-result-summary.txt", "verblijfplaatshistorie (protocollering)"],
    ["./../test-reports/cucumber-js/bewoningen/input-validatie/test-result-summary.txt", "bewoningen (input validatie)"],
    ["./../test-reports/cucumber-js/bewoningen/autorisatie/test-result-summary.txt", "bewoningen (autorisatie)"],
    ["./../test-reports/cucumber-js/bewoningen/protocollering/test-result-summary.txt", "bewoningen (protocollering)"]
]);

fileMap.forEach((caption, filePath) => {
    processFile(path.join(__dirname, filePath), outputFile, caption);
});
