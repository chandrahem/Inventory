using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IBS.ERP.BL;
using System.Web.Routing;
namespace IBS.ERP
{
    public class HasPermission: ActionFilterAttribute
    {
        private string _permission;

        public HasPermission(string permission)
        {
            this._permission = permission;
        }

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            PermissionBL permissionBL = new PermissionBL();

            if (!permissionBL.IsUserHasPermission(_permission))
            {
                var url = new UrlHelper(filterContext.RequestContext);
                string controller = url.Action().Substring(1, url.Action().LastIndexOf('/') - 1);
                RouteValueDictionary redirectTargetDictionary = new RouteValueDictionary();
                redirectTargetDictionary.Add("area", "");
                redirectTargetDictionary.Add("action", "Index");
                redirectTargetDictionary.Add("controller", controller);
                filterContext.Result = new RedirectToRouteResult(redirectTargetDictionary);
                filterContext.Controller.TempData["Message"] = "You do not have rights.";

                //// If this user does not have the required permission then redirect to login page
                //var url = new UrlHelper(filterContext.RequestContext);
                //string controller= url.Action().Substring(0,url.Action().LastIndexOf('/'));
                //var redirectedUrl = url.Content(controller);
                ////var loginUrl = url.Content("/Home/Index");
                //filterContext.HttpContext.Response.Redirect(redirectedUrl, true); 
            }
        }

        //public override void OnResultExecuting(ResultExecutingContext filterContext)
        //{
        //    //base.OnResultExecuting(filterContext);
        //    //if (filterContext.Controller.ControllerContext.Controller.ViewBag.NoPermission == "TRUE")
        //    //   filterContext.Controller.TempData["PermissionMessage"] = "You have no rights.";
        //    ////filterContext.Controller.ControllerContext.Controller.ViewBag.PermissionMesssage = "You have no rights.";
        //}
    }
}