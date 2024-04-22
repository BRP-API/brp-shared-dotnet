using Brp.Shared.Infrastructure.Autorisatie;
using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.ProblemDetails;
using Brp.Shared.Infrastructure.Protocollering;
using Brp.Shared.Infrastructure.Validatie;
using Serilog;

namespace Brp.AutorisatieEnProtocollering.Proxy.Validatie;

public class RequestValidatieMiddleware
{
    private readonly RequestDelegate _next;
    private readonly IDiagnosticContext _diagnosticContext;
    private readonly IRequestBodyValidator _requestBodyValidator;
    private readonly IAuthorisation _authorisation;
    private readonly IProtocollering _protocollering;

    public RequestValidatieMiddleware(RequestDelegate next, IDiagnosticContext diagnosticContext, IRequestBodyValidator requestBodyValidator, IAuthorisation authorisation, IProtocollering protocollering)
    {
        _next = next;
        _diagnosticContext = diagnosticContext;
        _authorisation = authorisation;
        _protocollering = protocollering;
        _requestBodyValidator = requestBodyValidator;
    }

    public async Task Invoke(HttpContext httpContext)
    {
        if (!await httpContext.HandleNotAuthenticated(_diagnosticContext))
        {
            return;
        }

        if (!await httpContext.HandleRequestMethodIsAllowed())
        {
            return;
        }

        if (!await httpContext.HandleRequestAcceptIsSupported())
        {
            return;
        }

        if (!await httpContext.HandleMediaTypeIsSupported())
        {
            return;
        }

        var requestBody = await httpContext.Request.ReadBodyAsync();

        if (!await httpContext.HandleRequestBodyIsValidJson(requestBody, _requestBodyValidator, _diagnosticContext))
        {
            return;
        }

        (int afnemerId, int? gemeenteCode) = GetClaimValues(httpContext);

        var result = _authorisation.Authorize(afnemerId, gemeenteCode, requestBody);
        if (!result.IsValid)
        {
            var reason = result.Errors[0]?.Reason;
            if (!string.IsNullOrWhiteSpace(reason))
            {
                _diagnosticContext.Set("NotAuthorized", reason);
            }

            var problemDetails = httpContext.Request.CreateProblemDetailsFor(result);

            await httpContext.Response.WriteProblemDetailsAsync(problemDetails);

            return;
        }

        await _next(httpContext);

        if(!await httpContext.HandleNotFound())
        {
            return;
        }

        var geleverdePls = httpContext.Response.Headers["x-geleverde-pls"];
        if (!string.IsNullOrWhiteSpace(geleverdePls))
        {
            _protocollering.Protocolleer(afnemerId, geleverdePls!, requestBody);

            _diagnosticContext.Set("Protocollering voor pl's", geleverdePls.ToString().Split(','));

            httpContext.Response.Headers.Remove("x-geleverde-pls");
        }
    }

    private static (int afnemerId, int? gemeenteCode) GetClaimValues(HttpContext httpContext)
    {
        var isValidAfnemerId = int.TryParse(httpContext.User.Claims.FirstOrDefault(c => c.Type == "afnemerID")?.Value, out int afnemerId);

        var isValidGemeenteCode = int.TryParse(httpContext.User.Claims.FirstOrDefault(c => c.Type == "gemeenteCode")?.Value, out int gemeenteCode);

        return (isValidAfnemerId ? afnemerId : 0,
                isValidGemeenteCode ? gemeenteCode : null);
    }
}
