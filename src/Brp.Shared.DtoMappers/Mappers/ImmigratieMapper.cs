namespace Brp.Shared.DtoMappers.Mappers;

public static class ImmigratieMapper
{
    public static BrpApiDtos.Immigratie? Map(this BrpDtos.GbaImmigratie? immigratie, BrpDtos.GbaVerblijfplaats? verblijfplaats)
    {
        return immigratie != null || verblijfplaats?.InOnderzoek != null
            ? new BrpApiDtos.Immigratie
            {
                DatumVestigingInNederland = immigratie?.DatumVestigingInNederland?.Map(),
                LandVanwaarIngeschreven = immigratie?.LandVanwaarIngeschreven == null || immigratie.LandVanwaarIngeschreven.Code == "0000"
                    ? null
                    : new CommonDtos.Waardetabel
                    {
                        Code = immigratie.LandVanwaarIngeschreven.Code,
                        Omschrijving = immigratie.LandVanwaarIngeschreven.Omschrijving
                    },
                IndicatieVestigingVanuitBuitenland = !string.IsNullOrWhiteSpace(immigratie?.DatumVestigingInNederland) ? true : null,
                VanuitVerblijfplaatsOnbekend = immigratie?.LandVanwaarIngeschreven?.Code == "0000" ? true : null,
                InOnderzoek = verblijfplaats?.InOnderzoek?.ImmigratieInOnderzoek()
            }
            : null;
    }

    private static BrpApiDtos.ImmigratieInOnderzoek? ImmigratieInOnderzoek(this BrpDtos.InOnderzoek? source)
    {
        if (source == null)
        {
            return null;
        }

        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" or
            "081400" => new BrpApiDtos.ImmigratieInOnderzoek
            {
                LandVanwaarIngeschreven = true,
                DatumVestigingInNederland = true,
                IndicatieVestigingVanuitBuitenland = true,
                VanuitVerblijfplaatsOnbekend = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek.Map()
            },
            "081410" => new BrpApiDtos.ImmigratieInOnderzoek
            {
                LandVanwaarIngeschreven = true,
                VanuitVerblijfplaatsOnbekend = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek.Map()
            },
            "081420" => new BrpApiDtos.ImmigratieInOnderzoek
            {
                DatumVestigingInNederland = true,
                IndicatieVestigingVanuitBuitenland = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek.Map()
            },
            _ => null,
        };
    }
}
