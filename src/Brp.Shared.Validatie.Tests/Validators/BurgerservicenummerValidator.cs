using FluentAssertions;
using Newtonsoft.Json.Linq;
using Xunit;

namespace Brp.Shared.Validatie.Tests.Validators;

public class BurgerservicenummerValidator
{
    private static Validatie.Validators.BurgerservicenummerValidator CreateSut(bool isVerplichtVeld) => new(isVerplichtVeld);

    [Fact]
    public void ShouldFailWhenRequiredBurgerservicenummerPropertyIsMissing()
    {
        var input = JObject.Parse("{}");

        var result = CreateSut(isVerplichtVeld: true).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
    }

    [Fact]
    public void ShouldFailWhenRequiredBurgerservicenummerPropertyIsEmpty()
    {
        var input = JObject.Parse("{\"burgerservicenummer\": \"\"}");

        var result = CreateSut(isVerplichtVeld: true).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
    }

    [InlineData(true, "12345678")] // 8 cijfers
    [InlineData(true, "1234567890")] // 10 cijfers
    [InlineData(true, "12345678a")] // niet numeriek
    [InlineData(false, "12345678")] // 8 cijfers
    [InlineData(false, "1234567890")] // 10 cijfers
    [InlineData(false, "12345678a")] // niet numeriek
    [Theory]
    public void ShouldFailWhenBurgerservicenummerPropertyDoesNotMatchPattern(bool isVerplicht, string value)
    {
        var input = JObject.Parse($"{{\"burgerservicenummer\": \"{value}\"}}");

        var result = CreateSut(isVerplichtVeld: isVerplicht).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors.First().ErrorMessage.Should().Be("pattern||Waarde voldoet niet aan patroon ^[0-9]{9}$.");
    }

    [Fact]
    public void ShouldPassWhenRequiredBurgerservicenummerPropertyIsNotEmptyAndMatchPattern()
    {
        var input = JObject.Parse("{\"burgerservicenummer\": \"123456789\"}");

        var result = CreateSut(isVerplichtVeld: true).Validate(input);

        result.IsValid.Should().BeTrue();
    }

    [Fact]
    public void ShouldPassWhenOptionalBurgerservicenummerPropertyIsNotEmptyAndMatchPattern()
    {
        var input = JObject.Parse("{\"burgerservicenummer\": \"123456789\"}");

        var result = CreateSut(isVerplichtVeld: false).Validate(input);

        result.IsValid.Should().BeTrue();
    }
}
