using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Validators;

public class AdresseerbaarObjectIdentificatieVerplichtValidator
{
    private static Validatie.Validators.AdresseerbaarObjectIdentificatieVerplichtValidator CreateSut() => new();

    [Fact]
    public void ShouldFailWhenAdresseerbaarObjectIdentificatiePropertyIsMissing()
    {
        var input = JObject.Parse("{}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
    }

    [Fact]
    public void ShouldFailWhenAdresseerbaarObjectIdentificatiePropertyIsEmpty()
    {
        var input = JObject.Parse("{\"adresseerbaarObjectIdentificatie\": \"\"}");
        var result = CreateSut().Validate(input);
        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
    }

    [InlineData("123456789012345")] // 15 cijfers
    [InlineData("12345678901234567")] // 17 cijfers
    [InlineData("123456789012345a")] // niet numeriek
    [InlineData("0000000000000000")] // 16 nullen (standaard waarde)
    [Theory]
    public void ShouldFailWhenAdresseerbaarObjectIdentificatiePropertyDoesNotMatchPattern(string value)
    {
        var input = JObject.Parse($"{{\"adresseerbaarObjectIdentificatie\": \"{value}\"}}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors.First().ErrorMessage.Should().Be("pattern||Waarde voldoet niet aan patroon ^(?!0{16})[0-9]{16}$.");
    }

    [Fact]
    public void ShouldPassWhenAdresseerbaarObjectIdentificatiePropertyIsNotEmptyAndMatchPattern()
    {
        var input = JObject.Parse("{\"adresseerbaarObjectIdentificatie\": \"1234567890123456\"}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeTrue();
    }
}
