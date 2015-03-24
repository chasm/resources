//Step 5: After enabling migrations and adding a migration I want to run the migrations using Update-Database.

//Step 6: Check the table has been updated. Quick Launch (top right SQL Server Object Explorer) or open clicking the button at the top of Server Explorer. Once open navigate in as shown in the connection string.
//In this case (LocalDb)\v11.0;initial catalog=CrudToLocalDb.Models.ApplicationDbContext. 

//Step 7: Add it as a connection to the server explorer. In server explorer click the +"plug" button and type in "(localdb)\v11.0" as the Server Name. You will now be able to see your database and add it as a connection.

//Step 8: Implement a seed data method so the devs will have seed data.

using CrudToLocalDb.Models;

namespace CrudToLocalDb.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<CrudToLocalDb.Models.ApplicationDbContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(CrudToLocalDb.Models.ApplicationDbContext context)
        {
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data. E.g.
            //
            //    context.People.AddOrUpdate(
            //      p => p.FullName,
            //      new Person { FullName = "Andrew Peters" },
            //      new Person { FullName = "Brice Lambson" },
            //      new Person { FullName = "Rowan Miller" }
            //    );
            //

            context.Presenters.AddOrUpdate(
                p => p.Name,
                new BBCCDPresenter {IsDodgy = false, KreepLevel = 0, Name = "Michael Parkinson"},
                new BBCCDPresenter { IsDodgy = true, KreepLevel = 10, Name = "Jimmy Savile"},
                new BBCCDPresenter { IsDodgy = true, KreepLevel = 5, Name = "Jeremy Clarkson"}
                );
        }
    }
}
