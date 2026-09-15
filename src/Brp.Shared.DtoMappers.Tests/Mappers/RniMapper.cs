using Brp.Shared.DtoMappers.CommonDtos;
using Brp.Shared.DtoMappers.Mappers;
using FluentAssertions;

namespace Brp.Shared.DtoMappers.Tests.Mappers;

public class RniMapper
{
    [Fact]
    public void ShouldMapRniDeelnemer()
    {
        RniDeelnemer input = new()
        {
            Categorie = "cat-01",
            OmschrijvingVerdrag = "verdrag",
            Deelnemer = new Waardetabel
            {
                Code = "0001",
                Omschrijving = "deelnemer"
            }
        };

        RniDeelnemer expected = new()
        {
            Categorie = "cat-01",
            OmschrijvingVerdrag = "verdrag",
            Deelnemer = new Waardetabel
            {
                Code = "0001",
                Omschrijving = "deelnemer"
            }
        };

        input.Map().Should().BeEquivalentTo(expected);
    }

    [Fact]
    public void ShouldMapRniDeelnemerCollection()
    {
        ICollection<RniDeelnemer> input =
        [
            new RniDeelnemer
            {
                Categorie = "cat-01",
                OmschrijvingVerdrag = "verdrag-1",
                Deelnemer = new Waardetabel
                {
                    Code = "0001",
                    Omschrijving = "deelnemer-1"
                }
            },
            new RniDeelnemer
            {
                Categorie = "cat-02",
                OmschrijvingVerdrag = "verdrag-2",
                Deelnemer = new Waardetabel
                {
                    Code = "0002",
                    Omschrijving = "deelnemer-2"
                }
            }
        ];

        var mapped = input.Map();

        mapped.Should().HaveCount(2);
        mapped.Should().BeEquivalentTo(input);
        mapped.Should().NotBeSameAs(input);
    }
}
