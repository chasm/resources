using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RestSharp;

namespace DogServer.Models
{
    public class CatDog
    {
        public List<Cat> cats = new List<Cat>();
        public List<Dog> dogs = new List<Dog>();

        public CatDog(List<Dog> dogs, List<Cat> cats)
        {
            this.dogs = dogs;
            this.cats = cats;
        }
    }
}