using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Validators;

public class BurgerservicenummerVerplichtCollectieValidator
{
    private static Validatie.Validators.BurgerservicenummerVerplichtCollectieValidator CreateSut() => new();

    [Fact]
    public void ShouldFailWhenRequiredBurgerservicenummerPropertyIsMissing()
    {
        var input = JObject.Parse("{}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("required||Parameter is verplicht.");
    }

    [Fact]
    public void ShouldFailWhenRequiredBurgerservicenummerPropertyIsNotAnArray()
    {
        var input = JObject.Parse("{\"burgerservicenummer\": \"\"}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("array||Parameter is geen array.");
    }

    [Fact]
    public void ShouldFailWhenRequiredBurgerservicenummerPropertyIsEmptyArray()
    {
        var input = JObject.Parse("{\"burgerservicenummer\": []}");
        var result = CreateSut().Validate(input);
        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("minItems||Array bevat minder dan 1 items.");
    }

    [Fact]
    public void ShouldFailWhenRequiredBurgerservicenummerPropertyContainsMoreThan20Items()
    {
        var input = JObject.Parse("{\"burgerservicenummer\": [" +
            "\"123456789\", \"123456789\", \"123456789\", \"123456789\", \"123456789\", \"123456789\", \"123456789\", \"123456789\", \"123456789\", \"123456789\"," +
            "\"123456789\", \"123456789\", \"123456789\", \"123456789\", \"123456789\", \"123456789\", \"123456789\", \"123456789\", \"123456789\", \"123456789\"," +
            "\"123456789\"]}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("maxItems||Array bevat meer dan 20 items.");
    }

    [Fact]
    public void ShouldFailWhenRequiredBurgerservicenummerPropertyContainsOneOrMoreItemsThatDoesNotMatchPattern()
    {
        var input = JObject.Parse("{\"burgerservicenummer\": [\"12345678\", \"1234567890\", \"123456789\", \"12345678a\"]}");

        var result = CreateSut().Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().HaveCount(3);
        result.Errors[0].ErrorMessage.Should().Be("pattern||Waarde voldoet niet aan patroon ^[0-9]{9}$.");
        result.Errors[0].PropertyName.Should().Be("burgerservicenummer[0]");
        result.Errors[1].ErrorMessage.Should().Be("pattern||Waarde voldoet niet aan patroon ^[0-9]{9}$.");
        result.Errors[1].PropertyName.Should().Be("burgerservicenummer[1]");
        result.Errors[2].ErrorMessage.Should().Be("pattern||Waarde voldoet niet aan patroon ^[0-9]{9}$.");
        result.Errors[2].PropertyName.Should().Be("burgerservicenummer[3]");
    }
}
