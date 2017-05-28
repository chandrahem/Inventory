using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using IBS.ERP.Models;

namespace IBS.ERP.DataAccess
{
   public class CustomerDAL
    {
       private const string SP_CustomerInformation = "[SP_CustomerInformation]";
       private const string ERP_GetCustomer = "[ERP_GetCustomer]";
       private const string ERP_Edit_Customer = "[ERP_Edit_Customer]";
       private const string ERP_DeleteCustomer = "[ERP_DeleteCustomer]";
       private const string ERP_GetCountries = "[ERP_GetCountries]";
      public static List<CustomerMaster> GetCandidateDocuments(Paging objPaging, out Int32 TotalRows, string CompanyName, string CustomerCode, string ContactName1, string Phone, string City, string State, string Country, string FromDate, string ToDate, string PostalCode)
       {
           List<CustomerMaster> ListReq = null;
           TotalRows = 0;
           try
           {
               using (SqlCommand cmd = new SqlCommand(SP_CustomerInformation))
               {
                   using (SqlConnection con = new SqlConnection(@"Data Source=ibsmssqlserver.cezeuiz2wro3.ap-south-1.rds.amazonaws.com,1433; Initial Catalog=ABCInventory;User ID=hem;Password=hemchandra;"))
                   {
                       cmd.CommandType = CommandType.StoredProcedure;

                       if (con.State == ConnectionState.Closed)
                           con.Open();

                       cmd.Connection = con;

                       cmd.Parameters.AddWithValue("@StartRowIndex", 1);
                       cmd.Parameters.AddWithValue("@MaxRows", objPaging.MaxRows);
                       cmd.Parameters.AddWithValue("@OrderBy", objPaging.OrderBy);
                       cmd.Parameters.AddWithValue("@Order", objPaging.Order);
                       cmd.Parameters.AddWithValue("@CompanyName", CompanyName);
                       cmd.Parameters.AddWithValue("@CustomerCode", CustomerCode);                       
                       cmd.Parameters.AddWithValue("@Phone", Phone);
                       cmd.Parameters.AddWithValue("@City", City);
                       cmd.Parameters.AddWithValue("@State", Convert.ToString(State));
                       cmd.Parameters.AddWithValue("@Country", Country);
                       cmd.Parameters.AddWithValue("@FromDate", FromDate);
                       cmd.Parameters.AddWithValue("@ToDate", ToDate);
                       cmd.Parameters.AddWithValue("@PostalCode", PostalCode);
                       cmd.Parameters.AddWithValue("@ContactName1", ContactName1);

                       using (SqlDataReader sdr = cmd.ExecuteReader())
                       {
                           ListReq = cCommon.GetList<CustomerMaster>(sdr);
                           if (sdr.NextResult())
                           {
                               while (sdr.Read())
                               {
                                   TotalRows = Int32.Parse(sdr["TotalRows"].ToString());
                               }
                           }
                           sdr.Close();
                           sdr.Dispose();
                       }
                   }
                   cmd.Dispose();
               }
           }
           catch (SqlException ex)
           {
              string cc= ex.Message;
           }
           finally
           {
           }
           return ListReq;
       }


      public static CustomerMaster GetCustomerInfo(int CustomerID)
      {
          CustomerMaster obj = null; ;
          try
          {
              using (SqlCommand cmd = new SqlCommand(ERP_GetCustomer))
              {
                  using (SqlConnection con = new SqlConnection(@"Data Source=ibsmssqlserver.cezeuiz2wro3.ap-south-1.rds.amazonaws.com,1433; Initial Catalog=ABCInventory;User ID=hem;Password=hemchandra;"))
                  {
                      cmd.Parameters.AddWithValue("@CustomerID", CustomerID);

                     
                      cmd.CommandType = CommandType.StoredProcedure;

                      if (con.State == ConnectionState.Closed)
                      {
                          cmd.Connection = con;
                          cmd.Connection.Open();
                      }
                      using (SqlDataReader sdr = cmd.ExecuteReader())
                      {
                          while (sdr.Read())
                          {
                              obj = new CustomerMaster();
                              obj.Address = sdr["Address"].ToString();
                              obj.CompanyName = sdr["CompanyName"].ToString();
                              obj.ContactName = sdr["ContactName"].ToString();
                              obj.ContactTitle = sdr["ContactTitle"].ToString();
                              obj.City = sdr["City"].ToString();
                              obj.CustomerBarCode = sdr["CustomerBarCode"].ToString();
                              obj.CustomerCode = sdr["CustomerCode"].ToString();
                              obj.Region = sdr["Region"].ToString();
                              obj.Country = sdr["Country"].ToString();
                              obj.PostalCode = sdr["PostalCode"].ToString();
                              obj.Phone = sdr["Phone"].ToString();
                              obj.State = sdr["State"].ToString(); 

                          }
                          sdr.Close();
                          sdr.Dispose();
                      }
                  }
                  cmd.Dispose();
              }
          }
          catch (SqlException sqlEx)
          {

          }
          catch (Exception ex)
          {

          }
          finally { }

          return obj;
      }

      #region Edit Customer Information
      public static int EditCustomerInformation(Int32 CustomerID, string CustomerCode, string CustomerBarCode, string CompanyName, string ContactName, string ContactTitle, string Address, string City, string Region, string PostalCode, string Country, string Phone, string State)
      {
          int Edit = 0; 
     try
          {
              using (SqlCommand cmd = new SqlCommand(ERP_Edit_Customer))
              {
                  using (SqlConnection con = new SqlConnection(@"Data Source=ibsmssqlserver.cezeuiz2wro3.ap-south-1.rds.amazonaws.com,1433; Initial Catalog=ABCInventory;User ID=hem;Password=hemchandra;"))
                  {

                      cmd.Parameters.AddWithValue("@CustomerID", CustomerID);
                      cmd.Parameters.AddWithValue("@CustomerCode", CustomerCode);
                      cmd.Parameters.AddWithValue("@CustomerBarCode", CustomerBarCode);
                      cmd.Parameters.AddWithValue("@CompanyName", CompanyName);
                      cmd.Parameters.AddWithValue("@ContactName", ContactName);
                      cmd.Parameters.AddWithValue("@ContactTitle", ContactTitle);
                      cmd.Parameters.AddWithValue("@Address", Address);
                      cmd.Parameters.AddWithValue("@City", City);
                      cmd.Parameters.AddWithValue("@Region", Region);
                      cmd.Parameters.AddWithValue("@Country", Country);
                      cmd.Parameters.AddWithValue("@PostalCode", PostalCode);
                      cmd.Parameters.AddWithValue("@Phone", Phone);
                      cmd.Parameters.AddWithValue("@State", State);
                      
                      cmd.CommandType = CommandType.StoredProcedure;
                      if (con.State == ConnectionState.Closed)
                      {
                          cmd.Connection = con;
                          cmd.Connection.Open();
                      }
                       Edit = cmd.ExecuteNonQuery();
                     
                      cmd.Connection.Close();
                      cmd.Connection.Dispose();
                  }
                  cmd.Dispose();
              }
          }
          catch (SqlException ex)
          {
              

          }
          finally
          {
          }
          return Edit;
      }
      #endregion


      #region Delete Customer Information
      public static int DeleteCustomerInformation(Int32 CustomerID)
      {
          int Delete = 0;
          try
          {
              using (SqlCommand cmd = new SqlCommand(ERP_DeleteCustomer))
              {
                  using (SqlConnection con = new SqlConnection(@"Data Source=ibsmssqlserver.cezeuiz2wro3.ap-south-1.rds.amazonaws.com,1433; Initial Catalog=ABCInventory;User ID=hem;Password=hemchandra;"))
                  {

                      cmd.Parameters.AddWithValue("@CustomerID", CustomerID);
                    

                      cmd.CommandType = CommandType.StoredProcedure;
                      if (con.State == ConnectionState.Closed)
                      {
                          cmd.Connection = con;
                          cmd.Connection.Open();
                      }
                      Delete = cmd.ExecuteNonQuery();

                      cmd.Connection.Close();
                      cmd.Connection.Dispose();
                  }
                  cmd.Dispose();
              }
          }
          catch (SqlException ex)
          {


          }
          finally
          {
          }
          return Delete;
      }
      #endregion

      #region Get Countries
      public static List<CountryStateCity> CountryNames()
      {

          List<CountryStateCity> ListCountry = null;
          try
          {
              using (SqlCommand cmd = new SqlCommand(ERP_GetCountries))
              {
                  using (SqlConnection con = new SqlConnection(@"Data Source=ibsmssqlserver.cezeuiz2wro3.ap-south-1.rds.amazonaws.com,1433; Initial Catalog=ABCInventory;User ID=hem;Password=hemchandra;"))
                  {
                      cmd.Parameters.AddWithValue("@Flag", "C");
                      cmd.CommandType = CommandType.StoredProcedure;

                      if (con.State == ConnectionState.Closed)
                          con.Open();

                      cmd.Connection = con;
                      ListCountry = cCommon.GetList<CountryStateCity>(cmd.ExecuteReader());
                  }
              }
          }
          catch (SqlException ex)
          {
              //LogError.Current().Log(ex, "0");
          }
          finally
          {
          }
          return ListCountry;

      }
      #endregion


      #region Get States
      public static List<CountryStateCity> StateNames(int CountryID)
      {

          List<CountryStateCity> ListCountry = null;
          try
          {
              using (SqlCommand cmd = new SqlCommand(ERP_GetCountries))
              {
                  using (SqlConnection con = new SqlConnection(@"Data Source=ibsmssqlserver.cezeuiz2wro3.ap-south-1.rds.amazonaws.com,1433; Initial Catalog=ABCInventory;User ID=hem;Password=hemchandra;"))
                  {
                      cmd.Parameters.AddWithValue("@Flag", "S");
                      cmd.Parameters.AddWithValue("@CountryID", CountryID);
                      cmd.CommandType = CommandType.StoredProcedure;

                      if (con.State == ConnectionState.Closed)
                          con.Open();

                      cmd.Connection = con;
                      ListCountry = cCommon.GetList<CountryStateCity>(cmd.ExecuteReader());
                  }
              }
          }
          catch (SqlException ex)
          {
              //LogError.Current().Log(ex, "0");
          }
          finally
          {
          }
          return ListCountry;

      }
      #endregion

      #region Get City
      public static List<CountryStateCity> CityNames(int StateID)
      {

          List<CountryStateCity> ListCountry = null;
          try
          {
              using (SqlCommand cmd = new SqlCommand(ERP_GetCountries))
              {
                  using (SqlConnection con = new SqlConnection(@"Data Source=ibsmssqlserver.cezeuiz2wro3.ap-south-1.rds.amazonaws.com,1433; Initial Catalog=ABCInventory;User ID=hem;Password=hemchandra;"))
                  {
                      cmd.Parameters.AddWithValue("@Flag", "Ci");
                      cmd.Parameters.AddWithValue("@StateID", StateID);
                      cmd.CommandType = CommandType.StoredProcedure;

                      if (con.State == ConnectionState.Closed)
                          con.Open();

                      cmd.Connection = con;
                      ListCountry = cCommon.GetList<CountryStateCity>(cmd.ExecuteReader());
                  }
              }
          }
          catch (SqlException ex)
          {
              //LogError.Current().Log(ex, "0");
          }
          finally
          {
          }
          return ListCountry;

      }
      #endregion
    }
}
