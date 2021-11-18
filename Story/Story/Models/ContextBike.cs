using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace Story.Models
{
    public class ContextBike : DbContext
    {
        public DbSet<Bike> Bikes { get; set; }
        public DbSet<Maker> Makers { get; set; }
        public DbSet<BikeT> BikeTs { get; set; }
        public DbSet<Bid> Bids { get; set; }
    }
}