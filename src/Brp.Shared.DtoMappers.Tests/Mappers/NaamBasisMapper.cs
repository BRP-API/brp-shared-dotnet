using Brp.Shared.DtoMappers.CommonDtos;
using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class NaamBasisMapper
{
    [Fact]
    public void ShouldMapNaamBasisToNaamPersoonBeperktWithoutThrowing()
    {
        Waardetabel geslacht = new()
        {
            Code = "M"
        };
        NaamBasis input = new()
        {
            Voornamen = "Jan",
            Voorvoegsel = "van",
            Geslachtsnaam = "Veen"
        };
        BrpApiDtos.NaamPersoonBeperkt expected = new()
        {
            Voornamen = "Jan",
            Voorvoegsel = "van",
            Geslachtsnaam = "Veen",
            Voorletters = "J.",
            VolledigeNaam = "Jan van Veen"
        };
        input.Map(geslacht, null).Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapNaamBasisToNaamPersoonBeperktWithAdellijkeTitelPredicaatWithoutThrowing()
    {
        Waardetabel geslacht = new()
        {
            Code = "M"
        };
        NaamBasis input = new()
        {
            Voornamen = "Jan",
            Voorvoegsel = "van",
            Geslachtsnaam = "Veen",
            AdellijkeTitelPredicaat = new AdellijkeTitelPredicaatType()
            {
                Code = "JH",
                Soort = AdellijkeTitelPredicaatSoort.Predicaat,
                Omschrijving = "Jonkheer"
            }
        };
        BrpApiDtos.NaamPersoonBeperkt expected = new()
        {
            Voornamen = "Jan",
            Voorvoegsel = "van",
            Geslachtsnaam = "Veen",
            Voorletters = "J.",
            AdellijkeTitelPredicaat = new AdellijkeTitelPredicaatType()
            {
                Code = "JH",
                Soort = AdellijkeTitelPredicaatSoort.Predicaat,
                Omschrijving = "Jonkheer"
            },
            VolledigeNaam = "jonkheer Jan van Veen"
        };
        input.Map(geslacht, null).Should().BeEquivalentTo(expected);
    }
}
