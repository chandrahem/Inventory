using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IBS.ERP.BL;
using IBS.ERP.Models;

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
        public JsonResult GetStudentMarks(int jtStartIndex, int jtPageSize, string CompanyName, string CustomerCode, string ContactName, string Phone, string City, string State, string Country, string FromDate, string ToDate, string PostalCode)
        {
            List<CustomerMaster> documentList = null;
            int totalRows = 0;
            bool  blnCreate=false, blnEdit = false, blnDelete= false;


            jtStartIndex = jtStartIndex == 0 ? 0 : (jtStartIndex / jtPageSize + 1);

            Paging objpaging = new Paging
            {
                MaxRows = jtPageSize,
                Order = "DESC",
                OrderBy = "CustomerID",//"CP.UpdatedDate",
                StartRowIndex = jtStartIndex
            };
            CustomerBL obj = new CustomerBL();

            var docList = obj.GetCandidateDocuments(objpaging, out totalRows, CompanyName, CustomerCode, ContactName, Phone, City, State, Country, FromDate, ToDate, PostalCode, out blnCreate , out blnEdit , out blnDelete );

            documentList = docList.ToList<CustomerMaster>();
            // var docList =  cMasterServices.Current().GetCandidateDocuments( objpaging,out totalRows);
            // ApplicationDbContext db = new ApplicationDbContext();
            try
            {

                return Json(new { Result = "OK", Records = documentList, TotalRecordCount = totalRows, createPermission = blnCreate,updatePermission= blnEdit, deletePermission= blnDelete}, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { Result = "ERROR", Message = ex.Message });
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