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

namespace IBS.ERP.Controllers
{
    public class EmployeeController : Controller
    {

        // GET: Employee
        public async Task<ActionResult> Index()
        {
            WebAPI webapi = new WebAPI();
            HttpResponseMessage response = await webapi.CallToWebAPI(APICallType.Get, "APIEmployee", "", Convert.ToString(Session["DBConnectionString"]), Convert.ToString(Session["UserAccount"]), Convert.ToString(Session["RoleId"]), Convert.ToString(Session["CompanyCode"]));
            if (response.IsSuccessStatusCode)
            {
                var data = await response.Content.ReadAsStringAsync();
                var employees = JsonConvert.DeserializeObject<IEnumerable<EmployeeMaster>>(data);

                return View(employees);
            }
            else
            {
                return View();
            }

        }


        // GET: Category/Create
        [HasPermission("CREATE_Employee")]
        public ActionResult Create()
        {

            return View();
        }

        // POST: Category/Create
        [HttpPost]
        [HasPermission("CREATE_Employee")]
        public async Task<ActionResult> Create(FormCollection collection)
        {
            ReturnResult returnResult = new ReturnResult();
            EmployeeMaster objEmployee = new EmployeeMaster();
            try
            {
                // TODO: Add insert logic here
                objEmployee.EmployeeId = 0;
                objEmployee.FirstName = Convert.ToString(collection["FirstName"]);
                objEmployee.LastName = Convert.ToString(collection["LastName"]);
                objEmployee.Address = Convert.ToString(collection["Address"]);
                objEmployee.City = Convert.ToString(collection["City"]);
                objEmployee.Country = Convert.ToString(collection["Country"]);
                objEmployee.PostalCode = Convert.ToString(collection["PostalCode"]);
                objEmployee.Title = Convert.ToString(collection["Title"]);
                objEmployee.EmpCode = Convert.ToString(collection["EmpCode"]);
                objEmployee.Region = Convert.ToString(collection["Region"]);

                WebAPI webapi = new WebAPI();
                HttpResponseMessage response = await webapi.CallToWebAPI(APICallType.Post, "APIEmployee", "", Convert.ToString(Session["DBConnectionString"]), Convert.ToString(Session["UserAccount"]), Convert.ToString(Session["RoleId"]), Convert.ToString(Session["CompanyCode"]), 0, objEmployee);
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
                        TempData["CreateEmployeeMessage"] = returnResult.Message;
                        return View(objEmployee);
                    }
                }
                else
                {
                    TempData["CreateEmployeeMessage"] = "Error while saving data.";
                    return View(objEmployee);
                }

                // CategoryBL categroyBL = new CategoryBL();

                // returnResult= categroyBL.SaveCategory(objCategory);
                //if (returnResult.IsSuccess)
                //{
                //    return RedirectToAction("Index");
                //}
                // else
                //{
                //    TempData["CreateCategoryMessage"] = returnResult.Message;
                //    return View(objCategory); 
                //}
            }
            catch
            {
                TempData["CreateCategoryMessage"] = returnResult.Message;
                return View(objEmployee);
            }
        }
    }
}