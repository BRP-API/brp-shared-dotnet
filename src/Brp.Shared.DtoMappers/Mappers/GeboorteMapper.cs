using Brp.Shared.DtoMappers.BrpApiDtos;

namespace Brp.Shared.DtoMappers.Mappers;

public static class GeboorteMapper
{
    public static Geboorte? Map(this BrpDtos.GbaGeboorte? geboorte, BrpDtos.InOnderzoek? inOnderzoek)
    {
        return geboorte == null && inOnderzoek == null
            ? null
            : new Geboorte
            {
                Datum = geboorte?.Datum?.Map(),
                Plaats = geboorte?.Plaats?.Code == "0000"
                    ? null
                    : geboorte?.Plaats?.Map(),
                Land = geboorte?.Land?.Code == "0000"
                    ? null
                    : geboorte?.Land?.Map(),
                InOnderzoek = inOnderzoek.MapGeboorteInOnderzoek()

            };
    }

    private static GeboorteInOnderzoek? MapGeboorteInOnderzoek(this BrpDtos.InOnderzoek? source)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "010000" or
            "010300" or
            "020000" or
            "020300" or
            "030000" or
            "030300" or
            "050000" or
            "050300" or
            "090000" or
            "090300" => new GeboorteInOnderzoek
            {
                Datum = true,
                Land = true,
                Plaats = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek.Map()
            },
            "010310" or
            "020310" or
            "030310" or
            "050310" or
            "090310" => new GeboorteInOnderzoek
            {
                Datum = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek.Map()
            },
            "010320" or
            "020320" or
            "030320" or
            "050320" or
            "090320" => new GeboorteInOnderzoek
            {
                Plaats = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek.Map()
            },
            "010330" or
            "020330" or
            "030330" or
            "050330" or
            "090330" => new GeboorteInOnderzoek
            {
                Land = true,
                DatumIngangOnderzoek = source.DatumIngangOnderzoek.Map()
            },
            _ => null,
        };
    }
}
