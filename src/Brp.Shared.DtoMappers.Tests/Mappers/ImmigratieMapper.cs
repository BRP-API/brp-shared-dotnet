using Brp.Shared.DtoMappers.BrpDtos;
using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class ImmigratieMapper
{
    [Fact]
    public void MapImmigratieIsNullAndVerblijfplaatsInOnderzoekIsNotNull()
    {
        BrpDtos.GbaImmigratie? input = null;
        var verblijfplaats = new GbaVerblijfplaats
        {
            InOnderzoek = new BrpDtos.InOnderzoek
            {
                AanduidingGegevensInOnderzoek = "080000",
                DatumIngangOnderzoek = "20020701"
            }
        };
        BrpApiDtos.Immigratie expected = new()
        {
            InOnderzoek = new BrpApiDtos.ImmigratieInOnderzoek
            {
                LandVanwaarIngeschreven = true,
                DatumVestigingInNederland = true,
                IndicatieVestigingVanuitBuitenland = true,
                VanuitVerblijfplaatsOnbekend = true,
                DatumIngangOnderzoek = "20020701".Map()
            }
        };

        var actual = input.Map(verblijfplaats);
        actual.Should().BeEquivalentTo(expected);
    }
}
