using Brp.Shared.Infrastructure.Autorisatie;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie.Reisdocumenten
{
    public class ReisdocumentenAutorisatieService : AbstractAutorisatieService
    {
        public ReisdocumentenAutorisatieService(IServiceProvider serviceProvider)
            : base(serviceProvider)
        {
        }

        public override AuthorisationResult Authorize(int afnemerCode, int? gemeenteCode, string requestBody)
        {
            if (gemeenteCode == null)
            {
                return NotAuthorized(title: "U bent niet geautoriseerd voor deze vraag.",
                                     detail: "Je mag alleen reisdocumenten van inwoners uit de eigen gemeente raadplegen.",
                                     code: "unauthorized",
                                     reason: "geen gemeente");
            }

            return Authorized();
        }

        public override AuthorisationResult AuthorizeResponse(int afnemerCode, int? gemeenteCode, string? geleverdeGemeenteCodes)
        {
            if (string.IsNullOrWhiteSpace(geleverdeGemeenteCodes))
            {
                return NotAuthorized(title: "U bent niet geautoriseerd voor deze vraag.",
                                     detail: "Je mag alleen reisdocumenten van inwoners uit de eigen gemeente raadplegen.",
                                     code: "unauthorized",
                                     reason: $"er zijn geen gemeentecodes van houders geleverd");
            }

            foreach (var gemCode in geleverdeGemeenteCodes.Split(','))
            {
                if(int.Parse(gemCode) != gemeenteCode)
                {
                    return NotAuthorized(title: "U bent niet geautoriseerd voor deze vraag.",
                                         detail: "Je mag alleen reisdocumenten van inwoners uit de eigen gemeente raadplegen.",
                                         code: "unauthorized",
                                         reason: $"één of meerdere houders zijn ingeschreven in gemeente {gemCode}");
                }
            }
            return Authorized();
        }
    }
}
