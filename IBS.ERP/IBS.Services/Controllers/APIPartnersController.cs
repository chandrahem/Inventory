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
            var categories = categroyDAL.GetPartnersList(objPaging, out TotalRows, out blnCreate , out blnEdit, out blnDelete , out blnView, objCustomer);

            // Create the response
            var response = Request.CreateResponse(HttpStatusCode.OK, categories);
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
            int TotalRows = 0;
            bool blnCreate = false, blnEdit = false, blnDelete = false, blnView = false;

            // Extract your concrete objects from the json object.
            var objCustomer = compoundObject["objectName"].ToObject<CustomerMaster>();
            var objPaging = compoundObject["paging"].ToObject<Paging>();

            
            CommonAPI commonApi = new CommonAPI();
            commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
            CustomerDAL customerDAL = new CustomerDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
            List<CustomerMaster> objCustomerList = customerDAL.GetPartnersList(objPaging, out TotalRows, out blnCreate, out blnEdit, out blnDelete, out blnView, objCustomer);
          
            // Create the response
            var response = Request.CreateResponse(HttpStatusCode.OK, objCustomerList);
            // Set headers for paging
            response.Headers.Add("TotalRows", TotalRows.ToString());
            response.Headers.Add("CreatePermission", blnCreate.ToString());
            response.Headers.Add("UpdatePermission", blnEdit.ToString());
            response.Headers.Add("DeletePermission", blnDelete.ToString());
            response.Headers.Add("ViewPermission", blnView.ToString());

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
