using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class OuderMapper
{
    [Fact]
    public void ShouldMapOuder()
    {
        BrpDtos.GbaOuder input = new()
        {
            Burgerservicenummer = "123456789"
        };
        BrpApiDtos.Ouder expected = new()
        {
            Burgerservicenummer = "123456789",
        };
        var actual = input.Map();
        actual.Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapOuderNaam()
    {
        BrpDtos.GbaOuder input = new()
        {
            Naam = new CommonDtos.NaamBasis
            {
                Geslachtsnaam = "Jansen",
                Voornamen = "Jan Dirk"
            }
        };
        BrpApiDtos.Ouder expected = new()
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
    public void ShouldMapOuderNamMetTitel()
    {
        var input = new BrpDtos.GbaOuder
        {
            Naam = new CommonDtos.NaamBasis
            {
                AdellijkeTitelPredicaat = new CommonDtos.AdellijkeTitelPredicaatType
                {
                    Soort = CommonDtos.AdellijkeTitelPredicaatSoort.Titel,
                    Code = "P",
                    Omschrijving = "prins"
                }
            }
        };
        var expected = new BrpApiDtos.Ouder
        {
            Naam = new BrpApiDtos.NaamGerelateerde
            {
                AdellijkeTitelPredicaat = new CommonDtos.AdellijkeTitelPredicaatType
                {
                    Soort = CommonDtos.AdellijkeTitelPredicaatSoort.Titel,
                    Code = "P",
                    Omschrijving = "prins"
                }
            }
        };

        var actual = input.Map();
        actual.Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapOuderNaamInOnderzoek()
    {
        BrpDtos.GbaOuder input = new()
        {
            InOnderzoek = new BrpDtos.InOnderzoek
            {
                AanduidingGegevensInOnderzoek = "050000",
                DatumIngangOnderzoek = "20200101"
            }
        };
        BrpApiDtos.Ouder expected = new()
        {
            Naam = new BrpApiDtos.NaamGerelateerde
            {
                InOnderzoek = new BrpApiDtos.NaamInOnderzoek
                {
                    Voornamen = true,
                    AdellijkeTitelPredicaat = true,
                    Voorvoegsel = true,
                    Geslachtsnaam = true,
                    Voorletters = true,
                    DatumIngangOnderzoek = "20200101".Map()
                }
            }
        };
        var actual = input.Map();
        actual.Should().NotBeNull();
        actual.Naam.Should().NotBeNull();
        actual.Naam.InOnderzoek.Should().BeEquivalentTo(expected.Naam.InOnderzoek);
    }

    [Fact]
    public void ShouldMapOuderGeboorteInOnderzoek()
    {
        BrpDtos.GbaOuder input = new()
        {
            InOnderzoek = new BrpDtos.InOnderzoek
            {
                AanduidingGegevensInOnderzoek = "020000",
                DatumIngangOnderzoek = "20200101"
            }
        };
        BrpApiDtos.Ouder expected = new()
        {
            Geboorte = new BrpApiDtos.Geboorte
            {
                InOnderzoek = new BrpApiDtos.GeboorteInOnderzoek
                {
                    Datum = true,
                    Plaats = true,
                    Land = true,
                    DatumIngangOnderzoek = "20200101".Map()
                }
            }
        };
        var actual = input.Map();
        actual.Should().NotBeNull();
        actual.Geboorte.Should().NotBeNull();
        actual.Geboorte.InOnderzoek.Should().BeEquivalentTo(expected.Geboorte.InOnderzoek);
    }
}
