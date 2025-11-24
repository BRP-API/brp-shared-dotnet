using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class AdellijkeTitelPredicaatHelpers
{
    [Fact]
    public void MapNaarPredicaat_ShouldReturnEmptyString_WhenProvidedAdellijkeTitelPredicaatIsNull()
    {
        CommonDtos.AdellijkeTitelPredicaatType? input = null;

        input.MapNaarPredicaat(null).Should().Be(string.Empty);
    }

    [Theory]
    [InlineData("JH", "M", "jonkheer")]
    [InlineData("JH", "V", "jonkvrouw")]
    [InlineData("JV", "M", "jonkheer")]
    [InlineData("JV", "V", "jonkvrouw")]
    [InlineData("G", "M", "")]
    public void MapNaarPredicaat_ShouldReturnPredicaatOmschrijving_WhenProvidedCodeIsAPredicaatCode(
        string adellijkeTitelPredicaatCode,
        string geslachtsaanduidingCode,
        string expectedPredicaatOmschrijving)
    {
        var input = new CommonDtos.AdellijkeTitelPredicaatType
        {
            Code = adellijkeTitelPredicaatCode
        };
        var geslacht = new CommonDtos.Waardetabel
        {
            Code = geslachtsaanduidingCode
        };

        input.MapNaarPredicaat(geslacht).Should().Be(expectedPredicaatOmschrijving);
    }

    [Fact]
    public void MapNaarAdellijkeTitel__ShouldReturnEmptyString_WhenProvidedAdellijkeTitelIsNull()
    {
        CommonDtos.AdellijkeTitelPredicaatType? input = null;
        input.MapNaarAdellijkeTitel(null).Should().Be(string.Empty);
    }

    [Theory]
    [InlineData("B", "M", "baron")]
    [InlineData("B", "V", "barones")]
    [InlineData("BS", "M", "baron")]
    [InlineData("BS", "V", "barones")]
    [InlineData("G", "M", "graaf")]
    [InlineData("G", "V", "gravin")]
    [InlineData("GI", "M", "graaf")]
    [InlineData("GI", "V", "gravin")]
    [InlineData("H", "M", "hertog")]
    [InlineData("H", "V", "hertogin")]
    [InlineData("HI", "M", "hertog")]
    [InlineData("HI", "V", "hertogin")]
    [InlineData("M", "M", "markies")]
    [InlineData("M", "V", "markiezin")]
    [InlineData("P", "M", "prins")]
    [InlineData("P", "V", "prinses")]
    [InlineData("PS", "M", "prins")]
    [InlineData("PS", "V", "prinses")]
    [InlineData("R", "M", "ridder")]
    [InlineData("R", "V", "ridder")]
    [InlineData("JH", "M", "")]
    public void MapNaarAdellijkeTitel__ShouldReturnAdellijkeTitelOmschrijving_WhenProvidedCodeIsAnAdellijkeTitelCode(
        string adellijkeTitelPredicaatCode,
        string geslachtsaanduidingCode,
        string expectedAdellijkeTitelOmschrijving)
    {
        var input = new CommonDtos.AdellijkeTitelPredicaatType
        {
            Code = adellijkeTitelPredicaatCode
        };
        var geslacht = new CommonDtos.Waardetabel
        {
            Code = geslachtsaanduidingCode
        };
        input.MapNaarAdellijkeTitel(geslacht).Should().Be(expectedAdellijkeTitelOmschrijving);
    }
}
