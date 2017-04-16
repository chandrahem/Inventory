using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IBS.ERP.Models;
using IBS.ERP.BL;
namespace IBS.ERP.Controllers
{
    public class SupplierController : Controller
    {
        // GET: Supplier
         [HasPermission("READ_SUPPLIER")]
        public ActionResult Index()
        {
            SuppliersBL objsupplierBl = new SuppliersBL();
            List<Suppliers> suppliersList= objsupplierBl.GetSuppliersList();
            return View(suppliersList);
        }

        // GET: Supplier/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Supplier/Create
        [HasPermission("CREATE_SUPPLIER")]
        public ActionResult Create()
        {
            return View();
        }

        // POST: Supplier/Create
        [HttpPost]
        [HasPermission("CREATE_SUPPLIER")]
        public ActionResult Create(FormCollection collection)
        {
            ReturnResult returnResult = new ReturnResult();
            Suppliers objSupplier = new Suppliers();
            try
            {
                // TODO: Add insert logic here

                SuppliersBL suppplierBL = new SuppliersBL();
                objSupplier.SupplierId = 0;
                objSupplier.SupplierCode = Convert.ToString(collection["SupplierCode"]);
                objSupplier.SupplierName = Convert.ToString(collection["SupplierName"]);
                objSupplier.Address = Convert.ToString(collection["Address"]);
                objSupplier.City = Convert.ToString(collection["City"]);
                objSupplier.ContactEmail = Convert.ToString(collection["ContactEmail"]);
                objSupplier.ContactName = Convert.ToString(collection["ContactName"]);
                objSupplier.ContactTitle = Convert.ToString(collection["ContactTitle"]);
                objSupplier.Country = Convert.ToString(collection["Country"]);
                objSupplier.Fax = Convert.ToString(collection["Fax"]);
                objSupplier.Phone1 = Convert.ToString(collection["Phone1"]);
                objSupplier.Phone2 = Convert.ToString(collection["Phone2"]);
                objSupplier.PostalCode = Convert.ToString(collection["PostalCode"]);
                objSupplier.Website = Convert.ToString(collection["Website"]);

                returnResult = suppplierBL.SaveSupplier(objSupplier);
                if (returnResult.IsSuccess)
                {
                    return RedirectToAction("Index");
                }
                else
                {
                    TempData["CreateSupplierMessage"] = returnResult.Message;
                    return View(objSupplier);
                }
            }
            catch(Exception ex)
            {

                Logger.Error("IBS.ERP.SupplierController.Create [HttpPost] ID:0 ", ex);
                TempData["CreateSupplierMessage"] = returnResult.Message;
                return View(objSupplier);
            }
        }

        // GET: Supplier/Edit/5
         [HasPermission("UPDATE_SUPPLIER")]
        public ActionResult Edit(int id)
        {
            SuppliersBL supplierBL = new SuppliersBL();
            var supplier = supplierBL.GetSupplierById(id);
            return View(supplier);
        }

        // POST: Supplier/Edit/5
        [HttpPost]
        [HasPermission("UPDATE_SUPPLIER")]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ReturnResult returnResult = new ReturnResult();
            Suppliers objSupplier = new Suppliers();
            try
            {
                // Just to check the error log
                //int a = 0, b=1,c;
                //c = b / a;


                SuppliersBL supplierBL = new SuppliersBL();
                objSupplier.SupplierId = id;
                objSupplier.SupplierCode = Convert.ToString(collection["SupplierCode"]);
                objSupplier.SupplierName = Convert.ToString(collection["SupplierName"]);
                objSupplier.Address = Convert.ToString(collection["Address"]);
                objSupplier.City = Convert.ToString(collection["City"]);
                objSupplier.ContactEmail = Convert.ToString(collection["ContactEmail"]);
                objSupplier.ContactName = Convert.ToString(collection["ContactName"]);
                objSupplier.ContactTitle = Convert.ToString(collection["ContactTitle"]);
                objSupplier.Country = Convert.ToString(collection["Country"]);
                objSupplier.Fax = Convert.ToString(collection["Fax"]);
                objSupplier.Phone1 = Convert.ToString(collection["Phone1"]);
                objSupplier.Phone2 = Convert.ToString(collection["Phone2"]);
                objSupplier.PostalCode = Convert.ToString(collection["PostalCode"]);
                objSupplier.Website = Convert.ToString(collection["Website"]);
                returnResult = supplierBL.SaveSupplier(objSupplier);


                if (returnResult.IsSuccess)
                {
                    return RedirectToAction("Index");
                }
                else
                {
                    TempData["UpdateSupplierMessage"] = returnResult.Message;
                    return View(objSupplier);
                }



            }
            catch (Exception ex)
            {
                Logger.Error("IBS.ERP.SupplierController.Edit [HttpPost] ID: " + id, ex);
                TempData["UpdateSupplierMessage"] = returnResult.Message;
                return View(objSupplier);
            }
        }

        // GET: Supplier/Delete/5
         [HasPermission("DELETE_SUPPLIER")]
        public ActionResult Delete(int id)
        {
            SuppliersBL supplierBL = new SuppliersBL();
            ReturnResult result = supplierBL.DeleteSupplier(id);
            if (!result.IsSuccess)
            {
                TempData["Message"] = "Error while deleting supplier.";
            }

            return RedirectToAction("Index");
            //return View();
        }

        // POST: Supplier/Delete/5
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
