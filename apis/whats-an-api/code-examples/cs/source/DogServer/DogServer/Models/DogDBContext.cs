namespace DogServer.Models
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class DogDBContext : DbContext
    {
        public DogDBContext()
            : base("name=DogDBContext")
        {
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
        }

        public DbSet<Dog> Dog { get; set; }
    }
}
