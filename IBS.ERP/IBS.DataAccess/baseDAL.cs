﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using IBS.ERP.Models;
using System.Data.SqlClient;
namespace IBS.ERP.DataAccess
{
    public  class baseDAL
    {


       public ProviderName DBProvider;
       public string LoggedInUser {get; set;}
       public Int16 UserRoleId { get; set; }
       public List<IBSparameter> parameters = null;
       public string CompanyCode { get; set; }
       private string strProviderName = string.Empty;//"SqlClient";
       public DbConnection conn;
       public SqlCommand sqlcmd;
       private ConnectionStringSettings conS = null;
      
      public baseDAL()
       {
           parameters = new List<IBSparameter>();
           string CompanyDatabaseConnectionString = string.Empty;

           if (System.Web.HttpContext.Current.Session["DBConnectionString"] != null)
               CompanyDatabaseConnectionString = Convert.ToString(System.Web.HttpContext.Current.Session["DBConnectionString"]);
          
           // Check Connection string from Context if it is not there then use from config 
           if (CompanyDatabaseConnectionString.Length > 0)
           {
               LoggedInUser = Convert.ToString(System.Web.HttpContext.Current.Session["UserAccount"]);
               UserRoleId = Convert.ToInt16(System.Web.HttpContext.Current.Session["RoleId"]);

               string CompanyDatabaseProvider = Convert.ToString(System.Web.HttpContext.Current.Session["DBProviderName"]);
               CompanyCode = Convert.ToString(System.Web.HttpContext.Current.Session["CompanyCode"]);
               conS = getConnection(CompanyCode, CompanyDatabaseConnectionString, CompanyDatabaseProvider);
               strProviderName = conS.ProviderName;
               conn = CreateDbConnection(strProviderName, conS.ConnectionString);
               DBProvider = (ProviderName)Enum.Parse(typeof(ProviderName), getLastNameOfDBProvider(strProviderName));
           }
           else // if there is no comapny database exist then connect to userManagement
           {
               SetUserManagementDatabaseInfo();
           }
       }

        /// <summary>
        /// It is used to create connection object of the Usermanagement database i.e. conn
        /// </summary>
        /// <param name="connectionStringUserDatabase"></param>
      public baseDAL(string connectionStringUserDatabase)
      {
          SetUserManagementDatabaseInfo();
      }
    /// <summary>
      /// It is used to create company database connection object i.e  conn
    /// </summary>
    /// <param name="connectionStringCompanyDatabase"></param>
    /// <param name="userAccount"></param>
    /// <param name="roleId"></param>
    /// <param name="companyDBProvider"></param>
    /// <param name="companyCode"></param>
      public baseDAL(string connectionStringCompanyDatabase, string userAccount, string roleId, string companyDBProvider, string companyCode)
      {
          parameters = new List<IBSparameter>();


          //if(System.Web.HttpContext.Current.Session["DBConnectionString"] != null)
          //   CompanyDatabaseConnectionString = Convert.ToString(System.Web.HttpContext.Current.Session["DBConnectionString"]);

          // Check Connection string from Context if it is not there then use from config 
          if (connectionStringCompanyDatabase.Length > 0)
          {
              LoggedInUser = userAccount;
              UserRoleId = Convert.ToInt16(roleId);

              string CompanyDatabaseProvider = companyDBProvider;
              CompanyCode = companyCode;
              conS = getConnection(CompanyCode, connectionStringCompanyDatabase, CompanyDatabaseProvider);
              strProviderName = conS.ProviderName;
              conn = CreateDbConnection(strProviderName, conS.ConnectionString);
              DBProvider = (ProviderName)Enum.Parse(typeof(ProviderName), getLastNameOfDBProvider(strProviderName));
          }
          else // if there is no comapny database exist then connect to userManagement
          {
              SetUserManagementDatabaseInfo();
          }
      }
     

      // Given a provider name and connection string, 
       //http://odetodata.com/2015/05/a-better-way-to-handle-role-permissions-in-asp-net-identity-isinrole-vs-haspermission/
      //http://benjii.me/2016/07/using-sessions-and-httpcontext-in-aspnetcore-and-mvc-core/
       // create the DbProviderFactory and DbConnection.
       // Returns a DbConnection on success; null on failure.
       
       private DbConnection CreateDbConnection(string providerName, string connectionString)
       {
           // Assume failure.
           conn = null;
           // Create the DbProviderFactory and DbConnection.
           if (connectionString != null)
           {
               try
               {
                   if(DBProvider==ProviderName.SqlClient) //if sql server
                   {
                       conn = new SqlConnection();//factory.CreateConnection();
                       sqlcmd = new  SqlCommand();
                       sqlcmd.Connection =(SqlConnection)conn;
                       
                   }
                   else // if my sql server
                   {
                       DbProviderFactory factory = DbProviderFactories.GetFactory(providerName);
                       conn = factory.CreateConnection();
                       //cmd = conn.CreateCommand();
                   }
                   
                   conn.ConnectionString = connectionString;
               }
               catch (Exception ex)
               {
                   // Set the connection to null if it was created.
                   if (conn != null)
                   {
                       conn = null;
                   }
                  
               }
           }
           // Return the connection.
           return conn;
       }

       public ReturnResult ExecuteSqlNonQuery(string SPName, List<IBSparameter> parameters)
       {
           ReturnResult returnResult = new ReturnResult();
           int intEffected=0;
           try
           {
               if (conn != null)
               {
                   conn.Open();
               }

               DbCommand cmd = conn.CreateCommand();
               cmd.CommandText = SPName.ToString();
               cmd.CommandType = CommandType.StoredProcedure;
               foreach (IBSparameter p in parameters)
               {

                   DbParameter dbPrm = cmd.CreateParameter();
                   dbPrm.ParameterName = p.ParameterName;
                   dbPrm.DbType = p.DataType;
                   dbPrm.Value = p.Value;
                   dbPrm.Direction = p.Direction;
                   cmd.Parameters.Add(dbPrm);
                   //cmd.AddInParameter(p.ParameterName, p.DbType, p.Value);
               }

               cmd.Connection = conn;
               intEffected=cmd.ExecuteNonQuery();
               //Retrieve the value of the output parameter
               int returnValue = Convert.ToInt32(cmd.Parameters[cmd.Parameters.Count - 1].Value);

               //if (intEffected == -99)
               //{
                   if (returnValue == -99)
                   {
                       returnResult.ID = 0;
                       returnResult.IsSuccess = false;
                       returnResult.Message = "Code already exists.";
                   }
                   else if (returnValue > 0) //&& intEffected>0
                   {
                       returnResult.ID = returnValue;
                       returnResult.IsSuccess = true;
                       returnResult.Message = "Data saved successfully.";
                   }
                   else if (returnValue == -9)
                   {
                       returnResult.ID = 0;
                       returnResult.IsSuccess = false;
                       returnResult.Message = "Error while saving.";
                   }
                   else
                    {
                        returnResult.ID = returnValue;
                        returnResult.IsSuccess = false;
                        returnResult.Message = "Error while saving.";
                    }


               //}
               //else
               //{
               //    returnResult.ID = returnValue;
               //    returnResult.IsSuccess = true;
               //    returnResult.Message = "Data saved successfully.";
               //}
           }
           catch (Exception ex)
           {
               Logger.Error("baseDAL.ExecuteSqlNonQuery(" + LoggedInUser + "," + CompanyCode + ")", ex);
               returnResult.ID = -1;
               returnResult.IsSuccess = false;
               returnResult.Message = "Error while saving data.";
               return returnResult;
           }
           finally
           {
               conn.Close();
           }

           return returnResult;

       }

       public  DataSet GetDataSet(string SPName, List<IBSparameter> parameters)
       {

           try
           {
               if (conn != null)
               {
                   conn.Open();
               }
           }
           catch (Exception ex)
           {
               //strError = ex.Message;
               return null;
           }

           DataSet dataSet = new DataSet();
           DbProviderFactory factory = DbProviderFactories.GetFactory(strProviderName);

           try
           {    //System.Data.Common.DbCommand
               DbDataAdapter dbAdapter = factory.CreateDataAdapter();

               DbCommand cmd = conn.CreateCommand();
               cmd.CommandText = SPName;
               cmd.CommandType = CommandType.StoredProcedure;   // If procedure you can use -> CALL procName (@param1,...,@paramN)
               foreach (IBSparameter p in parameters)
               {
                 
                  DbParameter dbPrm=cmd.CreateParameter();
                  dbPrm.ParameterName = p.ParameterName;
                  dbPrm.DbType = p.DataType;
                  dbPrm.Value = p.Value;
                  dbPrm.Direction = p.Direction;
                  cmd.Parameters.Add(dbPrm);
                   //cmd.AddInParameter(p.ParameterName, p.DbType, p.Value);
               }
               cmd.Connection = conn;

               dbAdapter.SelectCommand = cmd;
               dbAdapter.FillLoadOption = LoadOption.PreserveChanges;
               dbAdapter.Fill(dataSet);
           }
           catch (Exception ex)
           {
             
           }
           finally
           {
               conn.Close();
           }
           return dataSet;

       }

       private ConnectionStringSettings getConnection(string connectionName, string connectionString, string providerName)
       {
           ConnectionStringSettings conS = new ConnectionStringSettings(connectionName, connectionString, providerName);
           return conS;
       }

       private void SetUserManagementDatabaseInfo()
       {
           conS = ConfigurationManager.ConnectionStrings["IBSUserMasterConnectionString"];
           strProviderName = conS.ProviderName;
           conn = CreateDbConnection(strProviderName, conS.ConnectionString);
           //cmd = conn.CreateCommand();
           DBProvider = (ProviderName)Enum.Parse(typeof(ProviderName), getLastNameOfDBProvider(strProviderName));
       }

        /// <summary>
       ///  get SqlClient from System.Data.SqlClient
        /// </summary>
        /// <returns></returns>
        private string getLastNameOfDBProvider(string strProviderName)  
       {
           string[] ProviderName = strProviderName.Split('.');
           return ProviderName[2];
       }

    }

    

    public enum ProviderName
    {
        SqlClient,
        MySqlClient

    }
}
