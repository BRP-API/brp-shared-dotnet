using FluentAssertions;
using Newtonsoft.Json.Linq;

namespace Brp.Shared.Validatie.Tests.Validators;

public class NietGespecificeerdParametersValidator
{
    private static Validatie.Validators.NietGespecificeerdeParametersValidator CreateSut(IEnumerable<string> gespecificeerdeParameterNamen) => new(gespecificeerdeParameterNamen);

    [Fact]
    public void ShouldFailWhenPropertyIsNotASpecifiedParameter()
    {
        var input = JObject.Parse("{\"peildatum\": \"\"}");

        var result = CreateSut(new string[] { "periode" }).Validate(input);

        result.IsValid.Should().BeFalse();
        result.Errors.Should().ContainSingle();
        result.Errors[0].ErrorMessage.Should().Be("peildatum||unknownParam||Parameter is niet verwacht.");
    }

    [Fact]
    public void ShouldPassWhenPropertyIsASpecifiedParameter()
    {
        var input = JObject.Parse("{\"periode\": \"\"}");
     
        var result = CreateSut(new string[] { "periode" }).Validate(input);

        result.IsValid.Should().BeTrue();
    }
}
