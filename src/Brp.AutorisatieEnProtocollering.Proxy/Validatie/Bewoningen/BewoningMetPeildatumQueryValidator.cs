using Brp.Shared.Infrastructure.Validatie.Validators;
using FluentValidation;
using Newtonsoft.Json.Linq;

namespace Brp.AutorisatieEnProtocollering.Proxy.Validatie.Bewoningen;

public class BewoningMetPeildatumQueryValidator : AbstractValidator<JObject>
{
    public BewoningMetPeildatumQueryValidator()
    {
        Include(new NietGespecificeerdeParametersValidator(GespecificeerdeParameterNamen));
        Include(new AdresseerbaarObjectIdentificatieVerplichtValidator());
        Include(new DatumValidator("peildatum", true));
    }

    private readonly List<string> GespecificeerdeParameterNamen = new()
    {
        "type",
        "adresseerbaarObjectIdentificatie",
        "peildatum"
    };
}
