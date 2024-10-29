
using Brp.AutorisatieEnProtocollering.Proxy.Data;
using Brp.AutorisatieEnProtocollering.Proxy.Helpers;
using Brp.Shared.Infrastructure.Autorisatie;
using Brp.Shared.Infrastructure.Logging;
using Newtonsoft.Json.Linq;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie.Bewoningen;

public class AutorisatieService : AbstractAutorisatieService
{
    private readonly IHttpContextAccessor _httpContextAccessor;

    public AutorisatieService(IServiceProvider serviceProvider, IHttpContextAccessor httpContextAccessor)
        : base(serviceProvider)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    public override AuthorisationResult Authorize(int afnemerCode, int? gemeenteCode, string requestBody)
    {
        var autorisatieLog = _httpContextAccessor.HttpContext?.GetAutorisatieLog();

        if (!gemeenteCode.HasValue)
        {
            return NotAuthorized(title: "U bent niet geautoriseerd voor deze vraag.",
                                 detail: "Alleen gemeenten mogen bewoningen raadplegen.",
                                 code: "unauthorized",
                                 reason: "geen gemeente");
        }
        else
        {
            if(autorisatieLog != null)
            {
                autorisatieLog.Gemeente = $"afnemer: {afnemerCode} is gemeente '{gemeenteCode}'";
            }
        }

        var input = JObject.Parse(requestBody);

        var adressen = GetAdressen(input.WaardeAdresseerbaarObjectIdentificatieParameter()!);
        if(adressen.Any() && !adressen.Any(a => a.GemeenteCode == gemeenteCode))
        {
            return NotAuthorized(title: "U bent niet geautoriseerd voor deze vraag.",
                                 detail: "Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen.",
                                 code: "unauthorized");
        }

        return Authorized();
    }

    private IEnumerable<Data.Adres> GetAdressen(string adresseerbaarObjectIdentificatie)
    {
        using var scope = _serviceProvider.CreateScope();

        var appDbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();

        return appDbContext.Adressen.Where(a => a.AdresseerbaarObjectIdentificatie == adresseerbaarObjectIdentificatie).ToList();
    }
}
