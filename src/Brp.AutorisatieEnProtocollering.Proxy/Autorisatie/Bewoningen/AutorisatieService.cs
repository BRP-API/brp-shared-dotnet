
using Brp.AutorisatieEnProtocollering.Proxy.Data;
using Brp.AutorisatieEnProtocollering.Proxy.Helpers;
using Brp.Shared.Infrastructure.Autorisatie;
using Newtonsoft.Json.Linq;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie.Bewoningen;

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
            var input = JObject.Parse(requestBody);

            var adressen = GetAdressen(input.WaardeAdresseerbaarObjectIdentificatieParameter()!);
            if (adressen.Any() && !AdressenLiggenInGemeente(adressen, gemeenteCode))
            {
                return NotAuthorized(title: "U bent niet geautoriseerd voor deze vraag.",
                                     detail: "Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen.",
                                     code: "unauthorized");
            }
        }
        else
        {
            var autorisatie = GetActueleAutorisatieFor(afnemerCode);

            if (GeenAutorisatieOfNietGeautoriseerdVoorAdHocGegevensverstrekking(autorisatie))
            {
                return NietGeautoriseerdVoorAdhocGegevensverstrekking(autorisatie, afnemerCode);
            }

            if (!autorisatie!.RubrieknummerAdHoc!.Contains("AXBW01"))
            {
                return NotAuthorized(title: "U bent niet geautoriseerd voor deze vraag.",
                                     detail: "Alleen gemeenten mogen bewoningen raadplegen.",
                                     code: "unauthorized",
                                     reason: "geen gemeente");
            }
        }

        return Authorized();
    }

    private IEnumerable<Data.Adres> GetAdressen(string adresseerbaarObjectIdentificatie)
    {
        using var scope = _serviceProvider.CreateScope();

        var appDbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();

        return appDbContext.Adressen.Where(a => a.AdresseerbaarObjectIdentificatie == adresseerbaarObjectIdentificatie).ToList();
    }

    private static bool AdressenLiggenInGemeente(IEnumerable<Data.Adres> adressen, int? gemeenteCode)
    {
        return adressen.Any(a => a.GemeenteCode == gemeenteCode);
    }
}
