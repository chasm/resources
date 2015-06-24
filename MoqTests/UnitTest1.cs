using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using Moq;
using MoqExample.Controllers;
using MoqExample.Models;
using NUnit.Framework;

namespace MoqTests
{
    [TestFixture]
    public class UnitTest1
    {
        [Test]
        public void TestGetAllHumansReturnsData()
        {
            var db = new Mock<IApplicationDbContext>();

            IQueryable<Human> fakeHumans = new List<Human>()
            {
                new Human(){Id = 1, Age = 13, Name = "Michael"},
                new Human(){Id = 2, Age = 20, Name = "James"}

            }.AsQueryable();

            var fakeDBHumans = new Mock<IDbSet<Human>>();

            fakeDBHumans.As<IQueryable<Human>>().Setup(x => x.Provider).Returns(fakeHumans.Provider);
            fakeDBHumans.As<IQueryable<Human>>().Setup(x => x.ElementType).Returns(fakeHumans.ElementType);
            fakeDBHumans.As<IQueryable<Human>>().Setup(x => x.Expression).Returns(fakeHumans.Expression);
            fakeDBHumans.As<IQueryable<Human>>().Setup(x => x.GetEnumerator()).Returns(fakeHumans.GetEnumerator());


            db.Setup(x => x.Humans).Returns(fakeDBHumans.Object);


            HomeController controller = new HomeController(db.Object);

            var humans = controller.GetAllHumans();
            Assert.True(humans.FirstOrDefault().Name == "Michael");
        }
    }
}
