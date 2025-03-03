using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Personen;

public class ZoekMetPostcodeEnHuisnummerQueryValidator
{
    private static Validatie.Personen.ZoekMetPostcodeEnHuisnummerQueryValidator CreateSut() => new();

    [Fact]
    public void ShouldFailWhenRequiredParametersAreMissing()
    {
        var input = JObject.Parse("{}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().HaveCount(3);
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("postcode");
        result.Errors[1].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[1].PropertyName.Should().Be("huisnummer");
        result.Errors[2].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[2].PropertyName.Should().Be("fields");
    }

    [Fact]
    public void ShouldFailWhenOneOrMorePropertiesAreNotSpecifiedAsParameters()
    {
        var input = JObject.Parse("{\"type\": \"ZoekMetPostcodeEnHuisnummer\", \"postcode\": \"1234AA\", \"huisnummer\": \"1\", \"voornamen\": \"\", \"fields\": [ \"burgerservicenummer\" ]}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("voornamen||unknownParam||Parameter is niet verwacht.");
    }
}
