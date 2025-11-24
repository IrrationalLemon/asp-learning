using System.ComponentModel.DataAnnotations.Schema;

namespace TestApi1.Models
{
    public class UpdateUserDTO
    {
        public int Id { get; set; }

        public string? Login { get; set; }

        public string? Password { get; set; }

        public int? IdRole { get; set; }

        [ForeignKey("IdRole")]
        public virtual Role? IdRoleNavigation { get; set; }
    }
}
