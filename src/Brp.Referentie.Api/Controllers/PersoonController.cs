using Microsoft.AspNetCore.Mvc;
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
        if(HttpContext.Request.Headers.ContainsKey("accept-gezag-version"))
        {
            HttpContext.Response.Headers.Add("accept-gezag-version", HttpContext.Request.Headers["accept-gezag-version"]);
        }
        
        int status = await HttpContext.Response.AddCustomResponseHeaders(_environment);

        if (await HttpContext.Response.AddCustomResponseBody(_environment))
        {
            return StatusCode(status);
        }

        return Ok(new { personen = new List<object>() });
    }
}
