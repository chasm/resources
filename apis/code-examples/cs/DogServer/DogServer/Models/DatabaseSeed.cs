using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Web;

namespace DogServer.Models
{
    public class DatabaseSeed
    {
        public void Seed(DogModel context)
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