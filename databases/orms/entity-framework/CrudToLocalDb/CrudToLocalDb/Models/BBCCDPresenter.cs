//Step 1: Add a class/model that represents the object we are going to put in the database

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CrudToLocalDb.Models
{
    public class BBCCDPresenter
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public long KreepLevel { get; set; }
        public bool IsDodgy { get; set; }
    }
}