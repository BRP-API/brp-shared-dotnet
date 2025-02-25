using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Validators;

public class NietGespecificeerdParametersValidator
{
    private static Validatie.Validators.NietGespecificeerdeParametersValidator CreateSut(IEnumerable<string> gespecificeerdeParameterNamen) => new(gespecificeerdeParameterNamen);

    [InlineData("peildatum", "peildatum")]
    [InlineData("<script>alert('oeps')</script>", "&lt;script&gt;alert(&#39;oeps&#39;)&lt;/script&gt;")]
    [Theory]
    public void ShouldFailWhenPropertyIsNotASpecifiedParameter(string unspecifiedParameterName, string htmlEncodedUnspecifiedParameterName)
    {
        var input = JObject.Parse($"{{\"{unspecifiedParameterName}\": \"\"}}");

        var result = CreateSut(new string[] { "periode" }).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be($"{htmlEncodedUnspecifiedParameterName}||unknownParam||Parameter is niet verwacht.");
    }

    [Fact]
    public void ShouldPassWhenPropertyIsASpecifiedParameter()
    {
        var input = JObject.Parse("{\"periode\": \"\"}");
     
        var result = CreateSut(new string[] { "periode" }).Validate(input);

        result.IsValid.Should().BeTrue();
    }
}
