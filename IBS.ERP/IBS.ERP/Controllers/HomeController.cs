using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IBS.ERP.Models;
using IBS.ERP.BL;
namespace IBS.ERP.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            // call the dashboard functionality  SET the Company name in menu Layout
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public List<Menus> GetMenu()
        {
            List<Menus> menuList= new List<Menus>();
          // System.Web.HttpContext.Current.Cache

            if (System.Web.HttpContext.Current.Cache["MenuList"] == null)
            {
                /*Read DB here and populate the list*/
                MenuBL menuBL = new MenuBL();
                menuList = menuBL.getMenuDetail();
                System.Web.HttpContext.Current.Cache["MenuList"] = menuList;
            }
            else
            {
                menuList = (List<Menus>)System.Web.HttpContext.Current.Cache["MenuList"];
            }

            //return PartialView("_Courses", courses);
            return menuList;
        }
    }
}