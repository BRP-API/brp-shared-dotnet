using Brp.Shared.Infrastructure.Autorisatie;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie.Reisdocumenten
{
    public class AutorisatieService : AbstractAutorisatieService
    {
        public AutorisatieService(IServiceProvider serviceProvider, IHttpContextAccessor httpContextAccessor)
            : base(serviceProvider, httpContextAccessor)
        {
        }

        public override AuthorisationResult Authorize(int afnemerCode, int? gemeenteCode, string requestBody)
        {
            if (!AfnemerIsGemeente(afnemerCode, gemeenteCode))
            {
                return NotAuthorized(title: "U bent niet geautoriseerd voor deze vraag.",
                                     detail: "Alleen gemeenten mogen reisdocumenten raadplegen.",
                                     code: "unauthorized",
                                     reason: "geen gemeente");
            }

            return Authorized();
        }
    }
}
