using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace IBS.ERP.Controllers
{
    public class IBSHomeController : Controller
    {
        // GET: IBSHome
        public ActionResult Index()
        {
            return View();
        }

        // GET: IBSHome/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: IBSHome/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: IBSHome/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: IBSHome/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: IBSHome/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: IBSHome/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: IBSHome/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
