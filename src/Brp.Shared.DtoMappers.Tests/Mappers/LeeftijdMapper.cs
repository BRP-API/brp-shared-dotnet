using Brp.Shared.DtoMappers.BrpApiDtos;
using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;
using System.Globalization;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class LeeftijdMapper
{
    const string format = "yyyy-MM-dd";

    [InlineData("1992-02-01", 2)]
    [InlineData("1991-12-31", 1)]
    [Theory]
    public void ShouldCalculateLeeftijdFromJaarMaandDatumAndPeildatum(string peildatum, int expectedLeeftijd)
    {
        JaarMaandDatum input = new()
        {
            Jaar = 1990,
            Maand = 1
        };

        input.Leeftijd(DateTime.ParseExact(peildatum, format, CultureInfo.InvariantCulture)).Should().Be(expectedLeeftijd);
    }

    [Fact]
    public void ShouldNotCalculateLeeftijdFromJaarMaandDatumAndPeildatumWhenPeildatumMonthEqualsJaarMaandDatumMonth()
    {
        JaarMaandDatum input = new()
        {
            Jaar = 1990,
            Maand = 1
        };

        input.Leeftijd(DateTime.ParseExact("1992-01-01", format, CultureInfo.InvariantCulture)).Should().BeNull();
    }

    [InlineData("1992-02-14", 2)]
    [InlineData("1992-02-13", 1)]
    [InlineData("1992-01-31", 1)]
    [Theory]
    public void ShouldCalculateLeeftijdFromVolledigeDatumAndPeildatum(string peildatum, int leeftijd)
    {
        VolledigeDatum input = new()
        {
            Datum = DateTime.ParseExact("1990-02-14", format, CultureInfo.InvariantCulture)
        };

        input.Leeftijd(DateTime.ParseExact(peildatum, format, CultureInfo.InvariantCulture)).Should().Be(leeftijd);
    }

    [Fact]
    public void ShouldNotCalculateLeeftijdFromJaarDatum()
    {
        JaarDatum input = new()
        {
            Jaar = 1990
        };
        input.Leeftijd().Should().BeNull();
    }


}
