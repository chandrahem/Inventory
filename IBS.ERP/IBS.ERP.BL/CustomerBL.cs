using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IBS.ERP.DataAccess;
using IBS.ERP.Models;

namespace IBS.ERP.BL
{
   public class CustomerBL
    {

       public List<CustomerMaster> GetCandidateDocuments(Paging objPaging, out Int32 TotalRows, string CompanyName, string CustomerCode, string ContactName, string Phone, string City, string State, string Country, string FromDate, string ToDate, string PostalCode)
       {

           return CustomerDAL.GetCandidateDocuments(objPaging, out  TotalRows, CompanyName, CustomerCode, ContactName, Phone, City, State, Country, FromDate, ToDate, PostalCode);
       }

       public CustomerMaster GetCustomerInfo(int CustomerID)
       {
           return CustomerDAL.GetCustomerInfo(CustomerID);
       }
       public int EditCustomerInformation(Int32 CustomerID, string CustomerCode, string CustomerBarCode, string CompanyName, string ContactName, string ContactTitle, string Address, string City, string Region, string PostalCode, string Country, string Phone, string State)
       {
           return CustomerDAL.EditCustomerInformation(CustomerID, CustomerCode, CustomerBarCode, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, State);
       }

       public int DeleteCustomerInformation(Int32 CustomerID)
       {
           return CustomerDAL.DeleteCustomerInformation(CustomerID);
       }

       public List<CountryStateCity> CountryNames()
       {

           return CustomerDAL.CountryNames();
       }

       public List<CountryStateCity> StateNames(int CountryID)
       {
          return CustomerDAL.StateNames(CountryID);
       }

       public List<CountryStateCity> CityNames(int StateID)
       {
           return CustomerDAL.CityNames(StateID);
       }

    }
}
