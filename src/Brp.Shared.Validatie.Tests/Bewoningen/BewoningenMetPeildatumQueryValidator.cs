using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Bewoningen;

public class BewoningenMetPeildatumQueryValidator
{
    private static Validatie.Bewoningen.BewoningMetPeildatumQueryValidator CreateSut() => new();

    [Fact]
    public void ShouldFailWhenRequiredPropertiesAreMissing()
    {
        var input = JObject.Parse("{}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().HaveCount(2);
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("adresseerbaarObjectIdentificatie");
        result.Errors[1].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[1].PropertyName.Should().Be("peildatum");
    }

    [Fact]
    public void ShouldFailWhenAdresseerbaarObjectIdentificatiePropertyIsMissing()
    {
        var input = JObject.Parse("{\"peildatum\": \"2021-12-01\"}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("adresseerbaarObjectIdentificatie");
    }

    [Fact]
    public void ShouldFailWhenPeildatumPropertyIsMissing()
    {
        var input = JObject.Parse("{\"adresseerbaarObjectIdentificatie\": \"1234567890123456\"}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("peildatum");
    }

    [Fact]
    public void ShouldFailWhenOneOrMorePropertiesAreNotSpecifiedAsParameters()
    {
        var input = JObject.Parse("{\"type\": \"BewoningMetPeildatum\", \"adresseerbaarObjectIdentificatie\": \"1234567890123456\", \"peildatum\": \"2021-12-01\", \"burgerservicenummer\": \"\"}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().HaveCount(1);
        result.Errors[0].ErrorMessage.Should().Be("burgerservicenummer||unknownParam||Parameter is niet verwacht.");
    }
}
