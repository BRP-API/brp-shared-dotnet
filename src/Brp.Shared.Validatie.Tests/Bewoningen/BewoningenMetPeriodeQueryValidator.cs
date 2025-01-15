using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Bewoningen;

public class BewoningenMetPeriodeQueryValidator
{
    private static Validatie.Bewoningen.BewoningMetPeriodeQueryValidator CreateSut() => new();

    [Fact]
    public void ShouldFailWhenAdresseerbaarObjectIdentificatiePropertyIsMissing()
    {
        var input = JObject.Parse("{\"datumVan\": \"2021-12-01\", \"datumTot\": \"2022-12-01\"}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("adresseerbaarObjectIdentificatie");
    }

    [InlineData("datumVan", "datumTot")]
    [InlineData("datumTot", "datumVan")]
    [Theory]
    public void ShouldFailWhenOneOrBothPeriodePropertiesAreMissing(string nameExistingPeriodeParameter, string nameMissingPeriodeParameter)
    {
        var input = JObject.Parse($"{{\"adresseerbaarObjectIdentificatie\": \"1234567890123456\", \"{nameExistingPeriodeParameter}\": \"2022-12-01\"}}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be(nameMissingPeriodeParameter);
    }

    [Fact]
    public void ShouldFailWhenOneOrMorePropertiesAreNotSpecifiedAsParameters()
    {
        var input = JObject.Parse("{\"type\": \"BewoningMetPeriode\", \"adresseerbaarObjectIdentificatie\": \"1234567890123456\", \"datumVan\": \"2021-12-01\", \"datumTot\": \"2022-12-01\", \"burgerservicenummer\": \"\"}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().HaveCount(1);
        result.Errors[0].ErrorMessage.Should().Be("burgerservicenummer||unknownParam||Parameter is niet verwacht.");
    }
}
