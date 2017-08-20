using IBS.ERP.DataAccess;
using IBS.ERP.Models;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace IBS.Services.Controllers
{
    public class APIPartnersController : ApiController
    {
        string connectionString = string.Empty, userAccount = "", roleId = "", companyCode = "", DBProviderName = "";
        // GET: api/APIPartners
        public HttpResponseMessage Get([FromUri] Paging objPaging, [FromUri] CustomerMaster objCustomer)
        {
            int TotalRows=0;
            bool  blnCreate=false, blnEdit=false ,  blnDelete=false, blnView=false;
            CommonAPI commonApi = new CommonAPI();
            commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
            CustomerDAL categroyDAL = new CustomerDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
           // var categories = categroyDAL.GetPartnersList(objPaging, out TotalRows, out blnCreate , out blnEdit, out blnDelete , out blnView, objCustomer);

            // Create the response
            var response = Request.CreateResponse(HttpStatusCode.OK, objCustomer);
            // Set headers for paging
            response.Headers.Add("TotalRows", TotalRows.ToString());
            response.Headers.Add("CreatePermission", blnCreate.ToString());
            response.Headers.Add("UpdatePermission", blnEdit.ToString());
            response.Headers.Add("DeletePermission", blnDelete.ToString());
            response.Headers.Add("ViewPermission", blnView.ToString());

            //response.Headers.Add("X-Paging-PageSize", pageSize.ToString());
            //response.Headers.Add("X-Paging-PageCount", pageCount.ToString());
            //response.Headers.Add("X-Paging-TotalRecordCount", total.ToString());

            return response;
        }

        // GET: api/APIPartners/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/APIPartners
        public HttpResponseMessage Post([FromBody]JObject compoundObject)
        {
            HttpResponseMessage response=null ;
            
            try
            {
                int TotalRows = 0;
                string object1Name = string.Empty, object2Name = string.Empty;
                bool blnCreate = false, blnEdit = false, blnDelete = false, blnView = false;
                CustomerMaster objCustomer=null; Search objSearch=null; Paging objPaging=null;
               
                // Extract your concrete objects from the json object.
                if (Request.Headers.Contains("object1Name"))
                {
                    IEnumerable<string> headerValues = Request.Headers.GetValues("object1Name");
                    var className1 = headerValues.FirstOrDefault();

                    if (className1.Equals("CustomerMaster"))
                    {
                        objCustomer = compoundObject["object1"].ToObject<CustomerMaster>();
                    }
                    else if (className1.ToString().Equals("Search"))
                    {
                        objSearch = compoundObject["object1"].ToObject<Search>();
                    }
                    else if (className1.Equals("Paging"))
                    {
                        objPaging = compoundObject["object1"].ToObject<Paging>();
                    }
                }

                if (Request.Headers.Contains("object2Name"))
                {
                    IEnumerable<string> headerValues = Request.Headers.GetValues("object2Name");
                    var className2= headerValues.FirstOrDefault();

                    if (className2.Equals("CustomerMaster"))
                    {
                        objCustomer = compoundObject["object2"].ToObject<CustomerMaster>();
                    }
                    else if (className2.Equals("Search"))
                    {
                        objSearch = compoundObject["object2"].ToObject<Search>();
                    }
                    else if (className2.Equals("Paging"))
                    {
                        objPaging = compoundObject["object2"].ToObject<Paging>();
                    }
                }
               
                CommonAPI commonApi = new CommonAPI();
                commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
                CustomerDAL customerDAL = new CustomerDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
                
                //////////// Get  the customer List /////////////////
                List<CustomerMaster> objCustomerList=null;
                if (objPaging != null && objSearch !=null)
                {
                    objCustomerList = customerDAL.GetPartnersList(objPaging, out TotalRows, out blnCreate, out blnEdit, out blnDelete, out blnView, objSearch);
                    // Create the response
                    response = Request.CreateResponse(HttpStatusCode.OK, objCustomerList);
                    // Set headers for paging
                    response.Headers.Add("TotalRows", TotalRows.ToString());
                    response.Headers.Add("CreatePermission", blnCreate.ToString());
                    response.Headers.Add("UpdatePermission", blnEdit.ToString());
                    response.Headers.Add("DeletePermission", blnDelete.ToString());
                    response.Headers.Add("ViewPermission", blnView.ToString());
                }
                //////////// Save the customer list/////////////////
                
            }
            catch(Exception ex)
            {
                // log error
                Logger.Error("APIPartnersController.Post(" + userAccount + "," + companyCode + ")", ex);
                 response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }


            return response;
        }

        // PUT: api/APIPartners/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/APIPartners/5
        public void Delete(int id)
        {
        }
    }
}
