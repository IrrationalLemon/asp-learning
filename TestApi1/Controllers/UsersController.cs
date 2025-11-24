using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NuGet.Protocol.Core.Types;
using TestApi1.Models;

namespace TestApi1.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : Controller
    {
        private readonly TestBdContext _context;

        public UsersController(TestBdContext context)
        {
            this._context = context;
        }

        [HttpGet("get-all-users")]
        public IActionResult GetAllUsers()
        {
            var users = _context.Users.ToList();
            return Ok(users);
        }

        [HttpGet("test")]
        public IActionResult Test()
        {
            return Ok("Test works!");
        }

        [HttpPost]
        public IActionResult AddUser(AddUserDTO addUserDto)
        {
            var userEnt = new User() 
            {
                Login = addUserDto.Login,
                Password = addUserDto.Password,
                IdRole = addUserDto.IdRole
            };
            _context.Users.Add(userEnt);
            _context.SaveChanges();
            return Ok(userEnt);
        }

        [HttpPut]
        [Route("{id:int}")]
        public IActionResult UpdateUser(int id, UpdateUserDTO updateUserDto)
        {
            var user = _context.Users.Find(id);
            if(user is null)
            {
                return NotFound();
            }

            user.Login = updateUserDto.Login;
            user.Password = updateUserDto.Password;
            user.IdRole = updateUserDto.IdRole;

            _context.SaveChanges();
            return Ok(user);
        }

        [HttpDelete]
        [Route("{id:int}")]
        public IActionResult DeleteUser(int id)
        {
            var user = _context.Users.Find(id);
            if(user is null)
            {
                return NotFound();
            }
            _context.Users.Remove(user);
            _context.SaveChanges();
            return Ok(user);
        }
    }
}
