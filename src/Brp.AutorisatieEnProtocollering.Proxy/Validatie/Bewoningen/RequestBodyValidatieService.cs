using Brp.Shared.Infrastructure.Validatie;
using Brp.Shared.Infrastructure.Validatie.Validators;
using FluentValidation.Results;
using Newtonsoft.Json.Linq;

namespace Brp.AutorisatieEnProtocollering.Proxy.Validatie.Bewoningen;

public class RequestBodyValidatieService : IRequestBodyValidator
{
    public ValidationResult ValidateRequestBody(string requestBody)
    {
        var input = JObject.Parse(requestBody);
        return input.Value<string>("type") switch
        {
            "BewoningMetPeildatum" => new BewoningMetPeildatumQueryValidator().Validate(input),
            "BewoningMetPeriode" => new BewoningMetPeriodeQueryValidator().Validate(input),
            _ => new RequestBodyValidator(new string[]
            {
                "BewoningMetPeildatum",
                "BewoningMetPeriode"
            }).Validate(input)
        };
    }
}
