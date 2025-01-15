using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Validators;

public class PeriodeValidator
{
    private static Validatie.Validators.PeriodeValidator CreateSut(string naamVanParameter, string naamTotParameter) => new(naamVanParameter, naamTotParameter);

    [Fact]
    public void ShouldFailWhenBothDatumPropertiesAreMissing()
    {
        var input = JObject.Parse("{}");

        var result = CreateSut("datumVan", "datumTot").Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().HaveCount(2);
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("datumTot");
        result.Errors[1].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[1].PropertyName.Should().Be("datumVan");
    }

    [InlineData("datumVan", "datumTot")]
    [InlineData("datumTot", "datumVan")]
    [Theory]
    public void ShouldFailWhenOneParameterPropertyIsMissing(string nameExistingParameter, string nameMissingParameter)
    {
        var input = JObject.Parse($"{{\"{nameExistingParameter}\": \"2024-01-01\"}}");

        var result = CreateSut(nameExistingParameter, nameMissingParameter).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().HaveCount(1);
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be(nameMissingParameter);
    }

    [InlineData("2024-01-01", "2024-01-01")]
    [InlineData("2024-01-01", "2023-01-01")]
    [Theory]
    public void ShouldFailWhenVanParameterPropertyIsGreaterThanOrEqualToTotParameterProperty(string valueVanParameter, string valueTotParameter)
    {
        var input = JObject.Parse($"{{\"datumVan\": \"{valueVanParameter}\", \"datumTot\": \"{valueTotParameter}\"}}");

        var result = CreateSut("datumVan", "datumTot").Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().HaveCount(1);
        result.Errors[0].ErrorMessage.Should().Be("date||datumTot moet na datumVan liggen.");
        result.Errors[0].PropertyName.Should().Be("datumTot");
    }
}
