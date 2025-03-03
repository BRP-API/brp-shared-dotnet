using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Personen;

public class ZoekMetGeslachtsnaamEnGeboortedatumQueryValidator
{
    private static Validatie.Personen.ZoekMetGeslachtsnaamEnGeboortedatumQueryValidator CreateSut() => new();

    [Fact]
    public void ShouldFailWhenRequiredParametersAreMissing()
    {
        var input = JObject.Parse("{}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().HaveCount(3);
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[0].PropertyName.Should().Be("geboortedatum");
        result.Errors[1].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[1].PropertyName.Should().Be("geslachtsnaam");
        result.Errors[2].ErrorMessage.Should().Be("required||Parameter is verplicht.");
        result.Errors[2].PropertyName.Should().Be("fields");
    }

    [Fact]
    public void ShouldFailWhenOneOrMorePropertiesAreNotSpecifiedAsParameters()
    {
        var input = JObject.Parse("{\"type\": \"ZoekMetGeslachtsnaamEnGeboortedatum\", \"geboortedatum\": \"2021-12-01\", \"geslachtsnaam\": \"Jansen\", \"postcode\": \"\", \"fields\": [ \"burgerservicenummer\" ]}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("postcode||unknownParam||Parameter is niet verwacht.");
    }
}
