using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MoqExample.Models;

namespace MoqExample.Controllers
{
    public class HomeController : Controller
    {
        private IApplicationDbContext Db;
        public HomeController(IApplicationDbContext db)
        {
            Db = db;
        }

        public List<Human> GetAllHumans()
        {
            return Db.Humans.ToList();
        }
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}