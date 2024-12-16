using Brp.Shared.DtoMappers.BrpDtos;
using Brp.Shared.DtoMappers.Interfaces;
using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class VolledigeNaamMapper
{
    [Fact]
    public void GeenAdellijkeTitelOfPredicaat()
    {
        var naam = new NaamBasis()
        {
            Voornamen = "Jan",
            Voorvoegsel = "van",
            Geslachtsnaam = "Veen"
        };
        Waardetabel? geslacht = null;

        naam.VolledigeNaam(geslacht).Should().Be("Jan van Veen");
    }

    [Fact]
    public void GeenVoorvoegsel()
    {
        var naam = new NaamBasis()
        {
            Voornamen = "Jan",
            Geslachtsnaam = "Veen"
        };
        Waardetabel? geslacht = null;

        naam.VolledigeNaam(geslacht).Should().Be("Jan Veen");
    }

    [Fact]
    public void VoorvoegselStandaardGeslachtsnaam()
    {
        var naam = new NaamBasis()
        {
            Voornamen = "Jan",
            Voorvoegsel = "van den",
            Geslachtsnaam = "."
        };
        Waardetabel? geslacht = null;

        naam.VolledigeNaam(geslacht).Should().Be("Jan van den");
    }

    [Fact]
    public void Naamketen()
    {
        var naam = new NaamBasis()
        {
            Geslachtsnaam = "Obbadah"
        };
        Waardetabel? geslacht = null;

        naam.VolledigeNaam(geslacht).Should().Be("Obbadah");
    }

    [Fact]
    public void StandaardGeslachtsnaam()
    {
        var naam = new NaamBasis()
        {
            Voornamen = "Jan",
            Geslachtsnaam = "."
        };
        Waardetabel? geslacht = null;

        naam.VolledigeNaam(geslacht).Should().Be("Jan");
    }

    [Fact]
    public void VolledigOnbekendeNaam()
    {
        var naam = new NaamBasis()
        {
            Geslachtsnaam = "."
        };
        Waardetabel? geslacht = null;

        naam.VolledigeNaam(geslacht).Should().BeNull();
    }

    [InlineData("V", "JV", "jonkvrouw")]
    [InlineData("V", "JH", "jonkvrouw")]
    [InlineData("M", "JV", "jonkheer")]
    [InlineData("M", "JH", "jonkheer")]
    [InlineData("O", "JV", "jonkvrouw")]
    [InlineData("O", "JH", "jonkheer")]
    [Theory]
    public void Predicaat(string geslachtCode, string predicaatCode, string expectedPredicaat)
    {
        var naam = new NaamBasis()
        {
            Voornamen = "Jan",
            Geslachtsnaam = "Veen",
            AdellijkeTitelPredicaat = new AdellijkeTitelPredicaatType() { Code = predicaatCode }
        };
        var geslacht = new Waardetabel() { Code = geslachtCode };

        naam.VolledigeNaam(geslacht).Should().Be($"{expectedPredicaat} Jan Veen");
    }
}
