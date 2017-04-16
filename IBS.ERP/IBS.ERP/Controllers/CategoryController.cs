using IBS.ERP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IBS.ERP.BL;
namespace IBS.ERP.Controllers
{
    public class CategoryController : Controller
    {
        // GET: Category
        [HasPermission("READ_CATEGORY")]
        public ActionResult Index()
        {
            CategoryBL categroyBL = new CategoryBL();
            //Category Category = new Category();
            var categories = categroyBL.GetCategoriesList();

            return View(categories);
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
        public ActionResult Create(FormCollection collection)
        {
            ReturnResult returnResult=  new ReturnResult();
            Category objCategory = new Category();
            try
            {
                // TODO: Add insert logic here
              
                CategoryBL categroyBL = new CategoryBL();
                objCategory.categoryid = 0;
                objCategory.CategoryCode = Convert.ToString(collection["CategoryCode"]);
                objCategory.CategoryName = Convert.ToString(collection["CategoryName"]);
                objCategory.Description = Convert.ToString(collection["Description"]);
                returnResult= categroyBL.SaveCategory(objCategory);
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
            catch
            {
                TempData["CreateCategoryMessage"] = returnResult.Message;
                return View(objCategory);
            }
        }

        // GET: Category/Edit/5
        [HasPermission("UPDATE_CATEGORY")]
        public ActionResult Edit(int id)
        {
            CategoryBL categroyBL = new CategoryBL();
            var categories = categroyBL.GetCategoryById(id);
            return View(categories);
        }

        // POST: Category/Edit/5
        [HttpPost]
        [HasPermission("UPDATE_CATEGORY")]
        public ActionResult Edit(int id, FormCollection collection)
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
                returnResult=categoryBL.SaveCategory(objCategory);


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
            catch(Exception ex)
            {
                Logger.Error("IBS.ERP.Controllers.Edit [HttpPost] ID: "+id, ex);
                TempData["UpdateCategoryMessage"] = returnResult.Message;
                return View(objCategory);
            }
        }

        // GET: Category/Delete/5
        [HasPermission("DELETE_CATEGORY")]
        public ActionResult Delete(int id)
        {
            CategoryBL categoryBL = new CategoryBL();
           ReturnResult result= categoryBL.DeleteCategory(id);
           if (!result.IsSuccess)
           {
               TempData["Message"] = "Error while deleting category.";
           }

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
