namespace Brp.Shared.DtoMappers.Mappers;

public static class EuropeesKiesrechtMapper
{
    public static BrpApiDtos.EuropeesKiesrecht? Map(this BrpDtos.GbaEuropeesKiesrecht? europeesKiesrecht)
    {
        return europeesKiesrecht == null
            ? null
            : new BrpApiDtos.EuropeesKiesrecht
            {
                Aanduiding = europeesKiesrecht.Aanduiding == null
                 ? null
                 : new CommonDtos.Waardetabel
                 {
                     Code = europeesKiesrecht.Aanduiding.Code,
                     Omschrijving = europeesKiesrecht.Aanduiding.Omschrijving
                 },
                EinddatumUitsluiting = europeesKiesrecht.EinddatumUitsluiting?.Map()
            };
    }
}
