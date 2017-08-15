using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IBS.ERP.BL;
using IBS.ERP.Models;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Net.Http.Headers;

namespace IBS.ERP.Controllers
{
    public class EmployeeController : Controller
    {

        [HasPermission("READ_CUSTOMER")]
        public ActionResult Index()
        {
            return View();
        }
        // GET: Employee

        public async Task<JsonResult> GetEmployees(int jtStartIndex, int jtPageSize, string EMPCode, string FirstName)
        {
            int totalRows = 0;           

            jtStartIndex = jtStartIndex == 0 ? 0 : (jtStartIndex / jtPageSize + 1);

            Paging objpaging = new Paging
            {
                MaxRows = jtPageSize,
                Order = "DESC",
                OrderBy = "EmployeeID",
                StartRowIndex = jtStartIndex
                
            };

            EmployeeMaster objEmployee = new EmployeeMaster() { EmpCode = EMPCode, FirstName = FirstName};
            // Currently we are passing two objects 1. customer and Paging , if we need to pass more objects other than Paging then we need to wrap those objects and passed. 
            //same like  we are passing wraping objects in webapi (WebAPIPassingClass)
            WebAPI webapi = new WebAPI();
            HttpResponseMessage response = await webapi.CallToWebAPI(APICallType.Post, "APIEmployee", "", Convert.ToString(Session["DBConnectionString"]), Convert.ToString(Session["UserAccount"]), Convert.ToString(Session["RoleId"]), Convert.ToString(Session["CompanyCode"]), 0, objEmployee, objpaging);
            if (response.IsSuccessStatusCode)
            {

                //get the headers values
                HttpHeaders headers = response.Headers;
                IEnumerable<string> values;
                if (headers.TryGetValues("TotalRows", out values))
                {
                    totalRows = Convert.ToInt32(values.First());
                }

                // get the content values
                var data = await response.Content.ReadAsStringAsync();

                // convert json in IEnumerable object list of CustomerMaster
                var employeeList = JsonConvert.DeserializeObject<IEnumerable<EmployeeMaster>>(data);

                try
                {

                    return Json(new { Result = "OK", Records = employeeList, TotalRecordCount = totalRows }, JsonRequestBehavior.AllowGet);
                }
                catch (Exception ex)
                {
                    return Json(new { Result = "ERROR", Message = ex.Message });
                }
            }
            else
            {
                TempData["CreateEmployeeMessage"] = "Error while saving data.";
                return null;
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





        public async Task<JsonResult> GetEmpCode(string EmpCode)
        {
            Paging objpaging = new Paging
            {
                MaxRows = 10,
                Order = "DESC",
                OrderBy = "EmployeeID",
                StartRowIndex = 0

            };

            EmployeeMaster objEmployee = new EmployeeMaster() { EmpCode = EmpCode };
            // Currently we are passing two objects 1. customer and Paging , if we need to pass more objects other than Paging then we need to wrap those objects and passed. 
            //same like  we are passing wraping objects in webapi (WebAPIPassingClass)
            WebAPI webapi = new WebAPI();
            HttpResponseMessage response = await webapi.CallToWebAPI(APICallType.Post, "APIEmployee", "", Convert.ToString(Session["DBConnectionString"]), Convert.ToString(Session["UserAccount"]), Convert.ToString(Session["RoleId"]), Convert.ToString(Session["CompanyCode"]), 0, objEmployee);
            if (response.IsSuccessStatusCode)
            {

                //get the headers values
                HttpHeaders headers = response.Headers;
               

                // get the content values
                var data = await response.Content.ReadAsStringAsync();

                // convert json in IEnumerable object list of CustomerMaster
                var employeeCode = JsonConvert.DeserializeObject<IEnumerable<EmployeeMaster>>(data);

                try
                {

                    return Json(new { Result = "OK", Records = employeeCode }, JsonRequestBehavior.AllowGet);
                }
                catch (Exception ex)
                {
                    return Json(new { Result = "ERROR", Message = ex.Message });
                }
            }
            else
            {
                TempData["CreateEmployeeMessage"] = "Error while saving data.";
                return null;
            }

        }
    }
}