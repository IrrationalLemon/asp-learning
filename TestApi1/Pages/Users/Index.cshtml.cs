using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using TestApi1.Data;
using TestApi1.Models;

namespace TestApi1.Pages.Users
{
    public class IndexModel : PageModel
    {
        private readonly TestApi1.Data.TestApi1Context _context;

        public IndexModel(TestApi1.Data.TestApi1Context context)
        {
            _context = context;
        }

        public IList<User> User { get;set; } = default!;

        public async Task OnGetAsync()
        {
            User = await _context.User.ToListAsync();
        }
    }
}
