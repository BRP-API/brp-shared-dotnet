using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Validators;

public class DatumValidator
{
    private static Validatie.Validators.DatumValidator CreateSut(string parameterNaam, bool isVerplichtVeld) => new(parameterNaam, isVerplichtVeld);

    [Fact]
    public void ShouldFailWhenDatumPropertyIsRequiredAndMissing()
    {
        var input = JObject.Parse("{}");

        var result = CreateSut("datumVan", true).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("datumVan");
    }

    [Fact]
    public void ShouldSucceedWhenDatumPropertyIsOptionalAndMissing()
    {
        var input = JObject.Parse("{}");

        var result = CreateSut("geboortedatum", false).Validate(input);

        result.IsValid.Should().BeTrue();
    }

    [Fact]
    public void ShouldFailWhenDatumPropertyNameAreNotEqual()
    {
        var input = JObject.Parse("{\"datumvan\": \"\"}");

        var result = CreateSut("datumVan", true).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("datumVan");
    }

    [InlineData(true, "required||Parameter is verplicht.")]
    [InlineData(false, "date||Waarde is geen geldige datum.")]
    [Theory]
    public void ShouldFailWhenDatumPropertyIsEmpty(bool isVerplichtVeld, string message)
    {
        var input = JObject.Parse("{\"datumVan\": \"\"}");

        var result = CreateSut("datumVan", isVerplichtVeld).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be(message);
        result.Errors[0].PropertyName.Should().Be("datumVan");
    }

    [InlineData(true, "2021-13-01")] // ongeldig maand
    [InlineData(true, "2021-12-32")] // ongeldig dag
    [InlineData(true, "2021-02-29")] // geen schrikkeljaar
    [InlineData(true, "not-a-date")] // geen datum
    [InlineData(true, "2021/12/01")] // ongeldig formaat
    [InlineData(false, "2021-13-01")] // ongeldig maand
    [InlineData(false, "2021-12-32")] // ongeldig dag
    [InlineData(false, "2021-02-29")] // geen schrikkeljaar
    [InlineData(false, "not-a-date")] // geen datum
    [InlineData(false, "2021/12/01")] // ongeldig formaat
    [Theory]
    public void ShouldFailWhenDatumPropertyDoesNotMatchPatternOrIsNotAValidDate(bool isVerplichtVeld, string value)
    {
        var input = JObject.Parse($"{{\"datum\": \"{value}\"}}");

        var result = CreateSut("datum", isVerplichtVeld).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors.First().ErrorMessage.Should().Be("date||Waarde is geen geldige datum.");
    }
}
