using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Historie;

public class RaadpleegMetPeildatumQueryValidator
{
    private static Validatie.Historie.RaadpleegMetPeildatumQueryValidator CreateSut() => new();

    [Fact]
    public void ShouldFailWhenRequiredPropertiesAreMissing()
    {
        var input = JObject.Parse("{}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().HaveCount(2);
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("burgerservicenummer");
        result.Errors[1].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[1].PropertyName.Should().Be("peildatum");
    }

    [Fact]
    public void ShouldFailWhenBurgerservicenummerPropertyIsMissing()
    {
        var input = JObject.Parse("{\"peildatum\": \"2021-12-01\"}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("burgerservicenummer");
    }

    [Fact]
    public void ShouldFailWhenPeildatumPropertyIsMissing()
    {
        var input = JObject.Parse("{\"burgerservicenummer\": \"000000012\"}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("peildatum");
    }

    [Fact]
    public void ShouldFailWhenOneOrMorePropertiesAreNotSpecifiedAsParameters()
    {
        var input = JObject.Parse("{\"type\": \"RaadpleegMetPeildatum\", \"burgerservicenummer\": \"000000012\", \"peildatum\": \"2021-12-01\", \"adresseerbaarObjectIdentificatie\": \"\"}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().HaveCount(1);
        result.Errors[0].ErrorMessage.Should().Be("adresseerbaarObjectIdentificatie||unknownParam||Parameter is niet verwacht.");
    }
}
