using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Validators;

public class GeslachtsnaamValidator
{
    private static Validatie.Validators.GeslachtsnaamValidator CreateSut(bool isVerplichtVeld) => new(isVerplichtVeld);

    [Fact]
    public void ShouldFailWhenRequiredGeslachtsnaamPropertyIsMissing()
    {
        var input = JObject.Parse("{}");

        var result = CreateSut(isVerplichtVeld: true).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
    }

    [Fact]
    public void ShouldPassWhenOptionalGeslachtsnaamPropertyIsMissing()
    {
        var input = JObject.Parse("{}");

        var result = CreateSut(isVerplichtVeld: false).Validate(input);

        result.IsValid.Should().BeTrue();
    }

    [InlineData(true, "required||Parameter is verplicht.")]
    [InlineData(false, "pattern||Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \\.\\-\\']{1,200}$|^[a-zA-Z0-9À-ž \\.\\-\\']{3,199}\\*{1}$.")]
    [Theory]
    public void ShouldFailWhenGeslachtsnaamPropertyIsEmpty(bool isVerplichtVeld, string errorMessage)
    {
        var input = JObject.Parse("{\"geslachtsnaam\": \"\"}");

        var result = CreateSut(isVerplichtVeld: isVerplichtVeld).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be(errorMessage);
    }

    [InlineData(true, "aA0<")] // ongeldige tekens
    [InlineData(true, "aA*")] // minder dan 3 karakters lang met wildcard
    [InlineData(true, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")] // meer dan 200 karakters lang
    [InlineData(false, "aA0<")] // ongeldige tekens
    [InlineData(false, "aA*")] // minder dan 3 karakters lang met wildcard
    [InlineData(false, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")] // meer dan 200 karakters lang
    [Theory]
    public void ShouldFailWhenGeslachtsnaamPropertyDoesNotMatchPattern(bool isVerplichtVeld, string value)
    {
        var input = JObject.Parse($"{{\"geslachtsnaam\": \"{value}\"}}");

        var result = CreateSut(isVerplichtVeld: isVerplichtVeld).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("pattern||Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \\.\\-\\']{1,200}$|^[a-zA-Z0-9À-ž \\.\\-\\']{3,199}\\*{1}$.");
    }

    [InlineData(true, "a")] // min 1 karakter lang zonder wildcard
    [InlineData(true, "abc*")] // min 3 karakters lang met wildcard
    [InlineData(false, "a")] // min 1 karakter lang zonder wildcard
    [InlineData(false, "abc*")] // min 3 karakters lang met wildcard
    [Theory]
    public void ShouldPassWhenGeslachtsnaamPropertyIsNotEmptyMatchesPattern(bool isVerplichtVeld, string value)
    {
        var input = JObject.Parse($"{{\"geslachtsnaam\": \"{value}\"}}");

        var result = CreateSut(isVerplichtVeld: isVerplichtVeld).Validate(input);

        result.IsValid.Should().BeTrue();
    }
}
