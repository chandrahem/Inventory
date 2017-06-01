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

        // GET: COMPANY/Create
        [HasPermission("CREATE_COMPANY")]
        public ActionResult Create()
        {

            return View();
        }

        // POST: COMPANY/Create
        [HttpPost]
        [HasPermission("CREATE_COMPANY")]
        public ActionResult Create(FormCollection collection)
        {
           return SaveCompany(0, collection);
        }


        // GET: COMPANY/Edit/5
        [HasPermission("UPDATE_COMPANY")]
        public ActionResult Edit(int id)
        {
            CompanyBL companyBL = new CompanyBL();
            var companies = companyBL.GetCompanyById(id);
            return View(companies);
        }

        // POST: Category/Edit/5
        [HttpPost]
        [HasPermission("UPDATE_COMPANY")]
        public ActionResult Edit(int id, FormCollection collection)
        {
            return SaveCompany(id, collection);
        }


        [HasPermission("DELETE_COMPANY")]
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

        private ActionResult SaveCompany(int id, FormCollection collection)
        {

            ReturnResult returnResult = new ReturnResult();
            CompanyMaster objCompany = new CompanyMaster();
            try
            {
                // TODO: Add insert logic here

                CompanyBL objcompanyBL = new CompanyBL();
                objCompany.CompanyId = id;
                objCompany.CompanyCode = Convert.ToString(collection["CompanyCode"]);
                objCompany.CompanyName = Convert.ToString(collection["CompanyName"]);
                objCompany.Address = Convert.ToString(collection["Address"]);
                objCompany.City = Convert.ToString(collection["City"]);
                objCompany.ContactEmail = Convert.ToString(collection["City"]);
                objCompany.OwnedBy = Convert.ToString(collection["OwnedBy"]);
                objCompany.Phone1 = Convert.ToString(collection["Phone1"]);
                objCompany.Phone2 = Convert.ToString(collection["Phone2"]);
                objCompany.RegistrationNo = Convert.ToString(collection["RegistrationNo"]);
                objCompany.Tin = Convert.ToString(collection["Tin"]);
                objCompany.Website = Convert.ToString(collection["Website"]);

                returnResult = objcompanyBL.SaveCompany(objCompany);
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
    }
}