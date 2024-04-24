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
    reportName: 'Personen input validatie features',
    hideMetadata: true,
    customData: {
        title: 'BRP API',
        data: [
            { label: 'Applicatie', value: 'Autorisatie & Protocollering' },
            { label: 'Versie', value: `${process.argv[2]}` },
            { label: 'Build', value: `${process.argv[3]}`}
        ]
    }
});

report.generate({
    jsonDir: 'test-reports/cucumber-js/personen/autorisatie',
    reportPath: 'test-reports/cucumber-js/reports/personen/autorisatie',
    reportName: 'Personen autorisatie features',
    hideMetadata: true,
    customData: {
        title: 'BRP API',
        data: [
            { label: 'Applicatie', value: 'Autorisatie & Protocollering' },
            { label: 'Versie', value: `${process.argv[2]}` },
            { label: 'Build', value: `${process.argv[3]}`}
        ]
    }
});

report.generate({
    jsonDir: 'test-reports/cucumber-js/personen/protocollering',
    reportPath: 'test-reports/cucumber-js/reports/personen/protocollering',
    reportName: 'Personen protocollering features',
    hideMetadata: true,
    customData: {
        title: 'BRP API',
        data: [
            { label: 'Applicatie', value: 'Autorisatie & Protocollering' },
            { label: 'Versie', value: `${process.argv[2]}` },
            { label: 'Build', value: `${process.argv[3]}`}
        ]
    }
});
