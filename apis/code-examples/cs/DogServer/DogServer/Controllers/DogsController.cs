using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;
using DogServer.Models;

namespace DogServer.Controllers
{
    public class DogsController : ApiController
    {
        private readonly DogModel db = new DogModel();
        // GET: api/Dogs
        public IQueryable<Dog> GetDog()
        {
            return db.Dog.Select(s => s);
        }

        [System.Web.Http.HttpPost]
        [System.Web.Http.Route("api/dogs/taint/{id}")]
        public HttpResponseMessage Taint(int id)
        {
            db.Dog.Single(s => s.Id == id).ImageUrl = "http://bit.ly/17yp0G1";
            db.SaveChanges();
            return Request.CreateResponse(HttpStatusCode.Accepted);
        }

        [System.Web.Http.HttpPost]
        [System.Web.Http.Route("api/dogs/resurrect")]
        public HttpResponseMessage Resurrect()
        {
            db.Database.Delete();
            db.Database.Create();
            return Request.CreateResponse(HttpStatusCode.Accepted);
        }
    }
}