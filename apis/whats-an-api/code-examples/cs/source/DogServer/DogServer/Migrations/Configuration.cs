using System.Collections.Generic;
using DogServer.Models;

namespace DogServer.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<DogServer.Models.DogDBContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = true;
        }

        protected override void Seed(DogServer.Models.DogDBContext context)
        {
            var students = new List<Dog>
            {
                new Dog { Id = 1, Name = "Alberto", ImageUrl = "http://bit.ly/19GE8TF"},
                new Dog { Id = 1, Name = "Basseterto", ImageUrl = "http://bit.ly/1zrPWPp"},
                new Dog { Id = 1, Name = "Charlie", ImageUrl = "http://bit.ly/1BsWFhK"},
                new Dog { Id = 1, Name = "Droopy", ImageUrl = "http://bit.ly/1EvzVM0"}
            };
            students.ForEach(s => context.Dog.AddOrUpdate(p => p.Id, s));
            context.SaveChanges();
        }
    }
}
