using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class PartnerMapper
{
    [Fact]
    public void ShouldMapAangaanHuwelijkPartnerschapInOnderzoek()
    {
        BrpDtos.GbaPartner input = new()
        {
            InOnderzoek = new BrpDtos.InOnderzoek
            {
                AanduidingGegevensInOnderzoek = "050000",
                DatumIngangOnderzoek = "20200101"
            }
        };
        BrpApiDtos.AangaanHuwelijkPartnerschapInOnderzoek expected = new()
        {
            Datum = true,
            Land = true,
            Plaats = true,
            DatumIngangOnderzoek = "20200101".Map()
        };
        input.Map()?.AangaanHuwelijkPartnerschap.InOnderzoek.Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapPartner()
    {
        BrpDtos.GbaPartner input = new()
        {
            Burgerservicenummer = "123456789"
        };
        BrpApiDtos.Partner expected = new()
        {
            Burgerservicenummer = "123456789"
        };
        input.Map().Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapPartnerNaam()
    {
        BrpDtos.GbaPartner input = new()
        {
            Naam = new CommonDtos.NaamBasis
            {
                Geslachtsnaam = "Jansen",
                Voornamen = "Jan Dirk"
            }
        };
        BrpApiDtos.NaamGerelateerde expected = new()
        {
            Geslachtsnaam = "Jansen",
            Voornamen = "Jan Dirk",
            Voorletters = "J.D."
        };
        input.Map()?.Naam.Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapPartnerNaamInOnderzoek()
    {
        BrpDtos.GbaPartner input = new()
        {
            InOnderzoek = new BrpDtos.InOnderzoek
            {
                AanduidingGegevensInOnderzoek = "050000",
                DatumIngangOnderzoek = "20200101"
            }
        };
        BrpApiDtos.NaamInOnderzoek expected = new()
        {
            Voornamen = true,
            AdellijkeTitelPredicaat = true,
            Voorvoegsel = true,
            Geslachtsnaam = true,
            Voorletters = true,
            DatumIngangOnderzoek = "20200101".Map()
        };
        var actual = input.Map();
        actual.Should().NotBeNull();
        actual.Naam.Should().NotBeNull();
        actual.Naam.InOnderzoek.Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapPartnerGeboorteInOnderzoek()
    {
        BrpDtos.GbaPartner input = new()
        {
            InOnderzoek = new BrpDtos.InOnderzoek
            {
                AanduidingGegevensInOnderzoek = "050000",
                DatumIngangOnderzoek = "20200101"
            }
        };
        BrpApiDtos.GeboorteInOnderzoek expected = new()
        {
            Datum = true,
            Land = true,
            Plaats = true,
            DatumIngangOnderzoek = "20200101".Map()
        };
        var actual = input.Map();
        actual.Should().NotBeNull();
        actual.Geboorte.Should().NotBeNull();
        actual.Geboorte.InOnderzoek.Should().BeEquivalentTo(expected);
    }
}
