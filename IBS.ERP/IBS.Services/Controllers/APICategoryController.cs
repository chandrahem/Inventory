using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using IBS.ERP.DataAccess;
using IBS.ERP.Models;

namespace IBS.Services.Controllers
{
    public class APICategoryController : ApiController
    {
        string connectionString = string.Empty, userAccount = "", roleId = "", companyCode = "", DBProviderName = "";
        // GET: api/Category
        [HttpGet]
        public IEnumerable<Category> Get()
        {
            CommonAPI commonApi = new CommonAPI();
            commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
            CategoriesDAL categroyDAL = new CategoriesDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
            var categories = categroyDAL.GetCategories();
            return categories;
        }

        // GET: api/Category/5
        [HttpGet]
        public Category Get(int id)
        {
            CommonAPI commonApi = new CommonAPI();
            commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
            CategoriesDAL categroyDAL = new CategoriesDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
            var category = categroyDAL.GetCategoryById(id);
            return category;
        }

        // POST: api/Category
        [HttpPost]
        public ReturnResult Post([FromBody]Category objCategory)
        {
            CommonAPI commonApi = new CommonAPI();
            commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
            CategoriesDAL categroyDAL = new CategoriesDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
            ReturnResult returnResult = categroyDAL.SaveCategory(objCategory);
            return returnResult;
        }

        // PUT: api/Category/5
        [HttpPut]
        public ReturnResult Put(int id, [FromBody]Category objCategory)
        {
            CommonAPI commonApi = new CommonAPI();
            commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
            CategoriesDAL categroyDAL = new CategoriesDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
            ReturnResult returnResult = categroyDAL.SaveCategory(objCategory);
            return returnResult;
        }

        // DELETE: api/Category/5
        [HttpDelete]
        public ReturnResult Delete(int id)
        {
            CommonAPI commonApi = new CommonAPI();
            commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
            CategoriesDAL categroyDAL = new CategoriesDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
            ReturnResult returnResult = categroyDAL.DeleteCategory(id);
            return returnResult;
        }

        //public void CallHeaderValues(out string connectionString, out string userAccount, out string roleId, out string companyCode, out string DBProviderName)
        //{
        //    connectionString = string.Empty; userAccount = ""; roleId = ""; companyCode = ""; DBProviderName = "";

        //    var re = Request;
        //    var headers = re.Headers;

        //    if (headers.Contains("DBConnectionString"))
        //    {
        //        connectionString = headers.GetValues("DBConnectionString").First();
        //    }
        //    if (headers.Contains("UserAccount"))
        //    {
        //        userAccount = headers.GetValues("UserAccount").First();
        //    }
        //    if (headers.Contains("RoleId"))
        //    {
        //        roleId = headers.GetValues("RoleId").First();
        //    }
        //    if (headers.Contains("CompanyCode"))
        //    {
        //        companyCode = headers.GetValues("CompanyCode").First();
        //    }
        //    if (headers.Contains("DBProviderName"))
        //    {
        //        DBProviderName = headers.GetValues("DBProviderName").First();
        //    }


        //}
    }
}
