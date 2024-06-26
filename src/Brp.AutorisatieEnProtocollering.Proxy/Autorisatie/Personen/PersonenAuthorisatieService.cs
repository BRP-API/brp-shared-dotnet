using Brp.AutorisatieEnProtocollering.Proxy.Helpers;
using Brp.Shared.Infrastructure.Autorisatie;
using Newtonsoft.Json.Linq;
using Serilog;
using static Brp.AutorisatieEnProtocollering.Proxy.Helpers.StringDictionaryHelpers;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie.Personen;

public class PersonenAuthorisatieService : AbstractAutorisatieService
{
    private readonly IDiagnosticContext _diagnosticContext;

    public PersonenAuthorisatieService(IServiceProvider serviceProvider, IDiagnosticContext diagnosticContext)
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

        if (GeenAutorisatieOfNietGeautoriseerdVoorAdHocGegevensverstrekking(autorisatie))
        {
            return NietGeautoriseerdVoorAdhocGegevensverstrekking(autorisatie, afnemerCode);
        }

        if (gemeenteCode.HasValue)
        {
            _diagnosticContext.Set("Authorized", "Afnemer is gemeente");
            return Authorized();
        }

        var input = JObject.Parse(requestBody);

        var zoekElementNrs = input.BepaalElementNrVanZoekParameters(Constanten.FieldElementNrDictionary);

        var geautoriseerdeElementNrs = autorisatie!.RubrieknummerAdHoc!.Split(' ');

        var nietGeautoriseerdQueryElementNrs = BepaalNietGeautoriseerdeElementNamen(geautoriseerdeElementNrs, zoekElementNrs);
        if (nietGeautoriseerdQueryElementNrs.Any())
        {
            return NietGeautoriseerdVoorParameters(nietGeautoriseerdQueryElementNrs);
        }

        var fieldElementNrs = BepaalElementNrVanFields(input);

        var nietGeautoriseerdFieldNames = BepaalNietGeautoriseerdeElementNamen(geautoriseerdeElementNrs, fieldElementNrs);
        if (nietGeautoriseerdFieldNames.Any())
        {
            return NietGeautoriseerdVoorFields(nietGeautoriseerdFieldNames, afnemerCode);
        }

        return Authorized();
    }

    private static string BepaalKeyVoor(string gevraagdField, string zoekType)
    {
        return zoekType != "RaadpleegMetBurgerservicenummer"
                ? $"{gevraagdField}-beperkt"
                : gevraagdField;
    }

    private static IEnumerable<(string Name, string[] Value)> BepaalElementNrVanFields(JObject input)
    {
        var zoekType = input.WaardeTypeParameter();
        var gevraagdeFields = input.WaardeFieldsParameter();

        return gevraagdeFields.ToKeyStringArray(Constanten.FieldElementNrDictionary, zoekType!, BepaalKeyVoor);
    }
}
