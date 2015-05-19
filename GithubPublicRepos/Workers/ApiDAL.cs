using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Runtime.CompilerServices;
using System.Web;
using GithubPublicRepos.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace GithubPublicRepos.Workers
{
    public class ApiDAL
    {
        private Uri baseUrl  = new Uri("http://reddit.com");

        public List<RedditItem> GetSubRedditItems(string subReddit)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = baseUrl;

                var response = client.GetAsync(string.Format("r/{0}.json", subReddit)).Result;
                var responseContent = response.Content.ReadAsStringAsync().Result;


                return ConvertJsonToRedditItem(responseContent);



            }
           
        }

        public List<RedditItem> ConvertJsonToRedditItem(string json)
        {
            var redditItems = JsonConvert.DeserializeObject<dynamic>(json);

            var redditResult = new List<RedditItem>();
            foreach (var item in redditItems.data.children)
            {
                redditResult.Add(new RedditItem() {title = item.data.title, url = item.data.url});
            }


            return redditResult;
        } 
    }
}