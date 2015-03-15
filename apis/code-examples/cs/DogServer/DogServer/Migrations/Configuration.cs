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
            new DatabaseSeed().Seed(context);
        }
    }
}