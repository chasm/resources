using System.Data.Entity;

namespace DogServer.Models
{
    public class DogModel : DbContext
    {
        public DogModel()
            : base("name=DogModel")
        {
        }

        public DbSet<Dog> Dog { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
        }
    }
}