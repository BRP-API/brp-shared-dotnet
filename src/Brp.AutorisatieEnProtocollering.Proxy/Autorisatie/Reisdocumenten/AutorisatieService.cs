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
            if (AfnemerIsGemeente(afnemerCode, gemeenteCode) || AfnemerIsKmar(afnemerCode))
            {
                return Authorized();
            }

            return NotAuthorized(title: "U bent niet geautoriseerd voor deze vraag.",
                                    detail: "Alleen gemeenten mogen reisdocumenten raadplegen.",
                                    code: "unauthorized",
                                    reason: "geen gemeente");
        }

        private bool AfnemerIsKmar(int afnemerCode)
        {
            const int kmarAfnemerCode = 720402;

            if (afnemerCode == kmarAfnemerCode)
            {
                if (AutorisatieLog != null)
                {
                    AutorisatieLog.Gemeente = $"afnemer: {afnemerCode} is KMAR";
                }

                return true;
            }

            return false;
        }
    }
}
