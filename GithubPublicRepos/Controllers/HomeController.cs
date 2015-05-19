using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GithubPublicRepos.Workers;

namespace GithubPublicRepos.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            var worker = new ApiDAL();
            

            return View(worker.GetSubRedditItems("WorldNews"));
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