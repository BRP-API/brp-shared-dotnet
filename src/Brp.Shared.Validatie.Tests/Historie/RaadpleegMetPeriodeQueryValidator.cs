using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Historie;

public class RaadpleegMetPeriodeQueryValidator
{
    private static Validatie.Historie.RaadpleegMetPeriodeQueryValidator CreateSut() => new();

    [Fact]
    public void ShouldFailWhenBurgerservicenummerPropertyIsMissing()
    {
        var input = JObject.Parse("{\"datumVan\": \"2021-12-01\", \"datumTot\": \"2022-12-01\"}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("burgerservicenummer");
    }

    [InlineData("datumVan", "datumTot")]
    [InlineData("datumTot", "datumVan")]
    [Theory]
    public void ShouldFailWhenOneOrBothPeriodePropertiesAreMissing(string nameExistingPeriodeParameter, string nameMissingPeriodeParameter)
    {
        var input = JObject.Parse($"{{\"burgerservicenummer\": \"000000012\", \"{nameExistingPeriodeParameter}\": \"2022-12-01\"}}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be(nameMissingPeriodeParameter);
    }

    [Fact]
    public void ShouldFailWhenOneOrMorePropertiesAreNotSpecifiedAsParameters()
    {
        var input = JObject.Parse("{\"type\": \"RaadpleegMetPeriode\", \"burgerservicenummer\": \"000000012\", \"datumVan\": \"2021-12-01\", \"datumTot\": \"2022-12-01\", \"adresseerbaarObjectIdentificatie\": \"\"}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().HaveCount(1);
        result.Errors[0].ErrorMessage.Should().Be("adresseerbaarObjectIdentificatie||unknownParam||Parameter is niet verwacht.");
    }
}
