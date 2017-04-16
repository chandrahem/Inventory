using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IBS.ERP.BL;
using IBS.ERP.Models;
namespace IBS.ERP.Controllers
{
    public class ProductController : Controller
    {
        // GET: Product
        [HasPermission("READ_PRODUCT")]
        public ActionResult Index()
        {
            ProductBL productBL = new ProductBL();
            //Category Category = new Category();
            var products = productBL.GetProductList();
            return View(products);
        }

        // GET: Product/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Product/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Product/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            ReturnResult returnResult = new ReturnResult();
            ProductMaster objProduct = new ProductMaster();
            try
            {
                // TODO: Add insert logic here

                ProductBL productBL = new ProductBL();
                objProduct.ProductId = 0;
                objProduct.ProductName = Convert.ToString(collection["ProductName"]);
                objProduct.ProductCode = Convert.ToString(collection["ProductCode"]);
                objProduct.BarCode = Convert.ToString(collection["BarCode"]);
                objProduct.CategoryId = Convert.ToInt32(collection["CategoryId"]);
                objProduct.SupplierId = Convert.ToInt32(collection["SupplierId"]);
                //objProduct.UOM = Convert.ToInt32(collection["UOM"]);
                objProduct.CompanyPrice = Convert.ToDecimal(collection["CompanyPrice"]);
                objProduct.RePOorderLevel = Convert.ToInt32(collection["RePOorderLevel"]);
                objProduct.RePOorderQuantity = Convert.ToInt32(collection["RePOorderQuantity"]);
                returnResult = productBL.SaveProduct(objProduct);
                if (returnResult.IsSuccess)
                {
                    return RedirectToAction("Index");
                }
                else
                {
                    TempData["CreateProductMessage"] = returnResult.Message;
                    return View(objProduct);
                }
            }
            catch
            {
                TempData["CreateProductMessage"] = returnResult.Message;
                return View(objProduct);
            }
        }

        // GET: Product/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Product/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Product/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Product/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
