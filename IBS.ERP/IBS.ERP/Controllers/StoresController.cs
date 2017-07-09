using IBS.ERP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IBS.ERP.BL;


namespace IBS.ERP.Controllers
{
    public class StoresController : Controller
    {
         [HttpGet]
        // GET: Company
        [HasPermission("READ_Stores")]
        public ActionResult Index()
        {
            StoresBL StoreBL = new StoresBL();

            var Stores = StoreBL.GetStores();

            return View(Stores);
        }

        // GET: COMPANY/Create
        [HasPermission("CREATE_Stores")]
        public ActionResult Create()
        {

            return View();
        }

        // POST: COMPANY/Create
        [HttpPost]
        [HasPermission("CREATE_Stores")]
        public ActionResult Create(FormCollection collection)
        {
            return SaveStores(0, collection);
        }


        // GET: COMPANY/Edit/5
        [HasPermission("UPDATE_Stores")]
        public ActionResult Edit(int id)
        {
            CompanyBL companyBL = new CompanyBL();
            var companies = companyBL.GetCompanyById(id);
            return View(companies);
        }

        // POST: Category/Edit/5
        [HttpPost]
        [HasPermission("UPDATE_Stores")]
        public ActionResult Edit(int id, FormCollection collection)
        {
            return SaveStores(id, collection);
        }

         
        //[HasPermission("DELETE_Stores")]
        //public ActionResult Delete(int id)
        //{
        //    StoresBL storeBL = new StoresBL();
        //    ReturnResult result = storeBL.DeleteStore(id);

        //    //if (!result.IsSuccess)
        //    //{
        //    //    TempData["Message"] = "Error while deleting category.";
        //    //}
        //   // return RedirectToAction("Index");
        //    return View();
        //}

         
         public ActionResult Delete(int id)
         {
             StoresBL storeBL = new StoresBL();
             ReturnResult result = storeBL.DeleteStore(id);

             if (!result.IsSuccess)
             {
                 TempData["Message"] = "Error while deleting category.";
             }
            return RedirectToAction("Index");
             //    return View();
         }

        private ActionResult SaveStores(int id, FormCollection collection)
        {

            ReturnResult returnResult = new ReturnResult();
            Stores objStores = new Stores();
            try
            {
                // TODO: Add insert logic here

                StoresBL objstoresBL = new StoresBL();
                objStores.StoreId = id;
                objStores.StoreName = Convert.ToString(collection["StoreName"]);

                objStores.Address = Convert.ToString(collection["Address"]);
                objStores.City = Convert.ToString(collection["City"]);
                objStores.CompanyId = Convert.ToInt32(collection["CompanyID"]);
                objStores.ManagedBy = Convert.ToString(collection["ManagedBy"]);
                objStores.Phone1 = Convert.ToString(collection["Phone1"]);
                objStores.Phone2 = Convert.ToString(collection["Phone2"]);
                objStores.Email = Convert.ToString(collection["Email"]);


              returnResult = objstoresBL.SaveStores(objStores);
                if (returnResult.IsSuccess)
                {
                    return RedirectToAction("Index");
                }
                else
                {
                    //TempData["CreateCategoryMessage"] = returnResult.Message;
                    return View();
                }
            }
            catch
            {
               // TempData["CreateCategoryMessage"] = returnResult.Message;
               return View();
            }
        }
    }
}