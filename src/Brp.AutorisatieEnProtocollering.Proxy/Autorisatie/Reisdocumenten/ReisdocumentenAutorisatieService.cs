using Brp.Shared.Infrastructure.Autorisatie;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Serilog;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie.Reisdocumenten
{
    public class ReisdocumentenAutorisatieService : AbstractAutorisatieService
    {
        private readonly IDiagnosticContext _diagnosticContext;

        public ReisdocumentenAutorisatieService(IServiceProvider serviceProvider, IDiagnosticContext diagnosticContext)
            : base(serviceProvider)
        {
            _diagnosticContext = diagnosticContext;
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

        public override AuthorisationResult AuthorizeResponse(int afnemerCode, int? gemeenteCode, string responseBody)
        {
            try
            {
                var input = JObject.Parse(responseBody);

                var reisdocumenten = input?.Value<JArray>("reisdocumenten");
                if(reisdocumenten == null)
                {
                    return Authorized();
                }

                foreach (var reisdocument in reisdocumenten)
                {
                    var houder = reisdocument?.Value<JToken>("houder");
                    var gemeenteVanInschrijving = houder?.Value<JToken>("gemeenteVanInschrijving");
                    var gemeenteVanInschrijvingCode = gemeenteVanInschrijving?.Value<int?>("code");
                    if (!gemeenteVanInschrijvingCode.HasValue ||
                        gemeenteVanInschrijvingCode != gemeenteCode)
                    {
                        return NotAuthorized(title: "U bent niet geautoriseerd voor deze vraag.",
                                             detail: "Je mag alleen reisdocumenten van inwoners uit de eigen gemeente raadplegen.",
                                             code: "unauthorized",
                                             reason: $"houder is ingeschreven in gemeente {gemeenteVanInschrijvingCode}");
                    }
                }

                return Authorized();
            }
            catch (JsonReaderException ex)
            {
                _diagnosticContext.SetException(ex);
            }

            return NotAuthorized();
        }
    }
}
