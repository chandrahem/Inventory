﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using IBS.ERP.Models;

namespace IBS.ERP.DataAccess
{
    public class CustomerDAL : baseDAL
    {
         public CustomerDAL() { }

         public CustomerDAL(string connectionStringCompanyDatabase, string userAccount, string roleId, string companyDBProvider, string companyCode)
            : base(connectionStringCompanyDatabase, userAccount, roleId, companyDBProvider, companyCode)
        {

        }

         private const string SP_CustomerInformation = "[ERP_Get_CustomerInformation]";
       private const string ERP_GetCustomer = "[ERP_GetCustomer]";
       private const string ERP_Edit_Customer = "[ERP_Edit_Customer]";
       private const string ERP_DeleteCustomer = "[ERP_DeleteCustomer]";
       private const string ERP_GetCountries = "[ERP_GetCountries]";
       public List<CustomerMaster> GetPartnersList(Paging objPaging, out int TotalRows, out bool blnCreate, out bool blnEdit, out bool blnDelete, out bool blnView, Search objSearch )   //Paging objPaging, out Int32 TotalRows, string CompanyName, string CustomerCode, string ContactName1, string Phone, string City, string State, string Country, string FromDate, string ToDate, string PostalCode,  out bool  blnCreate, out bool blnEdit , out bool blnDelete)
       {
           List<CustomerMaster> ListReq = null;
           TotalRows = 0;
           blnCreate = false;
           blnEdit = false;
           blnDelete = false;
           blnView = false;
           try
           {
               sqlcmd.CommandText = SP_CustomerInformation;
               sqlcmd.CommandType = CommandType.StoredProcedure;

               if (conn.State == ConnectionState.Closed)
                   conn.Open();

               sqlcmd.Parameters.AddWithValue("@UserAccount", LoggedInUser);
               sqlcmd.Parameters.AddWithValue("@StartRowIndex", objPaging.StartRowIndex);
               sqlcmd.Parameters.AddWithValue("@MaxRows", objPaging.MaxRows);
               sqlcmd.Parameters.AddWithValue("@OrderBy", objPaging.OrderBy);
               sqlcmd.Parameters.AddWithValue("@Order", objPaging.Order);
               sqlcmd.Parameters.AddWithValue("@SearchField1", objSearch.SearchField1);
               sqlcmd.Parameters.AddWithValue("@SearchField1Value", objSearch.SearchField1Value);
               sqlcmd.Parameters.AddWithValue("@SearchField2", objSearch.SearchField2);
               sqlcmd.Parameters.AddWithValue("@SearchField2Value", objSearch.SearchField2Value);
               sqlcmd.Parameters.AddWithValue("@Condition", objSearch.Condition);
               sqlcmd.Parameters.AddWithValue("@SearchOn", objSearch.SearchOn);
               
               using (SqlDataReader sdr = sqlcmd.ExecuteReader())
               {
                   ListReq = cCommon.GetList<CustomerMaster>(sdr);
                   if (sdr.NextResult())
                   {
                       while (sdr.Read())
                       {
                           TotalRows = Int32.Parse(sdr["TotalRows"].ToString());
                           blnCreate = Convert.ToBoolean(sdr["CreatePermission"]);
                           blnEdit = Convert.ToBoolean(sdr["UpdatePermission"]);
                           blnDelete = Convert.ToBoolean(sdr["DeletePermission"]);
                          // blnView = Convert.ToBoolean(sdr["DeletePermission"]);
                       }
                   }
                   sdr.Close();
                   sdr.Dispose();
               }

             
           }
           catch (SqlException ex)
           {
               Logger.Error("CustomerDAL.GetCandidateDocuments(" + LoggedInUser + "," + CompanyCode + ")", ex);
           }
           finally
           {
           }
           return ListReq;
       }


      public  CustomerMaster GetCustomerInfo(int CustomerID)
      {
          CustomerMaster obj = null; ;
          try
          {
                      sqlcmd.CommandText = ERP_GetCustomer;
                      sqlcmd.Parameters.AddWithValue("@CustomerID", CustomerID);
                      sqlcmd.CommandType = CommandType.StoredProcedure;
              
                      if (conn.State == ConnectionState.Closed)
                          conn.Open();

                      using (SqlDataReader sdr = sqlcmd.ExecuteReader())
                      {
                          while (sdr.Read())
                          {
                              obj = new CustomerMaster();
                              //obj.Address = sdr["Address"].ToString();
                              obj.CustomerCode = sdr["CustomerCode"].ToString();
                              obj.CustomerBarCode = sdr["CustomerBarCode"].ToString();
                              obj.CustomerName = sdr["CustomerName"].ToString();
                              obj.ContactName = sdr["ContactName"].ToString();
                              obj.ContactTitle = sdr["ContactTitle"].ToString();
                              obj.Phone = sdr["Phone"].ToString();
                              obj.Fax = sdr["Fax"].ToString();
                              obj.ContactEmail = sdr["ContactEmail"].ToString();
                              obj.WebSite = sdr["WebSite"].ToString();
                              obj.AutoApproveSO =  Convert.ToBoolean(sdr["AutoApproveSO"]);
                              obj.AutoApproveSOAmount = Convert.ToDecimal(sdr["AutoApproveSOAmount"]);
                              obj.AutoSendSO = Convert.ToBoolean( sdr["AutoSendSO"]);
                              

                             // obj.City = sdr["City"].ToString();
                              
                             
                              //obj.Region = sdr["Region"].ToString();
                              //obj.Country = sdr["Country"].ToString();
                              //obj.PostalCode = sdr["PostalCode"].ToString();
                             // obj.State = sdr["State"].ToString(); 

                          }
                          sdr.Close();
                          sdr.Dispose();
                      }
                 
             
          }
          catch (SqlException sqlEx)
          {
              Logger.Error("CustomerDAL.GetCustomerInfo(" + LoggedInUser + "," + CompanyCode + "," + CustomerID + ")", sqlEx);
          }
          catch (Exception ex)
          {
              Logger.Error("CustomerDAL.GetCustomerInfo(" + LoggedInUser + "," + CompanyCode + "," + CustomerID + ")", ex);
          }
          finally { }

          return obj;
      }

      #region Edit Customer Information
      public int EditCustomerInformation(Int32 CustomerID, string CustomerCode, string CustomerBarCode, string CompanyName, string ContactName, string ContactTitle, string Address, string City, string Region, string PostalCode, string Country, string Phone, string State)
      {
              int Edit = 0;
              string StoredProcedureName = string.Empty;
              if(CustomerID==0)
              {

                  StoredProcedureName = "ERP_Save_Customer";

              }
              else
              {

                  StoredProcedureName = "ERP_Edit_Customer";

              }
         try
              {
                      sqlcmd.CommandText = StoredProcedureName;
                      sqlcmd.Parameters.AddWithValue("@CustomerID", CustomerID);
                      sqlcmd.Parameters.AddWithValue("@CustomerCode", CustomerCode);
                      sqlcmd.Parameters.AddWithValue("@CustomerBarCode", CustomerBarCode);
                      sqlcmd.Parameters.AddWithValue("@CompanyName", CompanyName);
                      sqlcmd.Parameters.AddWithValue("@ContactName", ContactName);
                      sqlcmd.Parameters.AddWithValue("@ContactTitle", ContactTitle);
                      sqlcmd.Parameters.AddWithValue("@Address", Address);
                      sqlcmd.Parameters.AddWithValue("@City", City);
                      sqlcmd.Parameters.AddWithValue("@Region", Region);
                      sqlcmd.Parameters.AddWithValue("@Country", Country);
                      sqlcmd.Parameters.AddWithValue("@PostalCode", PostalCode);
                      sqlcmd.Parameters.AddWithValue("@Phone", Phone);
                      sqlcmd.Parameters.AddWithValue("@State", State);
                      
                      sqlcmd.CommandType = CommandType.StoredProcedure;

                      if (conn.State == ConnectionState.Closed)
                          conn.Open();
                       Edit = sqlcmd.ExecuteNonQuery();
                     
                      sqlcmd.Connection.Close();
                      sqlcmd.Connection.Dispose();
                  
          }
          catch (SqlException ex)
          {

              Logger.Error("CustomerDAL.EditCustomerInformation(" + LoggedInUser + "," + CompanyCode + "," + CustomerCode + ")", ex);
          }
         catch (Exception ex)
         {
             Logger.Error("CustomerDAL.EditCustomerInformation(" + LoggedInUser + "," + CompanyCode + "," + CustomerCode + ")", ex);
         }
          finally
          {
          }
          return Edit;
      }
      #endregion


      #region Delete Customer Information
      public  int DeleteCustomerInformation(Int32 CustomerID)
      {
          int Delete = 0;
          try
          {
            sqlcmd.CommandText = ERP_DeleteCustomer;
            sqlcmd.CommandType = CommandType.StoredProcedure;
            if (conn.State == ConnectionState.Closed)
            conn.Open();
            Delete = sqlcmd.ExecuteNonQuery();
            sqlcmd.Connection.Close();
                   
          }
          catch (SqlException ex)
          {
              Logger.Error("CustomerDAL.DeleteCustomerInformation(" + LoggedInUser + "," + CompanyCode + "," + CustomerID + ")", ex);

          }
          catch (Exception ex)
          {
              Logger.Error("CustomerDAL.DeleteCustomerInformation(" + LoggedInUser + "," + CompanyCode + "," + CustomerID + ")", ex);
          }
          finally
          {
          }
          return Delete;
      }
      #endregion

      #region Get Countries
      public  List<CountryStateCity> CountryNames()
      {

          List<CountryStateCity> ListCountry = null;
          try
          {
            sqlcmd.CommandText = ERP_GetCountries;
             
            sqlcmd.Parameters.AddWithValue("@Flag", "C");
            sqlcmd.CommandType = CommandType.StoredProcedure;

            if (conn.State == ConnectionState.Closed)
            conn.Open();

            ListCountry = cCommon.GetList<CountryStateCity>(sqlcmd.ExecuteReader());
                 
          }
          catch (SqlException ex)
          {
              Logger.Error("CustomerDAL.Countries(" + LoggedInUser + "," + CompanyCode + ")", ex);
          }
          catch (Exception ex)
          {
              Logger.Error("CustomerDAL.Countries(" + LoggedInUser + "," + CompanyCode + ")", ex);
          }
          finally
          {
          }
          return ListCountry;

      }
      #endregion


      #region Get States
      public  List<CountryStateCity> StateNames(int CountryID)
      {

          List<CountryStateCity> ListCountry = null;
          try
          {
            sqlcmd.CommandText = ERP_GetCountries;
            
            sqlcmd.Parameters.AddWithValue("@Flag", "S");
            sqlcmd.Parameters.AddWithValue("@CountryID", CountryID);
            sqlcmd.CommandType = CommandType.StoredProcedure;

            if (conn.State == ConnectionState.Closed)
            conn.Open();
                      
            ListCountry = cCommon.GetList<CountryStateCity>(sqlcmd.ExecuteReader());
                 
          }
          catch (SqlException ex)
          {
              Logger.Error("CustomerDAL.StateNames(" + LoggedInUser + "," + CompanyCode + ", "+CountryID+")", ex);
          }
          catch (Exception ex)
          {
              Logger.Error("CustomerDAL.StateNames(" + LoggedInUser + "," + CompanyCode + ", " + CountryID + ")", ex);
          }
          finally
          {
          }
          return ListCountry;

      }
      #endregion

      #region Get City
      public  List<CountryStateCity> CityNames(int StateID)
      {

          List<CountryStateCity> ListCountry = null;
          try
          {
            sqlcmd.CommandText = ERP_GetCountries;
            sqlcmd.Parameters.AddWithValue("@Flag", "Ci");
            sqlcmd.Parameters.AddWithValue("@StateID", StateID);
            sqlcmd.CommandType = CommandType.StoredProcedure;

            if (conn.State == ConnectionState.Closed)
                conn.Open();

            ListCountry = cCommon.GetList<CountryStateCity>(sqlcmd.ExecuteReader());
                
          }
          catch (SqlException ex)
          {
              //LogError.Current().Log(ex, "0");
          }
          catch (Exception ex)
          {
              Logger.Error("CustomerDAL.CityNames(" + LoggedInUser + "," + CompanyCode + ", " + StateID + ")", ex);
          }
          finally
          {
          }
          return ListCountry;

      }
      #endregion
    }
}
