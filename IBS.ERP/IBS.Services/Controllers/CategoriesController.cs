using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using IBS.ERP.BL;
using IBS.ERP.Models;
namespace IBS.Services.Controllers
{
    public class CategoriesController : ApiController
    {
        /// <summary>
        /// url will exposed as http://localhost:49253/IBSApi/Categories/CreateCategory
        /// </summary>
        /// <param name="objCategory"></param>
        /// <returns></returns>
        [HttpPost]
        public BaseResponse CreateCategory(Category objCategory)
        {
            BaseResponse response = new BaseResponse();
            try
            {
                CategoryBL categroyBL = new CategoryBL();
               
                response.ReturnValue = categroyBL.SaveCategory(objCategory);

                if (response.HasError) { throw new Exception(response.ReturnValue.ToString()); }

            }
            catch (Exception ce)
            {
                response = new BaseResponse() { HasError = true, ReturnValue = ce.ToString() };
            }
            return response;

           
        }
    }
}
