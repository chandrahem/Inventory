using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IBS.ERP.Models;
using System.Data;
namespace IBS.ERP.DataAccess
{
    public class SuppliersDAL : baseDAL
    {
        public List<Suppliers> GetSuppliersList()
        {
            List<Suppliers> objSuppliersList = new List<Suppliers>();

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

                DataSet dsSuppliers = null;
                dsSuppliers = GetDataSet("ERP_Get_SuppliersList", parameters);

                var supplierCollection = from Suppliers in dsSuppliers.Tables[0].AsEnumerable()
                                     select new Suppliers
                                     {
                                         SupplierId = Suppliers.Field<int>("SupplierId"),
                                         SupplierCode = Suppliers.Field<String>("SupplierCode"),
                                         SupplierName = Suppliers.Field<String>("SupplierName"),
                                         Address = Suppliers.Field<String>("Address"),
                                         City = Suppliers.Field<String>("City"),
                                         ContactEmail = Suppliers.Field<String>("ContactEmail"),
                                         ContactName = Suppliers.Field<String>("ContactName"),
                                         ContactTitle = Suppliers.Field<String>("ContactTitle"),
                                         Country = Suppliers.Field<String>("Country"),
                                         Phone1 = Suppliers.Field<String>("Phone1"),
                                         Phone2 = Suppliers.Field<String>("Phone2"),
                                         PostalCode = Suppliers.Field<String>("PostalCode"),
                                         Website = Suppliers.Field<String>("Website"),
                                         Fax = Suppliers.Field<String>("Fax")
                                         //LockStatus = Suppliers.Field<String>("LockStatus"),
                                     };
                objSuppliersList = supplierCollection.ToList<Suppliers>();



            }

            catch (Exception ex)
            {
                Logger.Error("SuppliersDAL.GetSuppliersList(" + LoggedInUser + "," + CompanyCode + ")", ex);
            }

            return objSuppliersList;

        }


        public ReturnResult SaveSupplier( Suppliers supplier)
        {
           // Suppliers objSupplier = new Suppliers();
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

                    IBSparameter SupplierIdParameter = new IBSparameter();
                    SupplierIdParameter.ParameterName = "@SupplierId";
                    SupplierIdParameter.DataType = DbType.String;
                    SupplierIdParameter.Value = supplier.SupplierId;
                    SupplierIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(SupplierIdParameter);

                    IBSparameter SupplierCodeParameter = new IBSparameter();
                    SupplierCodeParameter.ParameterName = "@SupplierCode";
                    SupplierCodeParameter.DataType = DbType.String;
                    SupplierCodeParameter.Value = supplier.SupplierCode;
                    SupplierCodeParameter.Direction = ParameterDirection.Input;
                    parameters.Add(SupplierCodeParameter);


                    IBSparameter SupplierNameParameter = new IBSparameter();
                    SupplierNameParameter.ParameterName = "@SupplierName";
                    SupplierNameParameter.DataType = DbType.String;
                    SupplierNameParameter.Value = supplier.SupplierName;
                    SupplierNameParameter.Direction = ParameterDirection.Input;
                    parameters.Add(SupplierNameParameter);

                    IBSparameter SupplierContactParameter = new IBSparameter();
                    SupplierContactParameter.ParameterName = "@ContactName";
                    SupplierContactParameter.DataType = DbType.String;
                    SupplierContactParameter.Value = supplier.ContactName;
                    SupplierContactParameter.Direction = ParameterDirection.Input;
                    parameters.Add(SupplierContactParameter);

                    IBSparameter SupplierContactTitleParameter = new IBSparameter();
                    SupplierContactTitleParameter.ParameterName = "@ContactTitle";
                    SupplierContactTitleParameter.DataType = DbType.String;
                    SupplierContactTitleParameter.Value = supplier.ContactTitle;
                    SupplierContactTitleParameter.Direction = ParameterDirection.Input;
                    parameters.Add(SupplierContactTitleParameter);

                    IBSparameter AddressParameter = new IBSparameter();
                    AddressParameter.ParameterName = "@Address";
                    AddressParameter.DataType = DbType.String;
                    AddressParameter.Value = supplier.Address;
                    AddressParameter.Direction = ParameterDirection.Input;
                    parameters.Add(AddressParameter);

                    IBSparameter CityParameter = new IBSparameter();
                    CityParameter.ParameterName = "@City";
                    CityParameter.DataType = DbType.String;
                    CityParameter.Value = supplier.City;
                    CityParameter.Direction = ParameterDirection.Input;
                    parameters.Add(CityParameter);

                    IBSparameter PostalCodeParameter = new IBSparameter();
                    PostalCodeParameter.ParameterName = "@PostalCode";
                    PostalCodeParameter.DataType = DbType.String;
                    PostalCodeParameter.Value = supplier.PostalCode;
                    PostalCodeParameter.Direction = ParameterDirection.Input;
                    parameters.Add(PostalCodeParameter);

                    IBSparameter CountryParameter = new IBSparameter();
                    CountryParameter.ParameterName = "@Country";
                    CountryParameter.DataType = DbType.String;
                    CountryParameter.Value = supplier.Country;
                    CountryParameter.Direction = ParameterDirection.Input;
                    parameters.Add(CountryParameter);

                    IBSparameter Phone1Parameter = new IBSparameter();
                    Phone1Parameter.ParameterName = "@Phone1";
                    Phone1Parameter.DataType = DbType.String;
                    Phone1Parameter.Value = supplier.Phone1;
                    Phone1Parameter.Direction = ParameterDirection.Input;
                    parameters.Add(Phone1Parameter);

                    IBSparameter Phone2Parameter = new IBSparameter();
                    Phone2Parameter.ParameterName = "@Phone2";
                    Phone2Parameter.DataType = DbType.String;
                    Phone2Parameter.Value = supplier.Phone2;
                    Phone2Parameter.Direction = ParameterDirection.Input;
                    parameters.Add(Phone2Parameter);

                    IBSparameter FaxParameter = new IBSparameter();
                    FaxParameter.ParameterName = "@Fax";
                    FaxParameter.DataType = DbType.String;
                    FaxParameter.Value = supplier.Fax;
                    FaxParameter.Direction = ParameterDirection.Input;
                    parameters.Add(FaxParameter);

                    IBSparameter WebSiteParameter = new IBSparameter();
                    WebSiteParameter.ParameterName = "@Website";
                    WebSiteParameter.DataType = DbType.String;
                    WebSiteParameter.Value = supplier.Website;
                    WebSiteParameter.Direction = ParameterDirection.Input;
                    parameters.Add(WebSiteParameter);

                    IBSparameter ContactEmailParameter = new IBSparameter();
                    ContactEmailParameter.ParameterName = "@ContactEmail";
                    ContactEmailParameter.DataType = DbType.String;
                    ContactEmailParameter.Value = supplier.ContactEmail;
                    ContactEmailParameter.Direction = ParameterDirection.Input;
                    parameters.Add(ContactEmailParameter);
                    
                    IBSparameter ReturnParameter = new IBSparameter();
                    ReturnParameter.ParameterName = "@ReturnValue";
                    ReturnParameter.DataType = DbType.Int32;
                    ReturnParameter.Value = "";
                    ReturnParameter.Direction = ParameterDirection.Output;
                    parameters.Add(ReturnParameter);
                }
                //ReturnResult returnValue = new ReturnResult();
                return ExecuteSqlNonQuery("ERP_SAVE_Suppliers", parameters);
                //if (returnValue .IsSuccess)
                //{
                //     returnResult.ID = count;
                //     returnResult.IsSuccess=true;
                //     returnResult.Message = "Category saved successfully.";
                //}
                //else
                //{

                //}


                //DbCommand command = database.GetStoredProcCommand("ERP_Save_Category"); // SP name

                //database.AddInParameter(command, "@CategoryId", DbType.Int32, category.categoryid);
                //database.AddInParameter(command, "@CategoryName", DbType.String, category.categoryname);
                //database.AddInParameter(command, "@Description", DbType.String, category.description);
                //database.AddInParameter(command, "@LoginUser", DbType.String, loginUser);

                //database.ExecuteNonQuery(command);

            }

            catch (Exception ex)
            {
                Logger.Error("SupplierDAL.SaveSupplier(" + LoggedInUser + "," + CompanyCode + "," + supplier.SupplierCode + ")", ex);
            }
            return returnResult;

        }

        public ReturnResult DeleteSupplier(int supplierid)
        {
            //Category objCategory = new Category();
            ReturnResult returnResult = new ReturnResult();

            try
            {
                //int b=1, a=0;
                //int c = b / a;
                if (DBProvider == ProviderName.SqlClient)
                {

                    IBSparameter Userparameter = new IBSparameter();
                    Userparameter.ParameterName = "@UserAccount";
                    Userparameter.DataType = DbType.String;
                    Userparameter.Value = LoggedInUser;
                    Userparameter.Direction = ParameterDirection.Input;
                    parameters.Add(Userparameter);



                    IBSparameter CatergoryIdParameter = new IBSparameter();
                    CatergoryIdParameter.ParameterName = "@SupplierId";
                    CatergoryIdParameter.DataType = DbType.Int32;
                    CatergoryIdParameter.Value = supplierid;
                    CatergoryIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(CatergoryIdParameter);

                    IBSparameter ReturnParameter = new IBSparameter();
                    ReturnParameter.ParameterName = "@ReturnValue";
                    ReturnParameter.DataType = DbType.Int32;
                    ReturnParameter.Value = "";
                    ReturnParameter.Direction = ParameterDirection.Output;
                    parameters.Add(ReturnParameter);

                }
                return ExecuteSqlNonQuery("ERP_Delete_Supplier", parameters);
                //if (count > 0)
                //{
                //    returnResult.ID = count;
                //    returnResult.IsSuccess = true;
                //    returnResult.Message = "Category removed successfully.";
                //}
                ////DbCommand command = database.GetStoredProcCommand("ERP_Delete_Category"); // SP name

                ////database.AddInParameter(command, "@CategoryId", DbType.Int32, categoryid);
                ////database.AddInParameter(command, "@LoginUser", DbType.String, loginUser);

                ////database.ExecuteNonQuery(command);

            }

            catch (Exception ex)
            {
                Logger.Error("SupplierDAL.DeleteSupplier(" + LoggedInUser + "," + CompanyCode + "," + supplierid + ")", ex);
            }
            return returnResult;
        }

        public Suppliers GetSupplierById(int supplierId)
        {
            List<Suppliers> supplierList = new List<Suppliers>();
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



                    IBSparameter SupplierIdParameter = new IBSparameter();
                    SupplierIdParameter.ParameterName = "@SupplierId";
                    SupplierIdParameter.DataType = DbType.Int32;
                    SupplierIdParameter.Value = supplierId;
                    SupplierIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(SupplierIdParameter);

                }

                DataSet dsSupplier = null;
                dsSupplier = GetDataSet("ERP_Get_SupplierById", parameters);

                var SupplierCollection = from Suppliers in dsSupplier.Tables[0].AsEnumerable()
                                         select new Suppliers
                                         {
                                             SupplierId = Suppliers.Field<int>("SupplierId"),
                                             SupplierCode = Suppliers.Field<String>("SupplierCode"),
                                             SupplierName = Suppliers.Field<String>("SupplierName"),
                                             Address = Suppliers.Field<String>("Address"),
                                             City = Suppliers.Field<String>("City"),
                                             ContactEmail = Suppliers.Field<String>("ContactEmail"),
                                             ContactName = Suppliers.Field<String>("ContactName"),
                                             ContactTitle = Suppliers.Field<String>("ContactTitle"),
                                             Country = Suppliers.Field<String>("Country"),
                                             Phone1 = Suppliers.Field<String>("Phone1"),
                                             Phone2 = Suppliers.Field<String>("Phone2"),
                                             PostalCode = Suppliers.Field<String>("PostalCode"),
                                             Website = Suppliers.Field<String>("Website"),
                                             Fax = Suppliers.Field<String>("Fax")
                                         };
                supplierList = SupplierCollection.ToList<Suppliers>();
            }

            catch (Exception ex)
            {
                Logger.Error("Supplier.GetSupplierById(" + LoggedInUser + "," + CompanyCode + "," + supplierId + ")", ex);
            }

            return supplierList[0];

        }
    }
}
