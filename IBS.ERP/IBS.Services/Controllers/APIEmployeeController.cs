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
    public class APIEmployeeController : ApiController
    {
        string connectionString = string.Empty, userAccount = "", roleId = "", companyCode = "", DBProviderName = "";
        // GET: api/Category
      
        public HttpResponseMessage Get([FromUri] Paging objPaging, [FromUri] EmployeeMaster objEmployee)
        {
            int TotalRows = 0;
            CommonAPI commonApi = new CommonAPI();
            commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
            EmployeeDAL employeeDAL = new EmployeeDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
            var employees = employeeDAL.GetEmployeesList(objPaging, out TotalRows, objEmployee);
            // Create the response
            var response = Request.CreateResponse(HttpStatusCode.OK, employees);
            // Set headers for paging
            response.Headers.Add("TotalRows", TotalRows.ToString());
            return response;
        }

        public HttpResponseMessage Post([FromBody]JObject compoundObject)
        {
            int TotalRows = 0;
          

            // Extract your concrete objects from the json object.
            var objEmployee = compoundObject["objectName"].ToObject<EmployeeMaster>();
            var objPaging = compoundObject["paging"].ToObject<Paging>();


            CommonAPI commonApi = new CommonAPI();
            commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
            EmployeeDAL employeeDAL = new EmployeeDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
            if (objPaging == null)
            {
                
                List<EmployeeMaster> objEmployeeList = employeeDAL.GetEmployeesList(objPaging, out TotalRows, objEmployee);

                // Create the response
                var response = Request.CreateResponse(HttpStatusCode.OK, objEmployeeList);
                // Set headers for paging
                response.Headers.Add("TotalRows", TotalRows.ToString());

                return response;
            }
            else
            {
                List<EmployeeMaster> objEmpCodeList = employeeDAL.BindEMPCode_Autocomplete(objEmployee);

                // Create the response
                var response = Request.CreateResponse(HttpStatusCode.OK, objEmpCodeList);
                return response;
            }
        }

        

      
    }
}
