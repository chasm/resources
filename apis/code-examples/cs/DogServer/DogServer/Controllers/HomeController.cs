using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using DogServer.Models;
using Newtonsoft.Json;
using RestSharp;

namespace DogServer.Controllers
{
    public class HomeController : Controller
    {
        private readonly RestClient catClient = new RestClient("http://cat-server.herokuapp.com");
        // Uses RestSharp for sending http requests to the cat server
        private readonly DogModel db = new DogModel();
        // GET: Index
        public ActionResult Index()
        {
            var get = new RestRequest("api/cats", Method.GET);
            get.RequestFormat = DataFormat.Json;
            var catString = catClient.Execute(get);
            if (catString == null) throw new ArgumentNullException("cats");
            var cats = JsonConvert.DeserializeObject<List<Cat>>(catString.Content);
            var catDog = new CatDog(db.Dog.ToList(), cats);
            return View(catDog);
        }

        // POST: TaintCat/5/
        [HttpPost]
        public ActionResult TaintCat(int id)
        {
            var taint = new RestRequest(String.Format("api/cats/{0}/taint", id), Method.PATCH);
            catClient.Execute(taint);
            return RedirectToAction("Index");
        }

        // POST: ResurectCats
        [HttpPost]
        public ActionResult ResurectCats()
        {
            var res = new RestRequest("api/cats/resurrect", Method.POST);
            catClient.Execute(res);
            return RedirectToAction("Index");
        }
    }
}