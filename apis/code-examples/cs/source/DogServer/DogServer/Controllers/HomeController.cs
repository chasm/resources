using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.Mvc;
using DogServer.Models;
using RestSharp;

namespace DogServer.Controllers
{
    public class HomeController : Controller
    {
        // Uses RestSharp for sending http requests to the cat server
        private DogDBContext db = new DogDBContext();
        private RestClient catClient = new RestClient("http://example.com");

        // GET: Index
        public ActionResult Index()
        {
            return View(db.Dog.ToList());
        }

        // POST: TaintCat/5/
        [System.Web.Http.HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult TaintCat(int id)
        {
            var taint = new RestRequest(String.Format("/cats/{0}/taint", id), Method.PATCH);
            catClient.Execute(taint);
            return RedirectToAction("Index");
        }

        // POST: ResurectCats
        [System.Web.Http.HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ResurectCats()
        {
            var res = new RestRequest("/cats/resurrect", Method.PATCH);
            catClient.Execute(res);
            return RedirectToAction("Index");
        }
    }
}
