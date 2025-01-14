using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Validators;

public class DatumValidator
{
    private static Validatie.Validators.DatumValidator CreateSut(string parameterNaam, bool isVerplichtVeld) => new(parameterNaam, isVerplichtVeld);

    [Fact]
    public void ShouldFailWhenDatumPropertyIsMissing()
    {
        var input = JObject.Parse("{}");

        var result = CreateSut("datumVan", true).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("datumVan");
    }

    [Fact]
    public void ShouldFailWhenDatumPropertyNameDoesNotMatch()
    {
        var input = JObject.Parse("{\"datumvan\": \"\"}");

        var result = CreateSut("datumVan", true).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("datumVan");
    }

    [Fact]
    public void ShouldFailWhenDatumPropertyIsEmpty()
    {
        var input = JObject.Parse("{\"datumVan\": \"\"}");

        var result = CreateSut("datumVan", true).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
    }

    [InlineData("2021-13-01")] // ongeldig maand
    [InlineData("2021-12-32")] // ongeldig dag
    [InlineData("2021-02-29")] // geen schrikkeljaar
    [InlineData("not-a-date")] // geen datum
    [InlineData("2021/12/01")] // ongeldig formaat
    [Theory]
    public void ShouldFailWhenDatumPropertyDoesNotMatchPatternOrIsNotAValidDate(string value)
    {
        var input = JObject.Parse($"{{\"datum\": \"{value}\"}}");

        var result = CreateSut("datum", true).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors.First().ErrorMessage.Should().Be("date||Waarde is geen geldige datum.");
    }
}
