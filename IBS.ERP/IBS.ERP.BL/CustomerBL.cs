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
       CustomerDAL objcustomerDal ;
       public CustomerBL()
       {
           objcustomerDal = new CustomerDAL();
       }
       //public List<CustomerMaster> GetCandidateDocuments(Paging objPaging, out Int32 TotalRows, string CompanyName, string CustomerCode, string ContactName, string Phone, string City, string State, string Country, string FromDate, string ToDate, string PostalCode, out bool  blnCreate, out bool blnEdit , out bool blnDelete)
       //{
       //    CustomerDAL objcustomerDal = new CustomerDAL();
       //    return objcustomerDal.GetPartnersList(objPaging, out  TotalRows, CompanyName, CustomerCode, ContactName, Phone, City, State, Country, FromDate, ToDate, PostalCode, out blnCreate, out blnEdit ,out  blnDelete);
       //}

       public CustomerMaster GetCustomerInfo(int CustomerID)
       {
           return objcustomerDal.GetCustomerInfo(CustomerID);
       }
       public int EditCustomerInformation(Int32 CustomerID, string CustomerCode, string CustomerBarCode, string CompanyName, string ContactName, string ContactTitle, string Address, string City, string Region, string PostalCode, string Country, string Phone, string State)
       {
           return objcustomerDal.EditCustomerInformation(CustomerID, CustomerCode, CustomerBarCode, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, State);
       }

       public int DeleteCustomerInformation(Int32 CustomerID)
       {
           return objcustomerDal.DeleteCustomerInformation(CustomerID);
       }

       public List<CountryStateCity> CountryNames()
       {

           return objcustomerDal.CountryNames();
       }

       public List<CountryStateCity> StateNames(int CountryID)
       {
           return objcustomerDal.StateNames(CountryID);
       }

       public List<CountryStateCity> CityNames(int StateID)
       {
           return objcustomerDal.CityNames(StateID);
       }

    }
}
