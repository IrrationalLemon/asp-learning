using Microsoft.EntityFrameworkCore;
using TestAPI;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDbContext<UsersDB>(opt => opt.UseInMemoryDatabase("UsersList"));
var app = builder.Build();

app.MapGet("/users", async (UsersDB db) =>
    await db.Users.ToListAsync());

app.MapPost("/user", async (User user, UsersDB db) =>
{
    db.Users.Add(user);
    await db.SaveChangesAsync();
    return Results.Created($"/users/{user.Id}", user);
});


app.MapDelete("/user/{id}", async (int id, UsersDB db) =>
{
    if (await db.Users.FindAsync(id) is User user)
    {
        db.Users.Remove(user);
        await db.SaveChangesAsync();
        return Results.NoContent();
    }

    return Results.NotFound();
});


app.Run();
