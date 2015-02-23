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

        public IOrderedEnumerable<KeyValuePair<string, int>> WordCount {
            get {
                return _WordCount.OrderByDescending(kv => kv.Value);
            }
        }

        private Dictionary<string, int> _WordCount { get; set; }

        public CommitParser(string username) {
            Username = username;
            _WordCount = new Dictionary<string, int>();
        }

        public void Parse() {
            string json = MakeGithubRequest();
            IEnumerable<string> messages = ExtractMessages(json);
            CountWords(messages);
        }

        private void CountWords(IEnumerable<string> messages) {
            foreach(string message in messages) {
                string[] words = message.ToLowerInvariant().Split(
                    new char[] { '.', '?', '!', ' ', ';', ':', ',', '/', '\\' }, StringSplitOptions.RemoveEmptyEntries);
                foreach(string word in words) {
                    if(_WordCount.ContainsKey(word)) {
                        _WordCount[word]++;
                    } else {
                        _WordCount[word] = 1;
                    }
                }
            }
        }

        private string MakeGithubRequest() {
            RestRequest request = new RestRequest(ApiResource, Method.GET);
            request.AddUrlSegment("username", Username);
            request.AddHeader("Accept", "application/vnd.github.v3+json");
            IRestResponse response = GithubClient.Execute(request);
            return response.Content;
        }

        private IEnumerable<string> ExtractMessages(string json) {
            return JArray.Parse(json)
                    .Children()
                    .Where(evnt => (string)evnt["type"] == "PushEvent")
                    .Select(pushEvent => pushEvent["payload"]["commits"])
                    .SelectMany(commits => commits)
                    .Select(commit => (string)commit["message"]);
        }
    }
}