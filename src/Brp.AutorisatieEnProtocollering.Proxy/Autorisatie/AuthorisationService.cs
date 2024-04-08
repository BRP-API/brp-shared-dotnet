using Brp.AutorisatieEnProtocollering.Proxy.Data;
using Brp.AutorisatieEnProtocollering.Proxy.Helpers;
using Brp.Shared.Infrastructure.Autorisatie;
using Microsoft.FeatureManagement;
using Newtonsoft.Json.Linq;
using Serilog;
using System.Text.RegularExpressions;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie;

public class AuthorisationService : IAuthorisation
{
    private readonly IServiceProvider _serviceProvider;
    private readonly IDiagnosticContext _diagnosticContext;

    public AuthorisationService(IServiceProvider serviceProvider, IDiagnosticContext diagnosticContext)
    {
        _serviceProvider = serviceProvider;
        _diagnosticContext = diagnosticContext;
    }

    public AuthorisationResult Authorize(int afnemerCode, int? gemeenteCode, string requestBody)
    {
        using var scope = _serviceProvider.CreateScope();

        var appDbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();
        var featureManager = scope.ServiceProvider.GetRequiredService<IFeatureManager>();

        var gebruikMeestRecenteAutorisatie = featureManager.IsEnabledAsync("gebruikMeestRecenteAutorisatie").Result;

        var autorisatie = appDbContext.GetActueleAutorisatieFor(afnemerCode, gebruikMeestRecenteAutorisatie);
        if(autorisatie != null)
        {
            _diagnosticContext.Set("Autorisatie", autorisatie, true);
        }

        if (GeenAutorisatieOfNietGeautoriseerdVoorAdHocGegevensverstrekking(autorisatie))
        {
            return NotAuthorized(title: "U bent niet geautoriseerd voor het gebruik van deze API.",
                                 detail: "Niet geautoriseerd voor ad hoc bevragingen.",
                                 code: "unauthorized",
                                 reason: autorisatie != null
                                    ? $"Vereiste ad_hoc_medium: A of N. Werkelijk: {autorisatie.AdHocMedium}. Afnemer code: {autorisatie.AfnemerCode}"
                                    : $"Geen\\Verlopen autorisatie gevonden voor Afnemer code {afnemerCode}");
        }

        var input = JObject.Parse(requestBody);

        if (gemeenteCode.HasValue)
        {
            _diagnosticContext.Set("Authorized", "Afnemer is gemeente");
            return Authorized();
        }

        var zoekElementNrs = input.BepaalElementNrVanZoekParameters();

        var geautoriseerdeElementNrs = autorisatie!.RubrieknummerAdHoc!.Split(' ');

        var nietGeautoriseerdQueryElementNrs = BepaalNietGeautoriseerdeElementNamen(geautoriseerdeElementNrs, zoekElementNrs);
        if (nietGeautoriseerdQueryElementNrs.Any())
        {
            return NotAuthorized(title: "U bent niet geautoriseerd voor de gebruikte parameter(s).",
                                 detail: $"U bent niet geautoriseerd voor het gebruik van parameter(s): {string.Join(", ", nietGeautoriseerdQueryElementNrs.OrderBy(x => x))}.",
                                 code: "unauthorizedParameter");
        }

        var fieldElementNrs = BepaalElementNrVanFields(input);

        var nietGeautoriseerdFieldNames = BepaalNietGeautoriseerdeElementNamen(geautoriseerdeElementNrs, fieldElementNrs);
        if (nietGeautoriseerdFieldNames.Any())
        {
            return NotAuthorized(title: "U bent niet geautoriseerd voor één of meerdere opgegeven field waarden.",
                                 code: "unauthorizedField",
                                 reason: $"afnemer '{afnemerCode}' is niet geautoriseerd voor fields {string.Join(", ", nietGeautoriseerdFieldNames.OrderBy(x => x))}");
        }

        return Authorized();
    }

    private static AuthorisationResult NotAuthorized(string? title = null, string? detail = null, string? code = null, string? reason = null)
    {
        return new AuthorisationResult(
            false,
            new List<AuthorisationFailure>
            {
                new()
                {
                    Title = title,
                    Detail = detail,
                    Code = code,
                    Reason = reason
                }
            }
        );
    }

    private static AuthorisationResult Authorized()
    {
        return new AuthorisationResult(
            true,
            new List<AuthorisationFailure>()
        );
    }

    private static bool GeenAutorisatieOfNietGeautoriseerdVoorAdHocGegevensverstrekking(Data.Autorisatie? autorisatie)
    {
        return autorisatie == null || !new[] { 'A', 'N' }.Contains(autorisatie.AdHocMedium);
    }

    private static IEnumerable<(string Name, string[] Value)> BepaalElementNrVanFields(JObject input)
    {
        var retval = new List<(string Name, string[] Value)>();

        var zoekType = input.Value<string>("type");
        var gevraagdeFields = from field in input.Value<JArray>("fields")!
                              let v = field.Value<string>()
                              where v != null
                              select v;

        foreach (var gevraagdField in gevraagdeFields)
        {
            var key = zoekType != "RaadpleegMetBurgerservicenummer"
                ? $"{gevraagdField}-beperkt"
                : gevraagdField;

            var fieldElementNrs = Constanten.FieldElementNrDictionary.ContainsKey(key)
                ? Constanten.FieldElementNrDictionary[key]
                : Constanten.FieldElementNrDictionary[gevraagdField];

            retval.Add(new(gevraagdField, fieldElementNrs.Split(' ')));
        }
        return retval;
    }

    private static IEnumerable<string> BepaalNietGeautoriseerdeElementNamen(IEnumerable<string> geautoriseerdeElementen,
                                                                            IEnumerable<(string Name, string[] Value)> gevraagdeElementen)
    {
        var retval = new List<string>();

        foreach (var (Name, Value) in gevraagdeElementen)
        {
            foreach (var gevraagdElementNr in Value)
            {
                if (gevraagdElementNr == string.Empty && Name == "ouders.ouderAanduiding")
                {
                    if (!IsGeautoriseerdVoorOuderAanduidingVraag(geautoriseerdeElementen))
                    {
                        retval.Add(Name);
                    }
                }
                else if (!geautoriseerdeElementen.Any(x => gevraagdElementNr == x.PrefixWithZero()))
                {
                    retval.Add(Name);
                }
            }
        }

        return retval.Distinct();
    }

    private static bool IsGeautoriseerdVoorOuderAanduidingVraag(IEnumerable<string> geautoriseerdeElementen)
    {
        var ouder1Regex = new Regex(@"^(02(01|02|03|04|62)\d{2}|PAOU01)$");
        var ouder2Regex = new Regex(@"^(03(01|02|03|04|62)\d{2}|PAOU01)$");

        var isGeautoriseerdVoorOuder1 = false;
        var isGeautoriseerdVoorOuder2 = false;

        foreach (var elementNr in geautoriseerdeElementen)
        {
            var prefixedElementNr = elementNr.PrefixWithZero();
            if (ouder1Regex.IsMatch(prefixedElementNr))
            {
                isGeautoriseerdVoorOuder1 = true;
            }
            if (ouder2Regex.IsMatch(prefixedElementNr))
            {
                isGeautoriseerdVoorOuder2 = true;
            }
        }

        return isGeautoriseerdVoorOuder1 && isGeautoriseerdVoorOuder2;
    }

}

internal static class AppDbContextExtensions
{
    internal static Data.Autorisatie? GetActueleAutorisatieFor(this AppDbContext appDbContext, int afnemerCode, bool gebruikMeestRecenteAutorisatie)
    {

        return gebruikMeestRecenteAutorisatie
            ? appDbContext.Autorisaties
                          .Where(a => a.AfnemerCode == afnemerCode)
                          .OrderByDescending(a => a.TabelRegelStartDatum)
                          .FirstOrDefault()
            : appDbContext.Autorisaties
                          .FirstOrDefault(a => a.AfnemerCode == afnemerCode &&
                                               a.TabelRegelStartDatum <= Vandaag() &&
                                               (a.TabelRegelEindDatum == null || a.TabelRegelEindDatum > Vandaag()));
    }

    private static long Vandaag()
    {
        return int.Parse(DateTime.Today.ToString("yyyyMMdd"));
    }
}

internal static class AutorisationServiceHelpers
{
    public static string PrefixWithZero(this string str)
    {
        return str.Length == 6
            ? str
            : $"0{str}";
    }
}
