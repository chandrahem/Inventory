using IBS.ERP.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IBS.ERP.DataAccess
{
    public  class CommonDAL : baseDAL
    {
         public CommonDAL() { }

         public CommonDAL(string connectionStringCompanyDatabase, string userAccount, string roleId, string companyDBProvider, string companyCode)
            : base(connectionStringCompanyDatabase, userAccount, roleId, companyDBProvider, companyCode){}



         public List<Lookup> GetLookupList(string lookupType)
         {
             List<Lookup> objLookupList = new List<Lookup>();

             try
             {

                 if (DBProvider == ProviderName.SqlClient)
                 {

                     IBSparameter Userparameter = new IBSparameter();
                     Userparameter.ParameterName = "@LookupType";
                     Userparameter.DataType = DbType.String;
                     Userparameter.Value = lookupType;
                     Userparameter.Direction = ParameterDirection.Input;
                     parameters.Add(Userparameter);

                 }
                 else if (DBProvider == ProviderName.MySqlClient)
                 {
                     
                 }

                 DataSet dsLookup = null;
                 dsLookup = GetDataSet("ERP_Get_LookUpData", parameters);

                 var menuCollection = from Lookup in dsLookup.Tables[0].AsEnumerable()
                                      select new Lookup
                                      {
                                          //LookupId = Lookup.Field<int>("Lookupid"),
                                          Code = Lookup.Field<String>("Code"),
                                          Text = Lookup.Field<String>("Text"),
                                      };
                 objLookupList = menuCollection.ToList<Lookup>();



             }

             catch (Exception ex)
             {
                 Logger.Error("CommonDAL.GetLookupList(" + LoggedInUser + "," + CompanyCode + ")", ex);
             }

             return objLookupList;

         }

    }
}
