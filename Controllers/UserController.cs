using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace TestAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        [HttpGet]
        public string Get()
        {
            return "Http've got the request!";
        }

        [HttpGet("Users")]
        public string GetUsers()
        {
            return "Http've got the request!";
        }

        [HttpPost]
        public string Create()
        {
            return "Post got request!";
        }

        [HttpPut("{id}")]
        public string Edit(int id)
        {
            return "Http put request!";
        }

        [HttpDelete("{id}")]
        public string Delete(int id)
        {
            return "Http delete request";
        }

    }
}
