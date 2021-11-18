using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Story.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace Story.Controllers
{
    public class Bikes1Controller : Controller
    {
        

        private ContextBike db = new ContextBike();


        // GET: Bikes1
        public ActionResult Index()
        {
           
            //проверка пользователя
            IList<string> roles = new List<string> { "Роль не определена" };
            ApplicationUserManager userManager = HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            ApplicationUser user = userManager.FindByEmail(User.Identity.Name);
            if (user != null)
                roles = userManager.GetRoles(user.Id);
            ViewBag.rol = roles;
            //
            return View(db.Bikes.ToList());
        }
        [HttpPost]
        public ActionResult Index(string Name)
        {


            //проверка пользователя
            IList<string> roles = new List<string> { "Роль не определена" };
            ApplicationUserManager userManager = HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            ApplicationUser user = userManager.FindByEmail(User.Identity.Name);
            if (user != null)
                roles = userManager.GetRoles(user.Id);
            ViewBag.rol = roles;
            // Поиск по типу
            var allBike = db.Bikes.Where(a => a.BikeType.Contains(Name)).ToList();
            return View(allBike);
        }

        // GET: Bikes1/Details/5
        public ActionResult Details(int? id)
        {
            //проверка пользователя
            IList<string> roles = new List<string> { "Роль не определена" };
            ApplicationUserManager userManager = HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            ApplicationUser user = userManager.FindByEmail(User.Identity.Name);
            if (user != null)
                roles = userManager.GetRoles(user.Id);
            ViewBag.rol = roles;
           
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Bike bike = db.Bikes.Find(id);
            if (bike == null)
            {
                return HttpNotFound();
            }
            return View(bike);
        }
        [Authorize]
        [HttpPost]
        //оформление заказа
        public string Details(Bid newBid)
        {
            newBid.BidDate = DateTime.Now;
            db.Bids.Add(newBid);
            db.SaveChanges();
            
            return "Спасибо,<b>" + newBid.LastName+"</b>, наш оператор в скором времени Вам перезвонит на номер:"+ newBid.Phone ;
        }

        [Authorize(Roles = "admin")]
        // GET: Bikes1/Create
        public ActionResult Create()
        {
            {
                var alltypes = db.BikeTs.ToList<BikeT>();
                ViewBag.alltype = alltypes;
                var allmaker = db.Makers.ToList<Maker>();
                ViewBag.allmaker = allmaker;
                return View();
            }
            
        }

        // POST: Bikes1/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [Authorize(Roles = "admin")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "BikeID,Img,Maker,BikeType,Weight,Wheel,Frame,Number,Price,Comment")] Bike bike)
        {
            if (ModelState.IsValid)
            {
                
                db.Bikes.Add(bike);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(bike);
        }
        // Загрузка файла
        //[HttpPost]
        //public ActionResult Upload(HttpPostedFileBase upload)
        //{
        //    if (upload != null)
        //    {
        //        // получаем имя файла
        //        string fileName = System.IO.Path.GetFileName(upload.FileName);
        //        // сохраняем файл в папку Files в проекте
        //        upload.SaveAs(Server.MapPath("~/Image/" + fileName));
        //    }
        //    return RedirectToAction("Create");
        //}
        [Authorize(Roles = "admin")]
        // GET: Bikes1/Edit/5
        public ActionResult Edit(int? id)
        {
            var alltypes = db.BikeTs.ToList<BikeT>();
            ViewBag.alltype = alltypes;
            var allmaker = db.Makers.ToList<Maker>();
            ViewBag.allmaker = allmaker;
            
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Bike bike = db.Bikes.Find(id);
            if (bike == null)
            {
                return HttpNotFound();
            }
            return View(bike);
        }

        // POST: Bikes1/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [Authorize(Roles = "admin")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "BikeID,Img,Maker,BikeType,Weight,Wheel,Frame,Number,Price,Comment")] Bike bike)
        {
            if (ModelState.IsValid)
            {
                db.Entry(bike).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(bike);
        }
        [Authorize(Roles = "admin")]
        // GET: Bikes1/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Bike bike = db.Bikes.Find(id);
            if (bike == null)
            {
                return HttpNotFound();
            }
            return View(bike);
        }
        [Authorize(Roles = "admin")]
        // POST: Bikes1/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Bike bike = db.Bikes.Find(id);
            db.Bikes.Remove(bike);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
