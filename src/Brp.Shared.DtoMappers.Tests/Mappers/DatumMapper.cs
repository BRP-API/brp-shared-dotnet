using Brp.Shared.DtoMappers.BrpApiDtos;
using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class DatumMapper
{
    [Fact]
    public void ShouldMapToVolledigeDatum()
    {
        var input = "20240102";
        var expected = new VolledigeDatum()
        {
            Datum = new DateTime(2024, 1, 2, 0, 0, 0, DateTimeKind.Local),
            LangFormaat = "2 januari 2024"
        };
        
        input.Map().Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapToJaarMaandDatum()
    {
        var input = "20240700";
        var expected = new JaarMaandDatum()
        {
            Jaar = 2024,
            Maand = 7,
            LangFormaat = "juli 2024"
        };

        input.Map().Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapToJaarDatum()
    {
        var input = DateTime.Today.ToString("yyyy0000");
        var expected = new JaarDatum()
        {
            Jaar = DateTime.Today.Year,
            LangFormaat = DateTime.Today.Year.ToString()
        };

        input.Map().Should().BeEquivalentTo(expected);
    }

    [InlineData("00000000")]
    [InlineData("onbekend")]
    [Theory]
    public void ShouldMapToDatumOnbekend(string input)
    {
        var expected = new DatumOnbekend() { LangFormaat = "onbekend", Onbekend = true };

        input.Map().Should().BeEquivalentTo(expected);
    }

    [Theory]
    [InlineData(1, "januari")]
    [InlineData(2, "februari")]
    [InlineData(3, "maart")]
    [InlineData(4, "april")]
    [InlineData(5, "mei")]
    [InlineData(6, "juni")]
    [InlineData(7, "juli")]
    [InlineData(8, "augustus")]
    [InlineData(9, "september")]
    [InlineData(10, "oktober")]
    [InlineData(11, "november")]
    [InlineData(12, "december")]
    public void ShouldCreateLangFormaatFromVolledigeDatum(int month, string expectedMonthString)
    {
        var input = $"2024{month:00}01";
        var expected = $"1 {expectedMonthString} 2024";

        input.Map().LangFormaat.Should().Be(expected);
    }

    [Theory]
    [InlineData(1, "januari")]
    [InlineData(2, "februari")]
    [InlineData(3, "maart")]
    [InlineData(4, "april")]
    [InlineData(5, "mei")]
    [InlineData(6, "juni")]
    [InlineData(7, "juli")]
    [InlineData(8, "augustus")]
    [InlineData(9, "september")]
    [InlineData(10, "oktober")]
    [InlineData(11, "november")]
    [InlineData(12, "december")]
    public void ShouldCreateLangFormaatFromJaarMaandDatum(int month, string expectedMonthString)
    {
        var input = $"2024{month:00}00";
        var expected = $"{expectedMonthString} 2024";

        input.Map().LangFormaat.Should().Be(expected);
    }
}
