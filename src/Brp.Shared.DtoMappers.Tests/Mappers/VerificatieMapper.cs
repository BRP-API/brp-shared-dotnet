using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class VerificatieMapperTests
{
    [Fact]
    public void ShouldMapVerificatieWithoutThrowing()
    {
        BrpDtos.GbaVerificatie input = new()
        {
            Datum = DateTime.Today.ToString("yyyyMMdd"),
            Omschrijving = "geverifieerd"
        };
        BrpApiDtos.Verificatie expected = new()
        {
            Datum = DateTime.Today.ToString("yyyyMMdd").Map(),
            Omschrijving = "geverifieerd"
        };

        input.Map().Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapUnknownDatumWithoutThrowing()
    {
        BrpDtos.GbaVerificatie input = new()
        {
            Datum = "00000000",
            Omschrijving = "onbekend"
        };
        BrpApiDtos.Verificatie expected = new()
        {
            Datum = "00000000".Map(),
            Omschrijving = "onbekend"
        };

        input.Map().Should().BeEquivalentTo(expected);
    }
}
