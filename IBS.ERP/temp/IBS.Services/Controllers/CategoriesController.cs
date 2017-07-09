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

                

            }
            catch (Exception ce)
            {
                response = new BaseResponse() { HasError = true, ReturnValue = ce.ToString() };
            }
            return response;

           
        }

        [HttpGet]
        public BaseResponse GetCategories()
        {
            BaseResponse response = new BaseResponse();
            try
            {
                //CategoryBL categroyBL = new CategoryBL();

                //response.ReturnValue = categroyBL.SaveCategory(objCategory);

                int a = 10;
                return response.ReturnValue="value";

            }
            catch (Exception ce)
            {
                response = new BaseResponse() { HasError = true, ReturnValue = ce.ToString() };
            }
            return response;


        }
    }
}
