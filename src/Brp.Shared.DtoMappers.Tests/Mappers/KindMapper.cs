using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class KindMapper
{
    [Fact]
    public void ShouldMapKind()
    {
        BrpDtos.GbaKind input = new()
        {
            Burgerservicenummer = "123456789"
        };
        BrpApiDtos.Kind expected = new()
        {
            Burgerservicenummer = "123456789",
        };
        var actual = input.Map();
        actual.Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapKindNaam()
    {
        BrpDtos.GbaKind input = new()
        {
            Naam = new CommonDtos.NaamBasis
            {
                Geslachtsnaam = "Jansen",
                Voornamen = "Jan Dirk"
            }
        };
        BrpApiDtos.Kind expected = new()
        {
            Naam = new BrpApiDtos.NaamGerelateerde
            {
                Geslachtsnaam = "Jansen",
                Voornamen = "Jan Dirk",
                Voorletters = "J.D."
            }
        };
        var actual = input.Map();
        actual.Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapKindGeboorte()
    {
        BrpDtos.GbaKind input = new()
        {
            Geboorte = new BrpDtos.GbaGeboorte
            {
                Datum = "20200101",
            }
        };
        BrpApiDtos.Kind expected = new()
        {
            Geboorte = new BrpApiDtos.Geboorte
            {
                Datum = "20200101".Map(),
            }
        };
        var actual = input.Map();
        actual.Should().BeEquivalentTo(expected);
    }
}
