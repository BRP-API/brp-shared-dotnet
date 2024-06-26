using Brp.AutorisatieEnProtocollering.Proxy.Helpers;
using Brp.Shared.Infrastructure.Autorisatie;
using Serilog;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie.Historie;

public class AutorisatieService : AbstractAutorisatieService
{
    private readonly IDiagnosticContext _diagnosticContext;

    public AutorisatieService(IServiceProvider serviceProvider, IDiagnosticContext diagnosticContext)
        : base(serviceProvider)
    {
        _diagnosticContext = diagnosticContext;
    }

    public override AuthorisationResult Authorize(int afnemerCode, int? gemeenteCode, string requestBody)
    {
        var autorisatie = GetActueleAutorisatieFor(afnemerCode);
        if (autorisatie != null)
        {
            _diagnosticContext.Set("Autorisatie", autorisatie, true);
        }

        if (gemeenteCode.HasValue)
        {
            _diagnosticContext.Set("Authorized", "Afnemer is gemeente");
            return Authorized();
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

    private string BepaalKeyVoor(string field, string zoekType) => field;
}
