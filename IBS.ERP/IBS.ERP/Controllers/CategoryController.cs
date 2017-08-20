using IBS.ERP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IBS.ERP.BL;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Net.Http.Headers;
namespace IBS.ERP.Controllers
{
    public class CategoryController : Controller
    {
        // GET: Category
        [HasPermission("READ_CATEGORY")]
        public async Task<ActionResult>  Index()
        {
            
            WebAPI webapi = new WebAPI();
            HttpResponseMessage response = await webapi.CallToWebAPI(APICallType.Get, "APICategory", "", Convert.ToString(Session["DBConnectionString"]), Convert.ToString(Session["UserAccount"]), Convert.ToString(Session["RoleId"]), Convert.ToString(Session["CompanyCode"]));
            if (response.IsSuccessStatusCode)
            {

                //get the headers values
                HttpHeaders headers = response.Headers;
                IEnumerable<string> values;
                if (headers.TryGetValues("PageNo", out values))
                {
                    string session = values.First();
                }

                // get the content values
                var data = await response.Content.ReadAsStringAsync();
                               
                // to convert json  in data table
                //var table = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(data);

                // convert json in IEnumerable object list of category
                var categories = JsonConvert.DeserializeObject<IEnumerable<Category>>(data);
                
                return View(categories);
            }
            else
            {
                return View();
            }

                      
        }

        // GET: Category/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Category/Create
        [HasPermission("CREATE_CATEGORY")]
        public ActionResult Create()
        {
            
            return View();
        }

        // POST: Category/Create
        [HttpPost]
        [HasPermission("CREATE_CATEGORY")]
        public async Task<ActionResult> Create(FormCollection collection)
        {
            ReturnResult returnResult=  new ReturnResult();
            Category objCategory = new Category();
            try
            {
                // TODO: Add insert logic here
                objCategory.categoryid = 0;
                objCategory.CategoryCode = Convert.ToString(collection["CategoryCode"]);
                objCategory.CategoryName = Convert.ToString(collection["CategoryName"]);
                objCategory.Description = Convert.ToString(collection["Description"]);

                WebAPI webapi = new WebAPI();
                HttpResponseMessage response = await webapi.CallToWebAPI(APICallType.Post, "APICategory", "", Convert.ToString(Session["DBConnectionString"]), Convert.ToString(Session["UserAccount"]), Convert.ToString(Session["RoleId"]), Convert.ToString(Session["CompanyCode"]), "0", objCategory);
                if (response.IsSuccessStatusCode)
                {
                    var data = await response.Content.ReadAsStringAsync();

                    // convert json in IEnumerable object list of category
                    returnResult = JsonConvert.DeserializeObject<ReturnResult>(data);

                    if (returnResult.IsSuccess)
                    {
                        return RedirectToAction("Index");
                    }
                    else
                    {
                        TempData["CreateCategoryMessage"] = returnResult.Message;
                        return View(objCategory);
                    }
                }
                else
                {
                    TempData["CreateCategoryMessage"] = "Error while saving data.";
                    return View(objCategory);
                }
              
               // CategoryBL categroyBL = new CategoryBL();
               
               // returnResult= categroyBL.SaveCategory(objCategory);
               //if (returnResult.IsSuccess)
               //{
               //    return RedirectToAction("Index");
               //}
               // else
               //{
               //    TempData["CreateCategoryMessage"] = returnResult.Message;
               //    return View(objCategory); 
               //}
            }
            catch
            {
                TempData["CreateCategoryMessage"] = returnResult.Message;
                return View(objCategory);
            }
        }

        // GET: Category/Edit/5
        [HasPermission("UPDATE_CATEGORY")]
        public async Task<ActionResult> Edit(int id)
        {


            WebAPI webapi = new WebAPI();
            HttpResponseMessage response = await webapi.CallToWebAPI(APICallType.Get, "APICategory", "", Convert.ToString(Session["DBConnectionString"]), Convert.ToString(Session["UserAccount"]), Convert.ToString(Session["RoleId"]), Convert.ToString(Session["CompanyCode"]),id.ToString());
            if (response.IsSuccessStatusCode)
            {
                var data = await response.Content.ReadAsStringAsync();

                // to convert json  in data table
                //var table = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(data);

                // convert json in IEnumerable object list of category
                var categories = JsonConvert.DeserializeObject<Category>(data);

                return View(categories);
            }
            else
            {
                return View();
            }
            
            //CategoryBL categroyBL = new CategoryBL();
            //var categories = categroyBL.GetCategoryById(id);
            //return View(categories);
        }

        // POST: Category/Edit/5
        [HttpPost]
        [HasPermission("UPDATE_CATEGORY")]
        public async Task<ActionResult> Edit(int id, FormCollection collection)
        {
            ReturnResult returnResult = new ReturnResult();
            Category objCategory = new Category();
            try
            {
                // Just to check the error log
                //int a = 0, b=1,c;
                //c = b / a;

                
                CategoryBL categoryBL = new CategoryBL();
                objCategory.categoryid = id;
                objCategory.CategoryCode = Convert.ToString(collection["CategoryCode"]);
                objCategory.CategoryName = Convert.ToString(collection["CategoryName"]);
                objCategory.Description = Convert.ToString(collection["Description"]);
                //returnResult=categoryBL.SaveCategory(objCategory);

                WebAPI webapi = new WebAPI();
                HttpResponseMessage response = await webapi.CallToWebAPI(APICallType.Put, "APICategory", "", Convert.ToString(Session["DBConnectionString"]), Convert.ToString(Session["UserAccount"]), Convert.ToString(Session["RoleId"]), Convert.ToString(Session["CompanyCode"]), id.ToString(), objCategory);
                if (response.IsSuccessStatusCode)
                {

                    var data = await response.Content.ReadAsStringAsync();

                    // convert json in IEnumerable object list of category
                    returnResult = JsonConvert.DeserializeObject<ReturnResult>(data);

                    if (returnResult.IsSuccess)
                    {
                        return RedirectToAction("Index");
                    }
                    else
                    {
                        TempData["UpdateCategoryMessage"] = returnResult.Message;
                        return View(objCategory);
                    }
                }
                else
                {
                    TempData["UpdateCategoryMessage"] = "Error while saving data.";
                    return View(objCategory);
                }

                
            }
            catch(Exception ex)
            {
                Logger.Error("IBS.ERP.Controllers.Edit [HttpPost] ID: "+id, ex);
                TempData["UpdateCategoryMessage"] = returnResult.Message;
                return View(objCategory);
            }
        }

        // GET: Category/Delete/5
        [HasPermission("DELETE_CATEGORY")]
        public async Task<ActionResult> Delete(int id)
        {

            WebAPI webapi = new WebAPI();
            HttpResponseMessage response = await webapi.CallToWebAPI(APICallType.Delete, "APICategory", "", Convert.ToString(Session["DBConnectionString"]), Convert.ToString(Session["UserAccount"]), Convert.ToString(Session["RoleId"]), Convert.ToString(Session["CompanyCode"]), id.ToString() );
            if (response.IsSuccessStatusCode)
            {
                var data = await response.Content.ReadAsStringAsync();

                // convert json in IEnumerable object list of category
               ReturnResult returnResult = JsonConvert.DeserializeObject<ReturnResult>(data);

                if (returnResult.IsSuccess)
                {
                    TempData["Message"] = "Category deleted successfully.";// returnResult.Message;// 
                }
                else
                {
                    TempData["Message"] = "Error while deleting category.";// = returnResult.Message;
                }
            }
            else
            {
                TempData["Message"] = "Error while deleting category.";
            }


           // CategoryBL categoryBL = new CategoryBL();
           //ReturnResult result= categoryBL.DeleteCategory(id);
           //if (!result.IsSuccess)
           //{
           //    TempData["Message"] = "Error while deleting category.";
           //}

           return RedirectToAction("Index");
            //return View();
        }

        //// POST: Category/Delete/5
        //[HttpPost]
        //[HasPermission("DELETE_CATEGORY")]
        //public ActionResult Delete(int id, FormCollection collection)
        //{
        //    try
        //    {
        //        // TODO: Add delete logic here

        //        return RedirectToAction("Index");
        //    }
        //    catch
        //    {
        //        return View();
        //    }
        //}
    }
}
