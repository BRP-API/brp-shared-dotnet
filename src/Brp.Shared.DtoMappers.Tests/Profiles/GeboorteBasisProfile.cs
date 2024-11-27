using AutoMapper;
using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Profiles;

public class GeboorteBasisProfile
{
    private static IMapper CreateSut() => AutomapperUnderTestFactory.CreateSut<DtoMappers.Profiles.GeboorteBasisProfile>();

    [Fact]
    public void ShouldMapWithoutThrowing()
    {
        BrpDtos.GeboorteBasis input = new ()
        {
            Datum = DateTime.Today.ToString("yyyyMMdd"),
        };

        BrpApiDtos.GeboorteBasis expected = new ()
        {
            Datum = DateTime.Today.ToString("yyyyMMdd").Map()
        };

        CreateSut().Map<BrpApiDtos.GeboorteBasis>(input).Should().BeEquivalentTo(expected);
    }
}
