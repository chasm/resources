using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;
using DogServer.Models;

namespace DogServer.Controllers
{
    public class DogApiController : ApiController
    {
        private readonly DogModel db = new DogModel();
        // GET: api/Dogs
        public IQueryable<Dog> GetDog()
        {
            return db.Dog.Select(s => s);
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
                return Request.CreateResponse(HttpStatusCode.Accepted);
            }
            return Request.CreateResponse(HttpStatusCode.NotFound);
        }

        // POST: api/Dogs/resurrect
        [System.Web.Http.HttpPost]
        [ValidateAntiForgeryToken]
        public HttpResponseMessage Resurrect()
        {
            db.Database.Delete();
            db.Database.Create();
            return Request.CreateResponse(HttpStatusCode.Accepted);
        }
    }
}