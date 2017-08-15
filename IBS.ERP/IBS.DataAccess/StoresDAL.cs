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
    public class StoresDAL : baseDAL
    {
         public StoresDAL() { }

         public StoresDAL(string connectionStringCompanyDatabase, string userAccount, string roleId, string companyDBProvider, string companyCode)
            : base(connectionStringCompanyDatabase, userAccount, roleId, companyDBProvider, companyCode)
        {

        }
        public List<Stores> GetStores()
        {
            List<Stores> objStores = new List<Stores>();

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

                DataSet dsStores = null;
                dsStores = GetDataSet("ERP_Get_Stores", parameters);

                var MenuCollection = from Stores in dsStores.Tables[0].AsEnumerable()
                                     select new Stores
                                     {
                                         StoreId = Stores.Field<int>("StoreID"),
                                         StoreName = Stores.Field<String>("StoreName"),
                                         Address = Stores.Field<String>("Address"),
                                         City = Stores.Field<String>("City"),
                                         Phone1 = Stores.Field<String>("Phone1"),
                                         Email = Stores.Field<String>("Email"),
                                     };
                objStores = MenuCollection.ToList<Stores>();



            }

            catch (Exception ex)
            {
                //Logger.Error("CategoriesDAL.objCategories(" + LoggedInUser + "," + CompanyCode + ")", ex);
            }

            return objStores;

        }


        public ReturnResult SaveStore(Stores store)
        {
            Stores objStore = new Stores();
            ReturnResult returnResult = new ReturnResult();

            try
            {

                if (DBProvider == ProviderName.SqlClient)
                {
                    IBSparameter StoreIDParameter = new IBSparameter();
                    StoreIDParameter.ParameterName = "@StoreID";
                    StoreIDParameter.DataType = DbType.String;
                    StoreIDParameter.Value = store.StoreId;
                    StoreIDParameter.Direction = ParameterDirection.Input;
                    parameters.Add(StoreIDParameter);


                    IBSparameter Userparameter = new IBSparameter();
                    Userparameter.ParameterName = "@UserAccount";
                    Userparameter.DataType = DbType.String;
                    Userparameter.Value = LoggedInUser;
                    Userparameter.Direction = ParameterDirection.Input;
                    parameters.Add(Userparameter);

                    IBSparameter StoreNameParameter = new IBSparameter();
                    StoreNameParameter.ParameterName = "@StoreName";
                    StoreNameParameter.DataType = DbType.String;
                    StoreNameParameter.Value = store.StoreName;
                    StoreNameParameter.Direction = ParameterDirection.Input;
                    parameters.Add(StoreNameParameter);

                    IBSparameter StoreCompanyIDParameter = new IBSparameter();
                    StoreCompanyIDParameter.ParameterName = "@CompanyID";
                    StoreCompanyIDParameter.DataType = DbType.Int32;
                    StoreCompanyIDParameter.Value = 1;
                    StoreCompanyIDParameter.Direction = ParameterDirection.Input;
                    parameters.Add(StoreCompanyIDParameter); 

                    IBSparameter StoreAddressParameter = new IBSparameter();
                    StoreAddressParameter.ParameterName = "@Address";
                    StoreAddressParameter.DataType = DbType.String;
                    StoreAddressParameter.Value = store.Address;
                    StoreAddressParameter.Direction = ParameterDirection.Input;
                    parameters.Add(StoreAddressParameter);

                    IBSparameter StoreCityParameter = new IBSparameter();
                    StoreCityParameter.ParameterName = "@City";
                    StoreCityParameter.DataType = DbType.String;
                    StoreCityParameter.Value = store.City;
                    StoreCityParameter.Direction = ParameterDirection.Input;
                    parameters.Add(StoreCityParameter);

                    IBSparameter StoreEmailParameter = new IBSparameter();
                    StoreEmailParameter.ParameterName = "@Email";
                    StoreEmailParameter.DataType = DbType.String;
                    StoreEmailParameter.Value = store.Email;
                    StoreEmailParameter.Direction = ParameterDirection.Input;
                    parameters.Add(StoreEmailParameter);

                    IBSparameter Flag = new IBSparameter();
                    Flag.ParameterName = "@Flag";
                    Flag.DataType = DbType.String;
                    Flag.Value = "I";
                    Flag.Direction = ParameterDirection.Input;
                    parameters.Add(Flag);

                    //IBSparameter returnParameter = new IBSparameter();
                    //returnParameter.ParameterName = "@ReturnValue";
                    //returnParameter.DataType = DbType.Int32;
                    //returnParameter.Value = "";
                    //returnParameter.Direction = ParameterDirection.Output;
                    //parameters.Add(returnParameter);


                }

                return ExecuteSqlNonQuery("ERP_Save_Store", parameters);


            }

            catch (Exception ex)
            {
               // Logger.Error("CompanyDAL.SaveCompany(" + LoggedInUser + "," + CompanyCode + "," + company.CompanyCode + ")", ex);
            }
            return returnResult;

        }

        public ReturnResult DeleteStore(int storeID)
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



                    IBSparameter StoreIdParameter = new IBSparameter();
                    StoreIdParameter.ParameterName = "@StoreID";
                    StoreIdParameter.DataType = DbType.String;
                    StoreIdParameter.Value = storeID;
                    StoreIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(StoreIdParameter);

                    IBSparameter Flag = new IBSparameter();
                    Flag.ParameterName = "@Flag";
                    Flag.DataType = DbType.String;
                    Flag.Value = "D";
                    Flag.Direction = ParameterDirection.Input;
                    parameters.Add(Flag);



                }
                return ExecuteSqlNonQuery("ERP_Save_Store", parameters);


            }

            catch (Exception ex)
            {
                // Logger.Error("CategoriesDAL.DeleteCategory(" + LoggedInUser + "," + CompanyCode + "," + categoryid + ")", ex);
            }
            return returnResult;


        }

        public Stores GetStoreById(int StoreID)
        {
            List<Stores> storeList = new List<Stores>();
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



                    IBSparameter StoreIdParameter = new IBSparameter();
                    StoreIdParameter.ParameterName = "@StoreID";
                    StoreIdParameter.DataType = DbType.String;
                    StoreIdParameter.Value = StoreID;
                    StoreIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(StoreIdParameter);

                }

                DataSet dsStore = null;
                dsStore = GetDataSet("ERP_Get_StoreByID", parameters);

                var StoreCollection = from Stores in dsStore.Tables[0].AsEnumerable()
                                        select new Stores
                                        {
                                            StoreId = Stores.Field<int>("StoreId"),
                                            StoreName = Stores.Field<String>("StoreName"),
                                            Address = Stores.Field<String>("Address"),

                                            City = Stores.Field<String>("City"),
                                            Email = Stores.Field<String>("Email"),
                                        };
                storeList = StoreCollection.ToList<Stores>();
            }

            catch (Exception ex)
            {
                //Logger.Error("CategoriesDAL.GetCategoryById(" + LoggedInUser + "," + CompanyCode + "," + categoryId + ")", ex);
            }

            return storeList[0];

        }
    }
}
