using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices;
using System.Web;
using Newtonsoft.Json.Linq;
using RestSharp;

namespace GitCommitWords.Models {
    public class CommitParser {
        private const string ApiDomain = "https://api.github.com";
        private const string ApiResource = "users/{username}/events";

        private static readonly RestClient GithubClient = new RestClient(ApiDomain);

        public string Username { get; set; }
        public Dictionary<string, int> WordCount { get; set; }

        public CommitParser(string username) {
            Username = username;
            WordCount = new Dictionary<string, int>();
        }

        public void Parse() {
            string json = MakeGithubRequest();
            Process(json);
        }

        private string MakeGithubRequest() {
            RestRequest request = new RestRequest(ApiResource, Method.GET);
            request.AddUrlSegment("username", Username);
            request.AddHeader("Accept", "application/vnd.github.v3+json");
            IRestResponse response = GithubClient.Execute(request);
            return response.Content;
        }

        private void Process(string json)
        {
            JArray events = JArray.Parse(json);
            var a = from event in events.Children()
                where (event["type"] == "PushEvent")
                    select event["payload"]["commits"];
        }
    }
}