const report = require('multiple-cucumber-html-reporter');

report.generate({
    jsonDir: 'test-reports/cucumber-js/step-definitions',
    reportPath: 'test-reports/cucumber-js/reports/step-definitions',
    reportName: 'Stap definities tests',
    hideMetadata: true
});

report.generate({
    jsonDir: 'test-reports/cucumber-js/personen/input-validatie',
    reportPath: 'test-reports/cucumber-js/reports/personen/input-validatie',
    reportName: 'Personen input validatie tests',
    hideMetadata: true
});

report.generate({
    jsonDir: 'test-reports/cucumber-js/personen/autorisatie',
    reportPath: 'test-reports/cucumber-js/reports/personen/autorisatie',
    reportName: 'Personen autorisatie tests',
    hideMetadata: true
});