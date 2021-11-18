using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace Story.Models
{
    public class TypesDbInitializer : DropCreateDatabaseIfModelChanges<ContextBike>
    {
        protected override void Seed(ContextBike context)
        {
            context.BikeTs.Add(new BikeT { NameT = "Дорожный" });
            context.BikeTs.Add(new BikeT { NameT = "Горный" });
            context.BikeTs.Add(new BikeT { NameT = "Городской" });
            base.Seed(context);
                }
    }
}