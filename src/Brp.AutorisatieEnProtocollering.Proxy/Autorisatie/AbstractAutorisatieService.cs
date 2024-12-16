using Brp.AutorisatieEnProtocollering.Proxy.Data;
using Brp.Shared.Infrastructure.Autorisatie;
using Brp.Shared.Infrastructure.Logging;
using Microsoft.FeatureManagement;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie;

public abstract class AbstractAutorisatieService : IAuthorisation
{
    protected readonly IServiceProvider _serviceProvider;
    protected readonly IHttpContextAccessor _httpContextAccessor;
    private AutorisatieLog? _autorisatieLog;
    protected AutorisatieLog? AutorisatieLog => _autorisatieLog ??= _httpContextAccessor.HttpContext?.GetAutorisatieLog();

    protected AbstractAutorisatieService(IServiceProvider serviceProvider, IHttpContextAccessor httpContextAccessor)
    {
        _serviceProvider = serviceProvider;
        _httpContextAccessor = httpContextAccessor;
    }

    public virtual AuthorisationResult Authorize(int afnemerCode, int? gemeenteCode, string requestBody) => throw new NotImplementedException();

    protected bool AfnemerIsGemeente(int afnemerCode, int? gemeenteCode)
    {
        if (!gemeenteCode.HasValue)
        {
            return false;
        }

        if(AutorisatieLog != null)
        {
            AutorisatieLog.Gemeente = $"afnemer: {afnemerCode} is gemeente '{gemeenteCode}'";
        }

        return true;
    }

    protected Data.Autorisatie? GetActueleAutorisatieFor(int afnemerCode)
    {
        var featureManager = _serviceProvider.GetRequiredService<IFeatureManager>();

        var gebruikMeestRecenteAutorisatie = featureManager.IsEnabledAsync("gebruikMeestRecenteAutorisatie").Result;

        using var scope = _serviceProvider.CreateScope();

        var appDbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();

        var retval = gebruikMeestRecenteAutorisatie
            ? appDbContext.Autorisaties
                          .Where(a => a.AfnemerCode == afnemerCode)
                          .OrderByDescending(a => a.TabelRegelStartDatum)
                          .FirstOrDefault()
            : appDbContext.Autorisaties
                          .FirstOrDefault(a => a.AfnemerCode == afnemerCode &&
                                               a.TabelRegelStartDatum <= Vandaag() &&
                                               (a.TabelRegelEindDatum == null || a.TabelRegelEindDatum > Vandaag()));

        if(AutorisatieLog != null && retval != null)
        {
            AutorisatieLog.Regel = retval;
        }

        return retval;
    }

    private static long Vandaag()
    {
        return int.Parse(DateTime.Today.ToString("yyyyMMdd"));
    }

    protected virtual IEnumerable<string> BepaalNietGeautoriseerdeElementNamen(IEnumerable<string> geautoriseerdeElementen,
                                                                              IEnumerable<(string Name, string[] Value)> gevraagdeElementen)
    {
        var retval = new List<string>();

        foreach (var (Name, Value) in gevraagdeElementen)
        {
            foreach (var gevraagdElementNr in Value)
            {
                if (!geautoriseerdeElementen.Any(x => gevraagdElementNr == x.PrefixWithZero()))
                {
                    retval.Add(Name);
                }
            }
        }

        return retval.Distinct();
    }

    protected static bool GeenAutorisatieOfNietGeautoriseerdVoorAdHocGegevensverstrekking(Data.Autorisatie? autorisatie)
    {
        return autorisatie == null || !new[] { 'A', 'N' }.Contains(autorisatie.AdHocMedium);
    }

    protected static AuthorisationResult NietGeautoriseerdVoorAdhocGegevensverstrekking(Data.Autorisatie? autorisatie, int afnemerCode) =>
        NotAuthorized(
            title: "U bent niet geautoriseerd voor het gebruik van deze API.",
            detail: "Niet geautoriseerd voor ad hoc bevragingen.",
            code: "unauthorized",
            reason: autorisatie != null
                ? $"Vereiste ad_hoc_medium: A of N. Werkelijk: {autorisatie.AdHocMedium}. Afnemer code: {autorisatie.AfnemerCode}"
                : $"Geen\\Verlopen autorisatie gevonden voor Afnemer code {afnemerCode}");

    protected static AuthorisationResult NietGeautoriseerdVoorEndpoint(string endpoint, IEnumerable<string> nietGeautoriseerdFieldNames, int afnemerCode) =>
        NotAuthorized(title: "U bent niet geautoriseerd voor het gebruik van deze API.",
                      code: "unauthorized",
                      detail: $"Niet geautoriseerd voor {endpoint}.",
                      reason: $"afnemer '{afnemerCode}' is niet geautoriseerd voor {string.Join(", ", nietGeautoriseerdFieldNames.OrderBy(x => x))}");

    protected static AuthorisationResult NietGeautoriseerdVoorFields(IEnumerable<string> nietGeautoriseerdFieldNames, int afnemerCode) =>
        NotAuthorized(title: "U bent niet geautoriseerd voor één of meerdere opgegeven field waarden.",
                      detail: $"U bent niet geautoriseerd om de volgende gegevens op te vragen met fields: {string.Join(", ", nietGeautoriseerdFieldNames.OrderBy(x => x))}",
                      code: "unauthorizedField",
                      reason: $"afnemer '{afnemerCode}' is niet geautoriseerd voor fields {string.Join(", ", nietGeautoriseerdFieldNames.OrderBy(x => x))}");

    protected static AuthorisationResult NietGeautoriseerdVoorParameters(IEnumerable<string> nietGeautoriseerdQueryElementNrs) =>
        NotAuthorized(title: "U bent niet geautoriseerd voor de gebruikte parameter(s).",
                      detail: $"U bent niet geautoriseerd voor het gebruik van parameter(s): {string.Join(", ", nietGeautoriseerdQueryElementNrs.OrderBy(x => x))}.",
                      code: "unauthorizedParameter");

    protected static AuthorisationResult NotAuthorized(string? title = null, string? detail = null, string? code = null, string? reason = null)
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

    protected static AuthorisationResult Authorized()
    {
        return new AuthorisationResult(
            true,
            new List<AuthorisationFailure>()
        );
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
