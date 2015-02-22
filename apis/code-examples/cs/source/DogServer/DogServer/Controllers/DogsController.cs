using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using DogServer.Models;
using WebGrease.Css.Extensions;

namespace DogServer.Controllers
{
    public class DogsController : ApiController
    {
        private DogDBContext db = new DogDBContext();

        // GET: api/Dogs
        public IQueryable<Dog> GetDog()
        {
            return db.Dog;
        }

        // POST: api/Dogs/Taint/5
        [System.Web.Http.HttpPost]
        [ValidateAntiForgeryToken]
        public HttpResponseMessage Taint([Bind(Include = "Id,Name,ImageUrl")] Dog dog)
        {
            if (ModelState.IsValid)
            {
                db.Dog.Single(s => s == dog).ImageUrl = "http://bit.ly/17yp0G1";
                db.SaveChanges();
                return this.Request.CreateResponse(HttpStatusCode.Accepted);
            }
            return this.Request.CreateResponse(HttpStatusCode.NotFound);
        }

        // POST: api/Dogs/resurrect
        [System.Web.Http.HttpPost]
        [ValidateAntiForgeryToken]
        public HttpResponseMessage Resurrect()
        {
            db.Database.Delete();
            db.Database.Create();
            return this.Request.CreateResponse(HttpStatusCode.Accepted);
        }
    }
}