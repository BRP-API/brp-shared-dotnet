using FluentAssertions;

namespace Brp.Shared.Validatie.Tests.Historie;

public class RequestBodyValidatieService
{
    private static Validatie.Historie.RequestBodyValidatieService CreateSut() => new();

    [Fact]
    public void ShouldFailWhenValueTypePropertyIsMissing()
    {
        var input = "{}";

        var result = CreateSut().ValidateRequestBody(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("type||required||Parameter is verplicht.");
    }

    [InlineData("raadpleegmetpeildatum")]
    [InlineData("raadpleegmetperiode")]
    [InlineData("")]
    [Theory]
    public void ShouldFailWhenValueTypePropertyIsNotASpecifiedValue(string valueTypeParameter)
    {
        var input = $"{{\"type\": \"{valueTypeParameter}\"}}";

        var result = CreateSut().ValidateRequestBody(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().HaveCount(1);
        result.Errors[0].ErrorMessage.Should().Be("type||value||Waarde is geen geldig zoek type.");
    }

    [InlineData("{\"type\": \"RaadpleegMetPeildatum\", \"burgerservicenummer\": \"000000012\", \"peildatum\": \"2021-12-01\"}")]
    [InlineData("{\"type\": \"RaadpleegMetPeriode\", \"burgerservicenummer\": \"000000012\", \"datumVan\": \"2021-12-01\", \"datumTot\": \"2022-12-01\"}")]
    [Theory]
    public void ShouldPassWhenRequestBodyIsValid(string requestBody)
    {
        var result = CreateSut().ValidateRequestBody(requestBody);

        result.IsValid.Should().BeTrue();
    }
}
