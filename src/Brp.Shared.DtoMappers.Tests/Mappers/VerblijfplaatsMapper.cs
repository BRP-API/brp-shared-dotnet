using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class VerblijfplaatsMapper
{
    [Fact]
    public void MapToVerblijfplaatsOnbekend()
    {
        BrpDtos.GbaVerblijfplaats input = new()
        {
            Land = new CommonDtos.Waardetabel { Code = "0000" },
        };
        BrpApiDtos.VerblijfplaatsOnbekend expected = new()
        {

        };

        input.Map().Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void MapToVerblijfplaatsBuitenland()
    {
        BrpDtos.GbaVerblijfplaats input = new()
        {
            Land = new CommonDtos.Waardetabel { Code = "1234" },
        };
        BrpApiDtos.VerblijfplaatsBuitenland expected = new()
        {
            Verblijfadres = new BrpApiDtos.VerblijfadresBuitenland
            {
                Land = new CommonDtos.Waardetabel
                {
                    Code = "1234"
                }
            }
        };

        input.Map().Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void MapToAdres()
    {
        BrpDtos.GbaVerblijfplaats input = new()
        {
            Straat = "Straatnaam",
        };
        BrpApiDtos.Adres expected = new()
        {
            Verblijfadres = new BrpApiDtos.VerblijfadresBinnenland
            {
                KorteStraatnaam = "Straatnaam"
            }
        };
        input.Map().Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void MapToLocatie()
    {
        BrpDtos.GbaVerblijfplaats input = new()
        {
            Locatiebeschrijving = "Locatiebeschrijving"
        };
        BrpApiDtos.Locatie expected = new()
        {
            Verblijfadres = new()
            {
                Locatiebeschrijving = "Locatiebeschrijving"
            }
        };
        input.Map().Should().BeEquivalentTo(expected);
    }
}
