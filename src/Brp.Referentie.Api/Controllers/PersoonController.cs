using Microsoft.AspNetCore.Mvc;

namespace Brp.Referentie.Api.Controllers;

[ApiController,
Route("haalcentraal/api/brp")]
public class PersoonController : ControllerBase
{
    [HttpPost,
    Route("personen")]
    public IActionResult Index([FromBody]object body)
    {
        return Ok(new { personen = new List<object>() });
    }
}
