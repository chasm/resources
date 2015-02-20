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
using DogServer.Models;

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
    }
}