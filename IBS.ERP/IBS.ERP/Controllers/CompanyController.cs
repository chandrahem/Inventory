using IBS.ERP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IBS.ERP.BL;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Net.Http.Headers;

namespace IBS.ERP.Controllers
{
    public class CompanyController : Controller
    {
        
        // GET: Company
        [HasPermission("READ_COMPANY")]
        public async Task<ActionResult> Index()
        {
            WebAPI webapi = new WebAPI();
            HttpResponseMessage response = await webapi.CallToWebAPI(APICallType.Get, "APICompany", "", Convert.ToString(Session["DBConnectionString"]), Convert.ToString(Session["UserAccount"]), Convert.ToString(Session["RoleId"]), Convert.ToString(Session["CompanyCode"]));
            if (response.IsSuccessStatusCode)
            {

                //get the headers values
                HttpHeaders headers = response.Headers;
                IEnumerable<string> values;
                if (headers.TryGetValues("PageNo", out values))
                {
                    string session = values.First();
                }

                // get the content values
                var data = await response.Content.ReadAsStringAsync();

                // to convert json  in data table
                //var table = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(data);

                // convert json in IEnumerable object list of category
                var companies = JsonConvert.DeserializeObject<IEnumerable<CompanyMaster>>(data);

                return View(companies);
            }
            else
            {
                return View();
            }
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
        public async Task<ActionResult> Create(FormCollection collection)
        {
            ReturnResult returnResult = new ReturnResult();
            CompanyMaster objCompany = new CompanyMaster();
            try
            {
                // TODO: Add insert logic here

                CompanyBL objcompanyBL = new CompanyBL();
                objCompany.CompanyId = 0;
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

                WebAPI webapi = new WebAPI();
                HttpResponseMessage response = await webapi.CallToWebAPI(APICallType.Post, "APICompany", "", Convert.ToString(Session["DBConnectionString"]), Convert.ToString(Session["UserAccount"]), Convert.ToString(Session["RoleId"]), Convert.ToString(Session["CompanyCode"]), 0, objCompany);
                if (response.IsSuccessStatusCode)
                {
                    var data = await response.Content.ReadAsStringAsync();

                    // convert json in IEnumerable object list of category
                    returnResult = JsonConvert.DeserializeObject<ReturnResult>(data);

                    if (returnResult.IsSuccess)
                    {
                        return RedirectToAction("Index");
                    }
                    else
                    {
                        TempData["CreateCompanyMessage"] = returnResult.Message;
                        return View(objCompany);
                    }
                }
                else
                {
                    TempData["CreateCompanyMessage"] = "Error while saving data.";
                    return View(objCompany);
                }


            }
            catch
            {
                TempData["CreateCompanyMessage"] = returnResult.Message;
                return View(objCompany);
            }
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


        public async Task<ActionResult> Edit(int id, FormCollection collection)
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

                WebAPI webapi = new WebAPI();
                HttpResponseMessage response = await webapi.CallToWebAPI(APICallType.Post, "APICompany", "", Convert.ToString(Session["DBConnectionString"]), Convert.ToString(Session["UserAccount"]), Convert.ToString(Session["RoleId"]), Convert.ToString(Session["CompanyCode"]), 0, objCompany);
                if (response.IsSuccessStatusCode)
                {
                    var data = await response.Content.ReadAsStringAsync();

                    // convert json in IEnumerable object list of category
                    returnResult = JsonConvert.DeserializeObject<ReturnResult>(data);

                    if (returnResult.IsSuccess)
                    {
                        return RedirectToAction("Index");
                    }
                    else
                    {
                        TempData["CreateCompanyMessage"] = returnResult.Message;
                        return View(objCompany);
                    }
                }
                else
                {
                    TempData["CreateCompanyMessage"] = "Error while saving data.";
                    return View(objCompany);
                }


            }
            catch
            {
                TempData["CreateCompanyMessage"] = returnResult.Message;
                return View(objCompany);
            }
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

       
    }
}