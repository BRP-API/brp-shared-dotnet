using Microsoft.Extensions.Options;
using Brp.AutorisatieEnProtocollering.Proxy.Settings;
using Brp.Shared.Infrastructure.Autorisatie;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie.Reisdocumenten
{
    public class AutorisatieService : AbstractAutorisatieService
    {
        private readonly int _kmarAfnemerCode = 0;

        public AutorisatieService(IServiceProvider serviceProvider, IHttpContextAccessor httpContextAccessor, IOptions<ReisdocumentenAutorisatieConfig> config)
            : base(serviceProvider, httpContextAccessor)
        {
            _kmarAfnemerCode = int.TryParse(config.Value.KmarAfnemerCode, out var code) ? code : 0;
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
            if (afnemerCode == _kmarAfnemerCode)
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
