using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class GeboorteBasisMapperTests
{
    [Fact]
    public void ShouldMapWithoutThrowing()
    {
        BrpDtos.GeboorteBasis input = new()
        {
            Datum = DateTime.Today.ToString("yyyyMMdd"),
        };

        BrpApiDtos.GeboorteBasis expected = new()
        {
            Datum = DateTime.Today.ToString("yyyyMMdd").Map()
        };

        input.Map(null).Should().BeEquivalentTo(expected);
    }
}
