using System;
using System.Globalization;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using IBS.ERP.BL;
using IBS.ERP.Models;
using System.Collections.Generic;
using System.Web.Security;

namespace IBS.ERP.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
       

        public AccountController()
        {
        }

        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }



        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel model, string returnUrl)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            // This doesn't count login failures towards account lockout
            // To enable password failures to trigger account lockout, change to shouldLockout: true
            UserBL userBL = new UserBL();
            List<LoginViewModel> loginView=  userBL.getUserLoginDetail(model);
            if (loginView != null && loginView.Count > 0)
            {
                var result = (SignInStatus)Enum.Parse(typeof(SignInStatus),loginView[0].SignInStatus);   
                switch (result)
                {
                    case SignInStatus.Success:
                        FormsAuthentication.SetAuthCookie(model.UserAccount, true);
                        System.Web.HttpContext.Current.Session["DBConnectionString"] = loginView[0].DBConnectionString;
                        System.Web.HttpContext.Current.Session["DBProviderName"] = loginView[0].DBProviderName;
                        System.Web.HttpContext.Current.Session["RoleId"] = loginView[0].RoleId;
                        System.Web.HttpContext.Current.Session["UserAccount"] = loginView[0].UserAccount;
                        System.Web.HttpContext.Current.Session["CompanyCode"] = loginView[0].CompanyCode; 
                        return RedirectToLocal(returnUrl);
                    case SignInStatus.LockedOut:
                        return View("Lockout");
                    case SignInStatus.RequiresVerification:
                        return View(model); // return RedirectToAction("SendCode", new { ReturnUrl = returnUrl, RememberMe = model.RememberMe });
                    case SignInStatus.Failure:
                        return View(model);
                    default:
                        ModelState.AddModelError("", "Invalid login attempt.");
                        return View(model);
                }
                //FormsAuthentication.SetAuthCookie(model.useraccount, createPersistentCookie);
                
            }
            else
            {
                return View(model);
            }
           
        }

       

        //
        // GET: /Account/Register
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }

        ////
        //// POST: /Account/Register
        //[HttpPost]
        //[AllowAnonymous]
        //[ValidateAntiForgeryToken]
        //public async Task<ActionResult> Register(RegisterViewModel model)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        //var user = new ApplicationUser { UserName = model.Email, Email = model.Email };
        //        //var result = await UserManager.CreateAsync(user, model.Password);
        //        //if (result.Succeeded)
        //        //{
        //        //    await SignInManager.SignInAsync(user, isPersistent:false, rememberBrowser:false);
                    
        //        //    // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
        //        //    // Send an email with this link
        //        //    // string code = await UserManager.GenerateEmailConfirmationTokenAsync(user.Id);
        //        //    // var callbackUrl = Url.Action("ConfirmEmail", "Account", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);
        //        //    // await UserManager.SendEmailAsync(user.Id, "Confirm your account", "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>");

        //        //    return RedirectToAction("Index", "Home");
        //        //}
        //        //AddErrors(result);
        //    }

        //    // If we got this far, something failed, redisplay form
        //    return View(model);
        //}

     

        //
        // GET: /Account/ForgotPassword
        [AllowAnonymous]
        public ActionResult ForgotPassword()
        {
            return View();
        }

        ////
        //// POST: /Account/ForgotPassword
        //[HttpPost]
        //[AllowAnonymous]
        //[ValidateAntiForgeryToken]
        //public async Task<ActionResult> ForgotPassword(ForgotPasswordViewModel model)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        //var user = await UserManager.FindByNameAsync(model.Email);
        //        //if (user == null || !(await UserManager.IsEmailConfirmedAsync(user.Id)))
        //        //{
        //        //    // Don't reveal that the user does not exist or is not confirmed
        //        //    return View("ForgotPasswordConfirmation");
        //        //}

        //        // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
        //        // Send an email with this link
        //        // string code = await UserManager.GeneratePasswordResetTokenAsync(user.Id);
        //        // var callbackUrl = Url.Action("ResetPassword", "Account", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);		
        //        // await UserManager.SendEmailAsync(user.Id, "Reset Password", "Please reset your password by clicking <a href=\"" + callbackUrl + "\">here</a>");
        //        // return RedirectToAction("ForgotPasswordConfirmation", "Account");
        //    }

        //    // If we got this far, something failed, redisplay form
        //    return View(model);
        //}

        //
        // GET: /Account/ForgotPasswordConfirmation
        [AllowAnonymous]
        public ActionResult ForgotPasswordConfirmation()
        {
            return View();
        }

        //
        // GET: /Account/ResetPassword
        [AllowAnonymous]
        public ActionResult ResetPassword(string code)
        {
            return code == null ? View("Error") : View();
        }

        ////
        //// POST: /Account/ResetPassword
        //[HttpPost]
        //[AllowAnonymous]
        //[ValidateAntiForgeryToken]
        //public async Task<ActionResult> ResetPassword(ResetPasswordViewModel model)
        //{
        //    if (!ModelState.IsValid)
        //    {
        //        return View(model);
        //    }
        //    //var user = await UserManager.FindByNameAsync(model.Email);
        //    //if (user == null)
        //    //{
        //    //    // Don't reveal that the user does not exist
        //    //    return RedirectToAction("ResetPasswordConfirmation", "Account");
        //    //}
        //    //var result = await UserManager.ResetPasswordAsync(user.Id, model.Code, model.Password);
        //    //if (result.Succeeded)
        //    //{
        //    //    return RedirectToAction("ResetPasswordConfirmation", "Account");
        //    //}
        //    //AddErrors(result);
        //    return View();
        //}

        //
        // GET: /Account/ResetPasswordConfirmation
        [AllowAnonymous]
        public ActionResult ResetPasswordConfirmation()
        {
            return View();
        }

        //
        // POST: /Account/ExternalLogin
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult ExternalLogin(string provider, string returnUrl)
        {
            // Request a redirect to the external login provider
            return new ChallengeResult(provider, Url.Action("ExternalLoginCallback", "Account", new { ReturnUrl = returnUrl }));
        }

      
       
        

       

        //
        // POST: /Account/LogOff
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            AuthenticationManager.SignOut();
            return RedirectToAction("Index", "IBSHome");
        }

        //
        // GET: /Account/ExternalLoginFailure
        [AllowAnonymous]
        public ActionResult ExternalLoginFailure()
        {
            return View();
        }

        #region Helpers
        // Used for XSRF protection when adding external logins
        private const string XsrfKey = "XsrfId";

        private IAuthenticationManager AuthenticationManager
        {
            get
            {
                return HttpContext.GetOwinContext().Authentication;
            }
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Index", "Home");
        }

        internal class ChallengeResult : HttpUnauthorizedResult
        {
            public ChallengeResult(string provider, string redirectUri)
                : this(provider, redirectUri, null)
            {
            }

            public ChallengeResult(string provider, string redirectUri, string userId)
            {
                LoginProvider = provider;
                RedirectUri = redirectUri;
                UserId = userId;
            }

            public string LoginProvider { get; set; }
            public string RedirectUri { get; set; }
            public string UserId { get; set; }

            public override void ExecuteResult(ControllerContext context)
            {
                var properties = new AuthenticationProperties { RedirectUri = RedirectUri };
                if (UserId != null)
                {
                    properties.Dictionary[XsrfKey] = UserId;
                }
                context.HttpContext.GetOwinContext().Authentication.Challenge(properties, LoginProvider);
            }
        }
        #endregion
    }
}