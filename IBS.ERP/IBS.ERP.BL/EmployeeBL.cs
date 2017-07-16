using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IBS.ERP.DataAccess;
using IBS.ERP.Models;

namespace IBS.ERP.BL
{
   public class EmployeeBL
    {
       public List<EmployeeMaster> GetEmployees()
        {
          
            EmployeeDAL Employees = new EmployeeDAL();
            return Employees.GetEmployees();

        }
       public ReturnResult SaveEmployee(EmployeeMaster employee)
        {
            EmployeeDAL Employees = new EmployeeDAL();
            return Employees.SaveEmployee(employee);

        }

        public ReturnResult DeleteEmployee(int companyID)
        {
            EmployeeDAL Employees = new EmployeeDAL();
            return Employees.DeleteEmployee(companyID);

        }

        public EmployeeMaster GetEmployeeById(int EmployeeID)
        {
            EmployeeDAL Employees = new EmployeeDAL();
            return Employees.GetEmployeeById(EmployeeID);

        }
    }
}
