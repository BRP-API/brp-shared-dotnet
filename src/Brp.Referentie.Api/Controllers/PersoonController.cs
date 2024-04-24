using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
namespace Brp.Referentie.Api.Controllers;

[ApiController,
Route("haalcentraal/api/brp")]
public class PersoonController : ControllerBase
{
    private readonly IWebHostEnvironment _environment;

    public PersoonController(IWebHostEnvironment environment)
    {
        _environment = environment;
    }

    [HttpPost,
    Route("personen")]
    public async Task<IActionResult> Index([FromBody]object body)
    {
        var path = Path.Combine(_environment.ContentRootPath, "Data", "response-headers.json");
        if(System.IO.File.Exists(path))
        {
            var data = await System.IO.File.ReadAllTextAsync(path);

            var responseHeaders = JObject.Parse(data);
            foreach (var header in responseHeaders)
            {
                HttpContext.Response.Headers.Add(header.Key, header.Value?.ToString());
            }

        }

        return Ok(new { personen = new List<object>() });
    }
}
