using IBS.ERP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using IBS.ERP.BL;

namespace IBS.ERP.Controllers
{
    public class EmployeeController : Controller
    {
        // GET: Employee
        public ActionResult Index()
        {
            EmployeeBL employeeBL = new EmployeeBL();

            var Employees = employeeBL.GetEmployees();

            return View(Employees);

        }

    } 
}