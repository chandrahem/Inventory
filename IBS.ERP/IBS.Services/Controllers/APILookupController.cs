using IBS.ERP.DataAccess;
using IBS.ERP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace IBS.Services.Controllers
{
    [RoutePrefix("api/APILookup")]
    public class APILookupController : ApiController
    {
        string connectionString = string.Empty, userAccount = "", roleId = "", companyCode = "", DBProviderName = "";



        //[HttpGet]
        //public IEnumerable<Lookup> Get(int id)
        //{
        //    string lookType = "POStatus";
        //    CommonAPI commonApi = new CommonAPI();
        //    commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
        //    CommonDAL commonDAL = new CommonDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
        //    var lookupList = commonDAL.GetLookupList(lookType);
        //    return lookupList;
        //}


        [HttpGet]
        [Route("{lookupType}")]
        public HttpResponseMessage Get(string lookupType)
        {
            HttpResponseMessage response;
            try
            {
                CommonAPI commonApi = new CommonAPI();
                commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
                CommonDAL commonDAL = new CommonDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
                var lookupList = commonDAL.GetLookupList(lookupType);

                response = Request.CreateResponse(HttpStatusCode.OK, lookupList);
            }
            catch(Exception ex)
            {
                response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
            return response;
        }
    }
}
