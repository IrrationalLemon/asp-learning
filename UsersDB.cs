using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace TestAPI
{
    class UsersDB : DbContext
    {
        public UsersDB(DbContextOptions<UsersDB> options)
            : base(options) { }

        public DbSet<User> Users => Set<User>();
    }
}
