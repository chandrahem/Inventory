using IBS.ERP.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;
using IBS.ERP.Models;

namespace IBS.ERP.DataAccess
{
   public class CompanyDAL:baseDAL
    {
        public CompanyDAL() { }

        public CompanyDAL(string connectionStringCompanyDatabase, string userAccount, string roleId, string companyDBProvider, string companyCode)
            : base(connectionStringCompanyDatabase, userAccount, roleId, companyDBProvider, companyCode)
        {

        }
       public List<CompanyMaster> GetCompanies()
       {
           List<CompanyMaster> objCompanies = new List<CompanyMaster>();

           try
           {

               if (DBProvider == ProviderName.SqlClient)
               {

                   IBSparameter Userparameter = new IBSparameter();
                   Userparameter.ParameterName = "@UserAccount";
                   Userparameter.DataType = DbType.String;
                   Userparameter.Value = LoggedInUser;
                   Userparameter.Direction = ParameterDirection.Input;
                   parameters.Add(Userparameter);

               }

               DataSet dsCategory = null;
               dsCategory = GetDataSet("ERP_Get_Companies", parameters);

               var MenuCollection = from CompanyMaster in dsCategory.Tables[0].AsEnumerable()
                                    select new CompanyMaster
                                    {
                                        CompanyId = CompanyMaster.Field<int>("CompanyID"),
                                        CompanyCode = CompanyMaster.Field<String>("CompanyCode"),
                                        CompanyName = CompanyMaster.Field<String>("CompanyName"),
                                        RegistrationNo = CompanyMaster.Field<String>("RegistrationNo"),
                                    };
               objCompanies = MenuCollection.ToList<CompanyMaster>();



           }

           catch (Exception ex)
           {
               Logger.Error("CategoriesDAL.objCategories(" + LoggedInUser + "," + CompanyCode + ")", ex);
           }

           return objCompanies;

       }

       public ReturnResult SaveCompany(CompanyMaster company)
       {
           CompanyMaster objCompany = new CompanyMaster();
           ReturnResult returnResult = new ReturnResult();

           try
           {

               if (DBProvider == ProviderName.SqlClient)
               {
                   IBSparameter CompanyIDParameter = new IBSparameter();
                   CompanyIDParameter.ParameterName = "@CompanyID";
                   CompanyIDParameter.DataType = DbType.String;
                   CompanyIDParameter.Value = company.CompanyId;
                   CompanyIDParameter.Direction = ParameterDirection.Input;
                   parameters.Add(CompanyIDParameter);


                   IBSparameter Userparameter = new IBSparameter();
                   Userparameter.ParameterName = "@UserAccount";
                   Userparameter.DataType = DbType.String;
                   Userparameter.Value = LoggedInUser;
                   Userparameter.Direction = ParameterDirection.Input;
                   parameters.Add(Userparameter);

                   IBSparameter CompanyCodeParameter = new IBSparameter();
                   CompanyCodeParameter.ParameterName = "@CompanyCode";
                   CompanyCodeParameter.DataType = DbType.String;
                   CompanyCodeParameter.Value = company.CompanyCode;
                   CompanyCodeParameter.Direction = ParameterDirection.Input;
                   parameters.Add(CompanyCodeParameter);

                   IBSparameter CompanyNameParameter = new IBSparameter();
                   CompanyNameParameter.ParameterName = "@CompanyName";
                   CompanyNameParameter.DataType = DbType.String;
                   CompanyNameParameter.Value = company.CompanyName;
                   CompanyNameParameter.Direction = ParameterDirection.Input;
                   parameters.Add(CompanyNameParameter);


                   IBSparameter CompanyRegistrationNoParameter = new IBSparameter();
                   CompanyRegistrationNoParameter.ParameterName = "@RegistrationNo";
                   CompanyRegistrationNoParameter.DataType = DbType.String;
                   CompanyRegistrationNoParameter.Value = company.RegistrationNo;
                   CompanyRegistrationNoParameter.Direction = ParameterDirection.Input;
                   parameters.Add(CompanyRegistrationNoParameter);

                   IBSparameter CompanyAddressParameter = new IBSparameter();
                   CompanyAddressParameter.ParameterName = "@Address";
                   CompanyAddressParameter.DataType = DbType.String;
                   CompanyAddressParameter.Value = company.Address;
                   CompanyAddressParameter.Direction = ParameterDirection.Input;
                   parameters.Add(CompanyAddressParameter);

                   IBSparameter CompanyCityParameter = new IBSparameter();
                   CompanyCityParameter.ParameterName = "@City";
                   CompanyCityParameter.DataType = DbType.String;
                   CompanyCityParameter.Value = company.City;
                   CompanyCityParameter.Direction = ParameterDirection.Input;
                   parameters.Add(CompanyCityParameter);


                   IBSparameter Flag = new IBSparameter();
                   Flag.ParameterName = "@Flag";
                   Flag.DataType = DbType.String;
                   Flag.Value = "I";
                   Flag.Direction = ParameterDirection.Input;
                   parameters.Add(Flag);

                   IBSparameter returnParameter = new IBSparameter();
                   returnParameter.ParameterName = "@ReturnValue";
                   returnParameter.DataType = DbType.Int32;
                   returnParameter.Value = "";
                   returnParameter.Direction = ParameterDirection.Output;
                   parameters.Add(returnParameter);


               }

               return ExecuteSqlNonQuery("ERP_Save_Company", parameters);
              

           }

           catch (Exception ex)
           {
               Logger.Error("CompanyDAL.SaveCompany(" + LoggedInUser + "," + CompanyCode + "," + company.CompanyCode + ")", ex);
           }
           return returnResult;

       }

       public ReturnResult DeleteCompany(int companyID)
       {
           ReturnResult returnResult = new ReturnResult();
           try
           {
               
               if (DBProvider == ProviderName.SqlClient)
               {

                   IBSparameter Userparameter = new IBSparameter();
                   Userparameter.ParameterName = "@UserAccount";
                   Userparameter.DataType = DbType.String;
                   Userparameter.Value = LoggedInUser;
                   Userparameter.Direction = ParameterDirection.Input;
                   parameters.Add(Userparameter);



                   IBSparameter CompanyIdParameter = new IBSparameter();
                   CompanyIdParameter.ParameterName = "@CompanyID";
                   CompanyIdParameter.DataType = DbType.String;
                   CompanyIdParameter.Value = companyID;
                   CompanyIdParameter.Direction = ParameterDirection.Input;
                   parameters.Add(CompanyIdParameter);

                   IBSparameter Flag = new IBSparameter();
                   Flag.ParameterName = "@Flag";
                   Flag.DataType = DbType.String;
                   Flag.Value = "D";
                   Flag.Direction = ParameterDirection.Input;
                   parameters.Add(Flag);


                  
               }
               return ExecuteSqlNonQuery("ERP_Save_Company", parameters);
              

           }

           catch (Exception ex)
           {
              // Logger.Error("CategoriesDAL.DeleteCategory(" + LoggedInUser + "," + CompanyCode + "," + categoryid + ")", ex);
           }
           return returnResult;


       }

       public CompanyMaster GetCompanyById(int CompanyID)
       {
           List<CompanyMaster> companyList = new List<CompanyMaster>();
           // List<IBSparameter> parameters = new List<IBSparameter>();

           try
           {

               if (DBProvider == ProviderName.SqlClient)
               {

                   IBSparameter Userparameter = new IBSparameter();
                   Userparameter.ParameterName = "@UserAccount";
                   Userparameter.DataType = DbType.String;
                   Userparameter.Value = LoggedInUser;
                   Userparameter.Direction = ParameterDirection.Input;
                   parameters.Add(Userparameter);



                   IBSparameter CompanyIdParameter = new IBSparameter();
                   CompanyIdParameter.ParameterName = "@CompanyID";
                   CompanyIdParameter.DataType = DbType.String;
                   CompanyIdParameter.Value = CompanyID;
                   CompanyIdParameter.Direction = ParameterDirection.Input;
                   parameters.Add(CompanyIdParameter);

               }

               DataSet dsCategory = null;
               dsCategory = GetDataSet("ERP_Get_CompanyByID", parameters);

               var CompanyCollection = from CompanyMaster in dsCategory.Tables[0].AsEnumerable()
                                        select new CompanyMaster
                                        {
                                            CompanyId = CompanyMaster.Field<int>("CompanyID"),
                                            CompanyCode = CompanyMaster.Field<String>("CompanyCode"),
                                            CompanyName = CompanyMaster.Field<String>("CompanyName"),
                                            RegistrationNo = CompanyMaster.Field<String>("RegistrationNo"),
                                            City = CompanyMaster.Field<String>("City"),
                                            Address = CompanyMaster.Field<String>("Address"),
                                        };
               companyList = CompanyCollection.ToList<CompanyMaster>();
           }

           catch (Exception ex)
           {
               //Logger.Error("CategoriesDAL.GetCategoryById(" + LoggedInUser + "," + CompanyCode + "," + categoryId + ")", ex);
           }

           return companyList[0];

       }
    }
}
