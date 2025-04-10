const { Given, When, Then } = require('@cucumber/cucumber');
const { queryRowCount } = require('./postgresqlHelpers');
const { execute, truncate, select } = require('./postgresqlHelpers-2');
const { generateSqlStatementsFrom } = require('./sqlStatementsFactory');
const { assert } = require('chai');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();

Given(/de tabel '(.*)' bevat geen rijen/, async function (tabelNaam) {
    await truncate(tabelNaam);
});


When(/^de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd$/, async function () {
    if(this.context.data) {
        await execute(generateSqlStatementsFrom(this.context.data));
    }
});

Then(/heeft de (?:[a-z]*) '(.*)' de volgende rij(?:en)? in tabel '(.*)'/, async function(_, tabelNaam, dataTable) {    
    let results = await select(tabelNaam, dataTable);

    validateResult(results);
});

function validateResult(results){
    results.forEach(item => {
        if(item.result.rows.length > 0) {
            assert.containsAllKeys(item.result.rows[0], Object.keys(item.row));
        } else {
            throw {'Error': 'No matching records found!', 'Row': item.row}
        }
    })
}

Then(/^zijn er geen rijen in tabel '([a-z0-9_]*)'$/, async function (tabelNaam) {
    const actual = await queryRowCount(global.pool, tabelNaam);

    should.exist(actual);
    actual.should.equal('0');
});
