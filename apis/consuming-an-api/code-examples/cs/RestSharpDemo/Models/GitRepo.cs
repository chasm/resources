using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RestSharpDemo.Models
{
    public class GitRepo
    {
        public string name { get; set; }
        public string full_name { get; set; }
        public string description { get; set; }
    }
}