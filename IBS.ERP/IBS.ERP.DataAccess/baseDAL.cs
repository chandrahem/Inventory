using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
namespace IBS.ERP.DataAccess
{
    public class baseDAL
    {
         //public string ConnectionString { get; }
       //public DbProviderFactory DbProviderFactory { get; }
       //public virtual DbConnection CreateConnection();
       //protected DbParameter CreateParameter(string name);

       public System.Data.Common.DbConnection conn;
       public string providerName;
       
      public baseDAL()
       {
          // Check Connection string from Context if it is not there then use from config
           ConnectionStringSettings conS = ConfigurationManager.ConnectionStrings["IBSUserMasterConnectionString"];
           providerName = conS.ProviderName;   
           conn = CreateDbConnection(providerName, conS.ConnectionString);
             

       }
      public baseDAL(string connectionName, string connectionString, string providerName)
      {
          ConnectionStringSettings conS = new ConnectionStringSettings(connectionName, connectionString, providerName); // ConfigurationManager.ConnectionStrings["IBSUserMasterConnectionString"];
          providerName = conS.ProviderName;
          conn = CreateDbConnection(providerName, conS.ConnectionString);
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
                   DbProviderFactory factory = DbProviderFactories.GetFactory(providerName);

                   conn = factory.CreateConnection();
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

       public int ExecuteSqlNonQuery(string SPName, List<IBSparameter> parameters)
       {
           int intEffected = -1;  // return number rows effected 
          

           try
           {
               //conn = CreateDbConnection(providerName, connectionString, out strError);
               if (conn != null)
               {
                   conn.Open();
               }
           }
           catch (Exception ex)
           {
              // strError = ex.Message;
               return -1;
           }

           try
           {
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
               intEffected = cmd.ExecuteNonQuery();

               //DbParameter parameter = cmd.CreateParameter();
               //parameter.ParameterName = "aaa";
               //parameter.DbType = DbType.String;
               //parameter.Value = "a";
               //parameter.Direction = ParameterDirection.Input;


           }
           catch (Exception ex)
           {
               //strError = ex.Message;
               return -1;
           }
           return intEffected;

       }

       public DataSet GetDataSet(string SPName, List<IBSparameter> parameters)
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
           DbProviderFactory factory = DbProviderFactories.GetFactory(providerName);

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
           return dataSet;

       }




    }
}
