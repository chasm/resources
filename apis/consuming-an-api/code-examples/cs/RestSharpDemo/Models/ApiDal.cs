using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using Newtonsoft.Json;
using RestSharp;

namespace RestSharpDemo.Models
{
    public class ApiDal
    {
        
        private Uri baseAddress = new Uri("https://api.github.com");

        public List<GitRepo> GetPublicReposOfOrg(string org)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = baseAddress;

                //Required by Github API
                client.DefaultRequestHeaders.UserAgent.ParseAdd("EDA-API-Lecture");

                var result = client.GetAsync(String.Format("orgs/{0}/repos", org)).Result;
                string resultContent = result.Content.ReadAsStringAsync().Result;

                var repos = ApiSerializer(resultContent);
                return repos;

            }
        }

        private List<GitRepo> ApiSerializer(string content)
        {
            List<GitRepo> repos = JsonConvert.DeserializeObject<List<GitRepo>>(content);
            return repos;
        }
    }
}