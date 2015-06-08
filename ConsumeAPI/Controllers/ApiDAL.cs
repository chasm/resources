using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using ConsumeAPI.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ConsumeAPI.Controllers
{
    public class ApiDAL
    {

        public List<RedditItem> GetWorldNewsFrontPage()
        {
            HttpClient client = new HttpClient();

            client.BaseAddress = new Uri("http://www.reddit.com/");

            var response = client.GetAsync("/r/worldnews.json").Result;
            if (response.IsSuccessStatusCode)
            {
                string json = response.Content.ReadAsStringAsync().Result;
                return ConvertJsonStringToRedditItems(json);
            }

            return new List<RedditItem>();
            
        }

        private List<RedditItem> ConvertJsonStringToRedditItems(string json)
        {
            var redditItems = new List<RedditItem>();

            dynamic data = JObject.Parse(json);

            foreach (var item in data.data.children)
            {
                var title = item.data.title.ToString();
                var url = item.data.url.ToString();
                redditItems.Add(new RedditItem() { Title = title, Url = url });
            }

            return redditItems;


        }
    }
}