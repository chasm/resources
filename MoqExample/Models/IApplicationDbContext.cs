using System.Data.Entity;

namespace MoqExample.Models
{
    public interface IApplicationDbContext
    {
        IDbSet<Human> Humans { get; set; }
        int SaveChanges();
    }
}