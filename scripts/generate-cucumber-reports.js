const report = require('multiple-cucumber-html-reporter');

const customData = {
    title: 'BRP API',
    data: [
        { label: 'Applicatie', value: 'Autorisatie & Protocollering' },
        { label: 'Versie', value: `${process.argv[2]}` },
        { label: 'Build', value: `${process.argv[3]}`},
        { label: 'Branch', value: `${process.argv[4]}`}
    ]
};

report.generate({
    jsonDir: 'test-reports/cucumber-js/step-definitions',
    reportPath: 'test-reports/cucumber-js/reports/step-definitions',
    reportName: 'Stap definities tests',
    hideMetadata: true
});

// personen endpoint

report.generate({
    jsonDir: 'test-reports/cucumber-js/personen',
    reportPath: 'test-reports/cucumber-js/reports/personen',
    reportName: 'Personen input validatie, autorisatie & protocollering features',
    hideMetadata: true,
    customData: customData
});

// reisdocumenten endpoint

report.generate({
    jsonDir: 'test-reports/cucumber-js/reisdocumenten',
    reportPath: 'test-reports/cucumber-js/reports/reisdocumenten',
    reportName: 'Reisdocumenten input validatie, autorisatie & protocollering features',
    hideMetadata: true,
    customData: customData
});

// verblijfplaatshistorie endpoint

report.generate({
    jsonDir: 'test-reports/cucumber-js/verblijfplaatshistorie',
    reportPath: 'test-reports/cucumber-js/reports/verblijfplaatshistorie',
    reportName: 'Verblijfplaatshistorie input validatie, autorisatie & protocollering features',
    hideMetadata: true,
    customData: customData
});

// bewoningen endpoint

report.generate({
    jsonDir: 'test-reports/cucumber-js/bewoningen',
    reportPath: 'test-reports/cucumber-js/reports/bewoningen',
    reportName: 'Bewoningen input validatie, autorisatie & protocollering features',
    hideMetadata: true,
    customData: customData
});
