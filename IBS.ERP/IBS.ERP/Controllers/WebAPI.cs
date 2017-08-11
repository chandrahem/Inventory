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
        // Currently we are passing two objects 1. entity or general object and Paging , if we need to pass more objects other than Paging then we need to wrap those objects from where we are calling this method  and passed.
        //and create object of those in respective API Controller. same like  we are passing wraping objects in webapi (WebAPIPassingClass) and creating general or entity and paging object  in api controller
        public async Task<HttpResponseMessage> CallToWebAPI(APICallType apiCallType, string apiControllerName, string apiActionMethod, string connectionString, string userAccount, string roleId, string companyCode, int Id=0, object objectName=null, Paging objPaging=null)
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

                if (objectName != null && objPaging != null)
                {

                    WebAPIPassingClass wepApiPassingobj = new WebAPIPassingClass();
                    wepApiPassingobj.objectName = (Object)objectName;
                    wepApiPassingobj.paging = (Paging)objPaging;

                    //HttpContent content
                    content = new StringContent(JsonConvert.SerializeObject(wepApiPassingobj), Encoding.UTF8, "application/json");

                }
                else
                if (objectName != null)
                {
                    content = new StringContent(JsonConvert.SerializeObject(objectName), Encoding.UTF8, "application/json");
                }


                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(webApiBaseUrl);

                    // Passing the values in header
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Add("DBConnectionString", connectionString);
                    client.DefaultRequestHeaders.Add("UserAccount", userAccount);
                    client.DefaultRequestHeaders.Add("RoleId", roleId);
                    client.DefaultRequestHeaders.Add("CompanyCode", companyCode);
                    client.DefaultRequestHeaders.Add("DBProviderName", "System.Data.SqlClient");
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    // Insert data or In case of showing data in grid pass filter data and paging data use Post
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

    public class WebAPIPassingClass
    {
        public Object objectName { get; set; }
        public Paging paging { get; set; }
    }
}