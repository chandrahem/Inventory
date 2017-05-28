using IBS.ERP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IBS.ERP.BL;

namespace IBS.ERP.Controllers
{
    public class CompanyController : Controller
    {
        
        // GET: Company
        [HasPermission("READ_COMPANY")]
        public ActionResult Index()
        {
            CompanyBL companyBL = new CompanyBL();

            var Companies = companyBL.GetCompanies();

            return View(Companies);
        }

        // GET: Category/Create
        [HasPermission("CREATE_CATEGORY")]
        public ActionResult Create()
        {

            return View();
        }

        // POST: Category/Create
        [HttpPost]
        [HasPermission("CREATE_CATEGORY")]
        public ActionResult Create(FormCollection collection)
        {
            ReturnResult returnResult = new ReturnResult();
            CompanyMaster objCompany = new CompanyMaster();
            try
            {
                // TODO: Add insert logic here

                CompanyBL ObjcompanyBL = new CompanyBL();
                objCompany.CompanyId = 0;
                objCompany.CompanyCode = Convert.ToString(collection["CompanyCode"]);
                objCompany.CompanyName = Convert.ToString(collection["CompanyName"]);
                objCompany.Address = Convert.ToString(collection["Address"]);
                objCompany.City = Convert.ToString(collection["City"]);
                returnResult = ObjcompanyBL.SaveCompany(objCompany);
                if (returnResult.IsSuccess)
                {
                    return RedirectToAction("Index");
                }
                else
                {
                    //TempData["CreateCategoryMessage"] = returnResult.Message;
                   return View(objCompany);
                }
            }
            catch
            {
                TempData["CreateCategoryMessage"] = returnResult.Message;
                return View(objCompany);
            }
        }


        // GET: Category/Edit/5
        [HasPermission("UPDATE_CATEGORY")]
        public ActionResult Edit(int id)
        {
            CompanyBL companyBL = new CompanyBL();
            var companies = companyBL.GetCompanyById(id);
            return View(companies);
        }

        // POST: Category/Edit/5
        [HttpPost]
        [HasPermission("UPDATE_CATEGORY")]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ReturnResult returnResult = new ReturnResult();
            CompanyMaster objCompany = new CompanyMaster();
            try
            {
                // TODO: Add insert logic here

                CompanyBL ObjcompanyBL = new CompanyBL();
                objCompany.CompanyId = id;
                objCompany.CompanyCode = Convert.ToString(collection["CompanyCode"]);
                objCompany.CompanyName = Convert.ToString(collection["CompanyName"]);
                objCompany.Address = Convert.ToString(collection["Address"]);
                objCompany.City = Convert.ToString(collection["City"]);
                returnResult = ObjcompanyBL.SaveCompany(objCompany);
               
                    return RedirectToAction("Index");
              
            }
            catch
            {
                return View(objCompany);
            }
        }


        [HasPermission("DELETE_CATEGORY")]
        public ActionResult Delete(int id)
        {
            CompanyBL companyBL = new CompanyBL();
            ReturnResult result = companyBL.DeleteCompany(id);

            //if (!result.IsSuccess)
            //{
            //    TempData["Message"] = "Error while deleting category.";
            //}
            return RedirectToAction("Index");
            //return View();
        }
    }
}