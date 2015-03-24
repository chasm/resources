//Step 2: Added a Ado.Net DbContext by right clicking => add => new item. under the data tab you will find it. I named it ApplicationDbContext as it really is the context for the whole app.
//Note you can have only one dbcontext per project.
//THIS WILL ADD A CONNECTION STRING TO THE WEB.CONFIG/APP.CONFIG FILE POINTING TO LOCALDB

//Step 3: Next I added the line on line 32

//Step 4: After which I enabled migrations and added a new migration. This creates a migration in the migration folder.

namespace CrudToLocalDb.Models
{
    using System;
    using System.Data.Entity;
    using System.Linq;

    public class ApplicationDbContext : DbContext
    {
        // Your context has been configured to use a 'ApplicationDbContext' connection string from your application's 
        // configuration file (App.config or Web.config). By default, this connection string targets the 
        // 'CrudToLocalDb.Models.ApplicationDbContext' database on your LocalDb instance. 
        // 
        // If you wish to target a different database and/or database provider, modify the 'ApplicationDbContext' 
        // connection string in the application configuration file.
        public ApplicationDbContext()
            : base("name=ApplicationDbContext")
        {
        }
        // Add a DbSet for each entity type that you want to include in your model. For more information 
        // on configuring and using a Code First model, see http://go.microsoft.com/fwlink/?LinkId=390109.
        // public virtual DbSet<MyEntity> MyEntities { get; set; }


        // Here we are defining a DbSet of BBCCDPresenter. This is a type of collection enabled by having entity framework included and is how we will interact with the database.
        // To use this - create an instance of the ApplicationDbContext and then access the Presenters property
        public virtual DbSet<BBCCDPresenter> Presenters { get; set; }
    }

    //public class MyEntity
    //{
    //    public int Id { get; set; }
    //    public string Name { get; set; }
    //}
}