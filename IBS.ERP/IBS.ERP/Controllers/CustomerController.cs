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
    public class CustomerController : Controller
    {
        // GET: Customer
       [HasPermission("READ_CUSTOMER")]
        public ActionResult Index()
        {
            return View();
        }

        [HasPermission("READ_CUSTOMER")]
       public async Task<JsonResult> GetStudentMarks(int jtStartIndex, int jtPageSize, string CompanyName, string CustomerCode, string ContactName, string Phone, string City, string State, string Country, string FromDate, string ToDate, string PostalCode)
        {
            int totalRows = 0;
            bool blnCreate = false, blnEdit = false, blnDelete = false, blnView=false;

            jtStartIndex = jtStartIndex == 0 ? 0 : (jtStartIndex / jtPageSize + 1);

            Paging objpaging = new Paging
            {
                MaxRows = jtPageSize,
                Order = "DESC",
                OrderBy = "CustomerID",
                StartRowIndex = jtStartIndex,
                FromDate = FromDate,
                ToDate=ToDate
            };

            CustomerMaster objCustomer = new CustomerMaster() { CompanyName = CompanyName, CustomerCode = CustomerCode, ContactName = ContactName, Phone=Phone, City=City,State=State, Country=Country, PostalCode=PostalCode };
           // Currently we are passing two objects 1. customer and Paging , if we need to pass more objects other than Paging then we need to wrap those objects and passed. 
            //same like  we are passing wraping objects in webapi (WebAPIPassingClass)
            WebAPI webapi = new WebAPI();
            HttpResponseMessage response = await webapi.CallToWebAPI(APICallType.Post, "APIPartners", "", Convert.ToString(Session["DBConnectionString"]), Convert.ToString(Session["UserAccount"]), Convert.ToString(Session["RoleId"]), Convert.ToString(Session["CompanyCode"]), 0, objCustomer, objpaging);
            if (response.IsSuccessStatusCode)
            {
              
                //get the headers values
                HttpHeaders headers = response.Headers;
                IEnumerable<string> values;
                if (headers.TryGetValues("TotalRows", out values))
                {
                    totalRows = Convert.ToInt32(values.First());
                }

                if (headers.TryGetValues("CreatePermission", out values))
                {
                    blnCreate = Convert.ToBoolean(values.First());
                }

                if (headers.TryGetValues("UpdatePermission", out values))
                {
                    blnEdit = Convert.ToBoolean(values.First());
                }

                if (headers.TryGetValues("DeletePermission", out values))
                {
                    blnDelete = Convert.ToBoolean(values.First());
                }

                if (headers.TryGetValues("ViewPermission", out values))
                {
                    blnView = Convert.ToBoolean(values.First());
                }
                
                // get the content values
                var data = await response.Content.ReadAsStringAsync();

                // convert json in IEnumerable object list of CustomerMaster
                var customerList = JsonConvert.DeserializeObject<IEnumerable<CustomerMaster>>(data);

                try
                {

                    return Json(new { Result = "OK", Records = customerList, TotalRecordCount = totalRows, createPermission = blnCreate, updatePermission = blnEdit, deletePermission = blnDelete, viewPermission = blnView }, JsonRequestBehavior.AllowGet);
                }
                catch (Exception ex)
                {
                    return Json(new { Result = "ERROR", Message = ex.Message });
                }
            }
            else
            {
                TempData["CreateCategoryMessage"] = "Error while saving data.";
                return null;
            }

        }


        [HttpGet]
        [HasPermission("READ_CUSTOMER")]
        public JsonResult GetCustomer(int CustomerID)
        {

            CustomerMaster CustomerInfo = new CustomerMaster();
            CustomerBL obj = new CustomerBL();
            try
            {
                CustomerInfo = obj.GetCustomerInfo(CustomerID);

            }
            catch (Exception ex)
            {

            }
            finally
            {
            }

            //return new { Result = "OK", Records = CustomerInfo };

            return Json(new { Result = "OK", Records = CustomerInfo }, JsonRequestBehavior.AllowGet);

        }

        [HttpGet]
        [HasPermission("UPDATE_CUSTOMER")]
        public JsonResult EditCustomerInformation(Int32 CustomerID, string CustomerCode, string CustomerBarCode, string CompanyName, string ContactName, string ContactTitle, string Address, string City, string Region, string PostalCode, string Country, string Phone,string State)
        // public JsonResult EditCustomerInformation(string CustomerCode, string CustomerBarCode)
        {
            CustomerMaster CustomerInfo = new CustomerMaster();
            CustomerBL obj = new CustomerBL();
            try
            {
                int EditCustomerInfo = obj.EditCustomerInformation(CustomerID, CustomerCode, CustomerBarCode, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, State);
                return Json(new { Result = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        [HttpGet]
        [HasPermission("DELETE_CUSTOMER")]
        public JsonResult DeleteCustomerInformation(int CustomerID)
        {
            CustomerMaster CustomerInfo = new CustomerMaster();
            CustomerBL obj = new CustomerBL();
            try
            {
                int DeleteCustomerInfo = obj.DeleteCustomerInformation(CustomerID);
                return Json(new { Result = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

         [HttpGet]
        public JsonResult GetCountriesName(int CountryID)
        {
            List<CountryStateCity> CountriesName = null;
            //CountryStateCity Country = new CountryStateCity();
            CustomerBL obj = new CustomerBL();
            try
            {
                var Countrylist = obj.CountryNames();
                CountriesName = Countrylist.ToList<CountryStateCity>();

            }
            catch (Exception ex)
            {

            }
            finally
            {
            }

            //return new { Result = "OK", Records = CustomerInfo };

            return Json(new { Result = "OK", Records = CountriesName }, JsonRequestBehavior.AllowGet);

        }


         [HttpGet]
         public JsonResult GetStatesName(int CountryID)
         {
             
             List<CountryStateCity> StatesName = null;
             //CountryStateCity Country = new CountryStateCity();
             CustomerBL obj = new CustomerBL();
             try
             {
                 var Stateslist = obj.StateNames(CountryID);
                 StatesName = Stateslist.ToList<CountryStateCity>();

             }
             catch (Exception ex)
             {

             }
             finally
             {
             }

             //return new { Result = "OK", Records = CustomerInfo };

             return Json(new { Result = "OK", Records = StatesName }, JsonRequestBehavior.AllowGet);

         }

         [HttpGet]
         public JsonResult GetCitesName(int StateID)
         {
              List<CountryStateCity> CityName = null;
             //CountryStateCity Country = new CountryStateCity();
             CustomerBL obj = new CustomerBL();
             try
             {
                 var Stateslist = obj.CityNames(StateID);
                 CityName = Stateslist.ToList<CountryStateCity>();

             }
             catch (Exception ex)
             {

             }
             finally
             {
             }

             //return new { Result = "OK", Records = CustomerInfo };

             return Json(new { Result = "OK", Records = CityName }, JsonRequestBehavior.AllowGet);

         }





    }
}