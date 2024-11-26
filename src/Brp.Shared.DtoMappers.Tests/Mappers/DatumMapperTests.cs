using Brp.Shared.DtoMappers.BrpApiDtos;
using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class DatumMapperTests
{
    [Fact]
    public void Map_VolledigeDatum()
    {
        var input = DateTime.Today.ToString("yyyyMMdd");
        var expected = new VolledigeDatum() { Datum = DateTime.Today };
        expected.LangFormaat = expected.LangFormaat();
        
        input.Map().Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void Map_YearMonth()
    {
        var input = DateTime.Today.ToString("yyyyMM00");
        var expected = new JaarMaandDatum() { Jaar = DateTime.Today.Year, Maand = DateTime.Today.Month };
        expected.LangFormaat = expected.LangFormaat();

        input.Map().Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void Map_JaarDatum()
    {
        var input = DateTime.Today.ToString("yyyy0000");
        var expected = new JaarDatum() { Jaar = DateTime.Today.Year };
        expected.LangFormaat = expected.LangFormaat();

        input.Map().Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void Map_DatumOnbekend()
    {
        var input = "onbekend";
        var expected = new DatumOnbekend() { LangFormaat = "onbekend" };

        input.Map().Should().BeEquivalentTo(expected);
    }
}
