using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IBS.ERP.DataAccess;
using IBS.ERP.Models;
namespace IBS.ERP.BL
{
    public class CompanyBL
    {
        public List<CompanyMaster> GetCompanies()
        {
            CompanyDAL CompanyDAL = new CompanyDAL();
            return CompanyDAL.GetCompanies();

        }
        public ReturnResult SaveCompany(CompanyMaster company)
        {
            CompanyDAL companyDAL = new CompanyDAL();
            return companyDAL.SaveCompany(company);

        }

        public ReturnResult DeleteCompany(int companyID)
        {
            CompanyDAL CompanyDAL = new CompanyDAL();
            return CompanyDAL.DeleteCompany(companyID);

        }

        public CompanyMaster GetCompanyById(int CompanyID)
        {
             CompanyDAL CompanyDAL = new CompanyDAL();
             return CompanyDAL.GetCompanyById(CompanyID);

        }
    }
}
