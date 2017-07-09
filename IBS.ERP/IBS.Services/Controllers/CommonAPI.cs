using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IBS.Services.Controllers
{
    public  class CommonAPI
    {
        public void getHeaderValues(dynamic headers, out string connectionString, out string userAccount, out string roleId, out string companyCode, out string DBProviderName)
        {
            connectionString = string.Empty; userAccount = ""; roleId = ""; companyCode = ""; DBProviderName = "";

            //var re = Request;
            //var headers = re.Headers;
            try
            {
                if (headers.Contains("DBConnectionString"))
                {
                    connectionString = headers.GetValues("DBConnectionString")[0];
                }
                if (headers.Contains("UserAccount"))
                {
                    userAccount = headers.GetValues("UserAccount")[0];
                }
                if (headers.Contains("RoleId"))
                {
                    roleId = headers.GetValues("RoleId")[0];
                }
                if (headers.Contains("CompanyCode"))
                {
                    companyCode = headers.GetValues("CompanyCode")[0];
                }
                if (headers.Contains("DBProviderName"))
                {
                    DBProviderName = headers.GetValues("DBProviderName")[0];
                }
            }
            catch(Exception ex)
            {

            }

        }
    }
}