using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Bewoningen;

public class RequestBodyValidatieService
{
    private static Validatie.Bewoningen.RequestBodyValidatieService CreateSut() => new();

    [Fact]
    public void ShouldFailWhenValueTypePropertyIsMissing()
    {
        var input = "{}";

        var result = CreateSut().ValidateRequestBody(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("type||required||Parameter is verplicht.");
    }

    [InlineData("bewoningmetpeildatum")]
    [InlineData("bewoningmetperiode")]
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

    [InlineData("{\"type\": \"BewoningMetPeildatum\", \"adresseerbaarObjectIdentificatie\": \"1234567890123456\", \"peildatum\": \"2021-12-01\"}")]
    [InlineData("{\"type\": \"BewoningMetPeriode\", \"adresseerbaarObjectIdentificatie\": \"1234567890123456\", \"datumVan\": \"2021-12-01\", \"datumTot\": \"2022-12-01\"}")]
    [Theory]
    public void ShouldPassWhenRequestBodyIsValid(string requestBody)
    {
        var result = CreateSut().ValidateRequestBody(requestBody);

        result.IsValid.Should().BeTrue();
    }
}
