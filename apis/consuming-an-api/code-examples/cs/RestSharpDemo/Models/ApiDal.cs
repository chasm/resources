using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using RestSharp;

namespace RestSharpDemo.Models
{
    public class ApiDal
    {
        private RestClient client = new RestClient("https://api.github.com");

        public List<GitRepo> GetPublicReposOfOrg(string org)
        {
            var request = new RestRequest(String.Format("orgs/{0}/repos", org)); //defaults to Method.Get

            var response = client.Execute(request);

            return ApiSerializer(response.Content);

        }

        private List<GitRepo> ApiSerializer(string content)
        {
            List<GitRepo> repos = JsonConvert.DeserializeObject<List<GitRepo>>(content);
            return repos;
        }
    }
}