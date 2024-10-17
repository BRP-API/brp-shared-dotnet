using Newtonsoft.Json.Linq;

namespace Brp.Referentie.Api;

public static class Helpers
{
    public static async Task<int> AddCustomResponseHeaders(this HttpResponse response, IWebHostEnvironment environment)
    {
        var retval = StatusCodes.Status200OK;

        var path = Path.Combine(environment.ContentRootPath, "Data", "response-headers.json");
        if (File.Exists(path))
        {
            var data = await File.ReadAllTextAsync(path);

            var responseHeaders = JObject.Parse(data);
            foreach (var header in responseHeaders)
            {
                if(header.Key.Equals("status", StringComparison.OrdinalIgnoreCase))
                {
                    retval = int.Parse(header.Value!.ToString());
                }
                response.Headers.Add(header.Key, header.Value!.ToString());
            }

        }

        return retval;
    }

    public static async Task<bool> AddCustomResponseBody(this HttpResponse response, IWebHostEnvironment environment)
    {
        var path = Path.Combine(environment.ContentRootPath, "Data", "response-body.json");
        if (File.Exists(path))
        {
            var data = await File.ReadAllBytesAsync(path);

            await response.Body.WriteAsync(data);

            return true;
        }

        return false;
    }
}
