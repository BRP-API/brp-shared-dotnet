using Brp.Shared.Infrastructure.Autorisatie;
using Brp.Shared.Infrastructure.Http;
using Brp.Shared.Infrastructure.Logging;
using Brp.Shared.Infrastructure.ProblemDetails;
using Brp.Shared.Infrastructure.Protocollering;
using Brp.Shared.Infrastructure.Stream;
using Brp.Shared.Infrastructure.Utils;
using Brp.Shared.Validatie;
using Brp.Shared.Validatie.Handlers;

namespace Brp.AutorisatieEnProtocollering.Proxy.Middleware;

public class AutorisatieEnProtocolleringMiddleware
{
    private readonly RequestDelegate _next;
    private readonly IServiceProvider _serviceProvider;

    public AutorisatieEnProtocolleringMiddleware(RequestDelegate next, IServiceProvider serviceProvider)
    {
        _next = next;
        _serviceProvider = serviceProvider;
    }

    public async Task Invoke(HttpContext httpContext)
    {
        if (!await httpContext.HandleNotAuthenticated())
        {
            return;
        }

        var requestBody = await httpContext.Request.ReadBodyAsync();

        if (!await httpContext.ValidateRequest(_serviceProvider, requestBody))
        {
            return;
        }

        if (!await AuthoriseRequest(httpContext, requestBody))
        {
            return;
        }

        var orgBodyStream = httpContext.Response.Body;

        using MemoryStream newBodyStream = new();
        httpContext.Response.Body = newBodyStream;

        await _next(httpContext);

        var responseBody = await newBodyStream.ReadAsync(httpContext.Response.UseGzip());

        if (await ValidateResponse(httpContext))
        {
            if (!Protocolleer(httpContext, requestBody))
            {
                responseBody = await newBodyStream.ReadAsync(httpContext.Response.UseGzip());
            }
        }
        else
        {
            responseBody = await newBodyStream.ReadAsync(httpContext.Response.UseGzip());
        }

        using var bodyStream = responseBody.ToMemoryStream(httpContext.Response.UseGzip());

        httpContext.Response.ContentLength = bodyStream.Length;
        await bodyStream.CopyToAsync(orgBodyStream);
    }

    private async Task<bool> AuthoriseRequest(HttpContext httpContext, string requestBody)
    {
        (int afnemerId, int? gemeenteCode) = GetClaimValues(httpContext);

        IAuthorisation? authorisation = _serviceProvider.GetServiceForRequestedResource<IAuthorisation>(httpContext.Request);

        return await httpContext.HandleNotAuthorized(authorisation!.Authorize(afnemerId, gemeenteCode, requestBody));
    }

    private static async Task<bool> ValidateResponse(HttpContext httpContext)
    {
        if (!await httpContext.HandleNotFound())
        {
            return false;
        }
        if (httpContext.Response.StatusCode == StatusCodes.Status500InternalServerError)
        {
            await httpContext.HandleInternalServerError();

            return false;
        }
        if (!await httpContext.HandleServiceIsAvailable())
        {
            return false;
        }

        return true;
    }

    private bool Protocolleer(HttpContext httpContext, string requestBody)
    {
        var geleverdePls = httpContext.Response.Headers["x-geleverde-pls"];
        if (string.IsNullOrWhiteSpace(geleverdePls))
        {
            return true;
        }

        httpContext.Response.Headers.Remove("x-geleverde-pls");

        (int afnemerId, int? _) = GetClaimValues(httpContext);

        IProtocollering? protocollering = _serviceProvider.GetServiceForRequestedResource<IProtocollering>(httpContext.Request);
        if (!protocollering!.Protocolleer(afnemerId, geleverdePls!, requestBody))
        {
            return false;
        }

        httpContext.Items.Add(LogConstants.Protocollering, geleverdePls.ToString().Split(','));

        return true;
    }

    private static (int afnemerId, int? gemeenteCode) GetClaimValues(HttpContext httpContext)
    {
        var isValidAfnemerId = int.TryParse(httpContext.User.Claims.FirstOrDefault(c => c.Type == "afnemerID")?.Value, out int afnemerId);

        var isValidGemeenteCode = int.TryParse(httpContext.User.Claims.FirstOrDefault(c => c.Type == "gemeenteCode")?.Value, out int gemeenteCode);

        return (isValidAfnemerId ? afnemerId : 0,
                isValidGemeenteCode ? gemeenteCode : null);
    }
}
