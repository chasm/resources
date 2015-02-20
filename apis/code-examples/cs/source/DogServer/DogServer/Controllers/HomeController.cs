using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DogServer.Models;

namespace DogServer.Controllers
{
    public class HomeController : Controller
    {
        private DogDBContext db = new DogDBContext();

        // GET: Index
        public ActionResult Index()
        {
            return View(db.Dog.ToList());
        }
    }
}
