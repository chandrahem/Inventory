using IBS.ERP.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;

namespace IBS.ERP.Controllers
{
    public  class WebAPI
    {
        public async Task<HttpResponseMessage> CallToWebAPI(APICallType apiCallType, string apiControllerName, string apiActionMethod, string connectionString, string userAccount, string roleId, string companyCode, int Id=0, object objectName=null )
        {
            HttpResponseMessage response = null;
            StringContent content=null;
            string apiPath=string.Empty;
            try
            {


                string webApiBaseUrl = WebConfigurationManager.AppSettings["WebAPIBaseUrl"];

                if (apiActionMethod.Length > 0)
                {
                    apiPath = Id == 0 ? apiControllerName + "/" + apiActionMethod : apiControllerName + "/" + apiActionMethod + "/" + Id;
                }
                else
                {
                    apiPath = Id == 0 ? apiControllerName : apiControllerName + "/" + Id;
                }


                if (objectName != null)
                {
                    content = new StringContent(JsonConvert.SerializeObject(objectName), Encoding.UTF8, "application/json");
                }
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(webApiBaseUrl);
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Add("DBConnectionString", connectionString);
                    client.DefaultRequestHeaders.Add("UserAccount", userAccount);
                    client.DefaultRequestHeaders.Add("RoleId", roleId);
                    client.DefaultRequestHeaders.Add("CompanyCode", companyCode);
                    client.DefaultRequestHeaders.Add("DBProviderName", "System.Data.SqlClient");

                    //connectionStringCompanyDatabase, userAccount, roleId, companyDBProvider, companyCode


                    //client.DefaultRequestHeaders.Add("DBConnectionString", "Data Source=ibsmssqlserver.cezeuiz2wro3.ap-south-1.rds.amazonaws.com,1433; Initial Catalog=UserManagement;User ID=hem;Password=hemchandra");
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    // Insert data
                    if (apiCallType == APICallType.Post)
                    {
                        //StringContent content = new StringContent(JsonConvert.SerializeObject(objectName), Encoding.UTF8, "application/json");
                        response = await client.PostAsync(apiPath, content);
                    } // update data
                    else if (apiCallType == APICallType.Put)
                    {
                        //StringContent content = new StringContent(JsonConvert.SerializeObject(objectName), Encoding.UTF8, "application/json");
                        response = await client.PutAsync(apiPath, content);
                    } // get data
                    else if (apiCallType == APICallType.Get)
                    {
                        response = await client.GetAsync(webApiBaseUrl + apiPath);
                    } // delete data
                    else if (apiCallType == APICallType.Delete)
                    {
                        response = await client.DeleteAsync(webApiBaseUrl + apiPath);
                    }

                }
            }
            catch(Exception ex)
            {
                string a=ex.Message;
            }
            return response;
        }
    }
}