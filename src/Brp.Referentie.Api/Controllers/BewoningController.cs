using Microsoft.AspNetCore.Mvc;

namespace Brp.Referentie.Api.Controllers
{
    [ApiController,
    Route("haalcentraal/api/bewoning")]
    public class BewoningController : ControllerBase
    {
        private readonly IWebHostEnvironment _environment;

        public BewoningController(IWebHostEnvironment environment)
        {
            _environment = environment;
        }

        [HttpPost,
        Route("bewoningen")]
        public async Task<IActionResult> Index([FromBody] object body)
        {
            await HttpContext.Response.AddCustomResponseHeaders(_environment);

            if (await HttpContext.Response.AddCustomResponseBody(_environment))
            {
                return Ok();
            }

            return Ok(new { bewoningen = new List<object>() });
        }
    }
}
