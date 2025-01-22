using AutoMapper;
using Brp.Shared.DtoMappers.CommonDtos;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Profiles;

public class NaamVolledigeNaamProfile
{
    private static IMapper CreateSut() => AutomapperUnderTestFactory.CreateSut<DtoMappers.Profiles.NaamVolledigeNaamProfile>();

    [Fact]
    public void ShouldMapWithoutThrowing()
    {
        NaamBasis input = new()
        {
            Voornamen = "Jan",
            Voorvoegsel = "van",
            Geslachtsnaam = "Veen"
        };

        BrpApiDtos.NaamVolledigeNaam expected = new()
        {
            VolledigeNaam = "Jan van Veen"
        };

        CreateSut().Map<BrpApiDtos.NaamVolledigeNaam>(input).Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapNaamMetAdellijkeTitelPredicaatWithoutThrowing()
    {
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

        BrpApiDtos.NaamVolledigeNaam expected = new();

        CreateSut().Map<BrpApiDtos.NaamVolledigeNaam>(input).Should().BeEquivalentTo(expected);
    }
}
