using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using TestApi1.Models;

namespace TestApi1.Data
{
    public class TestApi1Context : DbContext
    {
        public TestApi1Context (DbContextOptions<TestApi1Context> options)
            : base(options)
        {
        }

        public DbSet<TestApi1.Models.User> User { get; set; } = default!;
    }
}
