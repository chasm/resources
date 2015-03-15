using System.Data.Entity;

namespace DogServer.Models
{
    public class DogModel : DbContext
    {
        public DogModel()
            : base("name=DefaultConnection")
        {
        }


        public DbSet<Dog> Dog { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            Database.SetInitializer(new MigrateDatabaseToLatestVersion<DogModel, Configuration>());
            base.OnModelCreating(modelBuilder);
        }
    }
}