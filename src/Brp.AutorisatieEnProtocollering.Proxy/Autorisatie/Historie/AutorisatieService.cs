
using Brp.Shared.Infrastructure.Autorisatie;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie.Historie;

public class AutorisatieService : AbstractAutorisatieService
{
    public AutorisatieService(IServiceProvider serviceProvider)
        : base(serviceProvider)
    {
    }

    public override AuthorisationResult Authorize(int afnemerCode, int? gemeenteCode, string requestBody)
    {
        return Authorized();
    }
}
