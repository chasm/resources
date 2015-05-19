using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GithubPublicRepos.Models
{
    public class Repo
    {
        public string name { get; set; }
        public string full_name { get; set; }
        public string desription { get; set; }
    }
}