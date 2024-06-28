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
    jsonDir: 'test-reports/cucumber-js/personen/input-validatie',
    reportPath: 'test-reports/cucumber-js/reports/personen/input-validatie',
    reportName: 'Personen input validatie features',
    hideMetadata: true,
    customData: customData
});

report.generate({
    jsonDir: 'test-reports/cucumber-js/personen/autorisatie',
    reportPath: 'test-reports/cucumber-js/reports/personen/autorisatie',
    reportName: 'Personen autorisatie features',
    hideMetadata: true,
    customData: customData
});

report.generate({
    jsonDir: 'test-reports/cucumber-js/personen/protocollering',
    reportPath: 'test-reports/cucumber-js/reports/personen/protocollering',
    reportName: 'Personen protocollering features',
    hideMetadata: true,
    customData: customData
});

// reisdocumenten endpoint

report.generate({
    jsonDir: 'test-reports/cucumber-js/reisdocumenten/input-validatie',
    reportPath: 'test-reports/cucumber-js/reports/reisdocumenten/input-validatie',
    reportName: 'Reisdocumenten input validatie features',
    hideMetadata: true,
    customData: customData
});

report.generate({
    jsonDir: 'test-reports/cucumber-js/reisdocumenten/autorisatie',
    reportPath: 'test-reports/cucumber-js/reports/reisdocumenten/autorisatie',
    reportName: 'Reisdocumenten autorisatie features',
    hideMetadata: true,
    customData: customData
});

report.generate({
    jsonDir: 'test-reports/cucumber-js/reisdocumenten/protocollering',
    reportPath: 'test-reports/cucumber-js/reports/reisdocumenten/protocollering',
    reportName: 'Reisdocumenten protocollering features',
    hideMetadata: true,
    customData: customData
});

// verblijfplaatshistorie endpoint

report.generate({
    jsonDir: 'test-reports/cucumber-js/verblijfplaatshistorie/input-validatie',
    reportPath: 'test-reports/cucumber-js/reports/verblijfplaatshistorie/input-validatie',
    reportName: 'Verblijfplaatshistorie input validatie features',
    hideMetadata: true,
    customData: customData
});

report.generate({
    jsonDir: 'test-reports/cucumber-js/verblijfplaatshistorie/autorisatie',
    reportPath: 'test-reports/cucumber-js/reports/verblijfplaatshistorie/autorisatie',
    reportName: 'Verblijfplaatshistorie autorisatie features',
    hideMetadata: true,
    customData: customData
});

report.generate({
    jsonDir: 'test-reports/cucumber-js/verblijfplaatshistorie/protocollering',
    reportPath: 'test-reports/cucumber-js/reports/verblijfplaatshistorie/protocollering',
    reportName: 'Verblijfplaatshistorie protocollering features',
    hideMetadata: true,
    customData: customData
});
