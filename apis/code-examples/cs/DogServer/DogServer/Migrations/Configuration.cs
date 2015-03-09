using System.Collections.Generic;
using System.Data.Entity.Migrations;
using DogServer.Models;

namespace DogServer
{
    internal sealed class Configuration : DbMigrationsConfiguration<DogModel>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = true;
        }

        protected override void Seed(DogModel context)
        {
            var dogs = new List<Dog>
            {
                new Dog {Id = 1, Name = "Alberto", ImageUrl = "http://bit.ly/19GE8TF"},
                new Dog {Id = 1, Name = "Basseterto", ImageUrl = "http://bit.ly/1zrPWPp"},
                new Dog {Id = 1, Name = "Charlie", ImageUrl = "http://bit.ly/1BsWFhK"},
                new Dog {Id = 1, Name = "Droopy", ImageUrl = "http://bit.ly/1EvzVM0"}
            };
            dogs.ForEach(s => context.Dog.AddOrUpdate(p => p.Id, s));
            context.SaveChanges();
        }
    }
}