using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace Story.Models
{
    public class MakersDbInitializer : DropCreateDatabaseIfModelChanges<ContextBike>
    {
        protected override void Seed(ContextBike context)
        {
            context.Makers.Add(new Maker { NameMaker = "ALTAIR" });
            context.Makers.Add(new Maker { NameMaker = "CHALLENGER" });
            context.Makers.Add(new Maker { NameMaker = "Cube" });
            base.Seed(context);
        }
    }
}