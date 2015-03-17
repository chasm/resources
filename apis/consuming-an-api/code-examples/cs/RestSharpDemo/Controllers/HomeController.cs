using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RestSharpDemo.Models;

namespace RestSharpDemo.Controllers
{
    public class HomeController : Controller
    {
        private ApiDal dal = new ApiDal();
        public ActionResult Index()
        {
            IndexViewModel viewmodel = new IndexViewModel();
            viewmodel.Repos = dal.GetPublicReposOfOrg("enspiral-dev-academy");
            return View(viewmodel);
        }
    }
}