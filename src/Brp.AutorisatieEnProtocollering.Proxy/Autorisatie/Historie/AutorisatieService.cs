using Brp.AutorisatieEnProtocollering.Proxy.Helpers;
using Brp.Shared.Infrastructure.Autorisatie;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie.Historie;

public class AutorisatieService : AbstractAutorisatieService
{
    public AutorisatieService(IServiceProvider serviceProvider, IHttpContextAccessor httpContextAccessor)
        : base(serviceProvider, httpContextAccessor)
    {
    }

    public override AuthorisationResult Authorize(int afnemerCode, int? gemeenteCode, string requestBody)
    {
        if (AfnemerIsGemeente(afnemerCode, gemeenteCode))
        {
            return Authorized();
        }

        var autorisatie = GetActueleAutorisatieFor(afnemerCode);

        if (GeenAutorisatieOfNietGeautoriseerdVoorAdHocGegevensverstrekking(autorisatie))
        {
            return NietGeautoriseerdVoorAdhocGegevensverstrekking(autorisatie, afnemerCode);
        }

        var geautoriseerdeElementNrs = autorisatie!.RubrieknummerAdHoc!.Split(' ');

        var fieldElementNrs = new[] { "verblijfplaatshistorie" }.ToKeyStringArray(Constanten.FieldElementNrDictionary, "", BepaalKeyVoor);

        var nietGeautoriseerdFieldNames = BepaalNietGeautoriseerdeElementNamen(geautoriseerdeElementNrs, fieldElementNrs);
        if (nietGeautoriseerdFieldNames.Any())
        {
            return NietGeautoriseerdVoorEndpoint("verblijfplaatshistorie", nietGeautoriseerdFieldNames, afnemerCode);
        }

        return Authorized();
    }

    private static string BepaalKeyVoor(string field, string zoekType) => field;
}
