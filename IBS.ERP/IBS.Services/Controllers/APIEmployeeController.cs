using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using IBS.ERP.DataAccess;
using IBS.ERP.Models;

namespace IBS.Services.Controllers
{
    public class APIEmployeeController : ApiController
    {
        string connectionString = string.Empty, userAccount = "", roleId = "", companyCode = "", DBProviderName = "";
        // GET: api/Category
        [HttpGet]
        public IEnumerable<EmployeeMaster> Get()
        {
            CommonAPI commonApi = new CommonAPI();
            commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
            EmployeeDAL employeeDAL = new EmployeeDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
            var employees = employeeDAL.GetEmployees();
            return employees;
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
        public ReturnResult Post([FromBody]EmployeeMaster objEmployee)
        {
            CommonAPI commonApi = new CommonAPI();
            commonApi.getHeaderValues(Request.Headers, out connectionString, out userAccount, out roleId, out companyCode, out DBProviderName);
            EmployeeDAL employeeDAL = new EmployeeDAL(connectionString, userAccount, roleId, DBProviderName, companyCode);
            ReturnResult returnResult = employeeDAL.SaveEmployee(objEmployee);
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

      
    }
}
