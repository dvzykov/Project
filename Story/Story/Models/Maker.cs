using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Story.Models
{
    public class Maker
    {
        //Id производителя
        public virtual int MakerID { set; get; }
        // Название производителя
        public virtual string NameMaker { set; get; }
        //public int? BikeID { set; get; }
        //public Bike Bike { set; get; }
    }
}