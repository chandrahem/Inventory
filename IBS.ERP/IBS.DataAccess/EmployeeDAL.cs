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
  public  class EmployeeDAL : baseDAL
    {

      public EmployeeDAL() { }

      public EmployeeDAL(string connectionStringCompanyDatabase, string userAccount, string roleId, string companyDBProvider, string companyCode)
            : base(connectionStringCompanyDatabase, userAccount, roleId, companyDBProvider, companyCode)
        {

        }
        public List<EmployeeMaster> GetEmployees()
        {
            List<EmployeeMaster> objEmployees = new List<EmployeeMaster>();

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

                DataSet dsEmployee = null;
                dsEmployee = GetDataSet("ERP_Get_Employees", parameters);

                var MenuCollection = from EmployeeMaster in dsEmployee.Tables[0].AsEnumerable()
                                     select new EmployeeMaster
                                     {
                                         EmployeeId = EmployeeMaster.Field<int>("EmployeeId"),
                                         EmpCode = EmployeeMaster.Field<String>("EmpCode"),
                                         LastName = EmployeeMaster.Field<String>("LastName"),
                                         FirstName = EmployeeMaster.Field<String>("FirstName"),
                                         Address = EmployeeMaster.Field<String>("Address"),
                                         City = EmployeeMaster.Field<String>("City"),
                                         
                                     };
                objEmployees = MenuCollection.ToList<EmployeeMaster>();



            }

            catch (Exception ex)
            {
                //Logger.Error("CategoriesDAL.objCategories(" + LoggedInUser + "," + CompanyCode + ")", ex);
            }

            return objEmployees;

        }

        public ReturnResult SaveEmployee(EmployeeMaster employee)
        {
            EmployeeMaster objEmployee = new EmployeeMaster();
            ReturnResult returnResult = new ReturnResult();

            try
            {

                if (DBProvider == ProviderName.SqlClient)
                {
                    IBSparameter EmployeeIDParameter = new IBSparameter();
                    EmployeeIDParameter.ParameterName = "@EmployeeID";
                    EmployeeIDParameter.DataType = DbType.String;
                    EmployeeIDParameter.Value = employee.EmployeeId;
                    EmployeeIDParameter.Direction = ParameterDirection.Input;
                    parameters.Add(EmployeeIDParameter);


                    IBSparameter Userparameter = new IBSparameter();
                    Userparameter.ParameterName = "@UserAccount";
                    Userparameter.DataType = DbType.String;
                    Userparameter.Value = LoggedInUser;
                    Userparameter.Direction = ParameterDirection.Input;
                    parameters.Add(Userparameter);

                    IBSparameter EmpCodeParameter = new IBSparameter();
                    EmpCodeParameter.ParameterName = "@EmpCode";
                    EmpCodeParameter.DataType = DbType.String;
                    EmpCodeParameter.Value = employee.EmpCode;
                    EmpCodeParameter.Direction = ParameterDirection.Input;
                    parameters.Add(EmpCodeParameter);

                    IBSparameter FirstNameParameter = new IBSparameter();
                    FirstNameParameter.ParameterName = "@FirstName";
                    FirstNameParameter.DataType = DbType.String;
                    FirstNameParameter.Value = employee.FirstName;
                    FirstNameParameter.Direction = ParameterDirection.Input;
                    parameters.Add(FirstNameParameter);


                    IBSparameter LastNameParameter = new IBSparameter();
                    LastNameParameter.ParameterName = "@LastName";
                    LastNameParameter.DataType = DbType.String;
                    LastNameParameter.Value = employee.LastName;
                    LastNameParameter.Direction = ParameterDirection.Input;
                    parameters.Add(LastNameParameter);

                    IBSparameter CompanyAddressParameter = new IBSparameter();
                    CompanyAddressParameter.ParameterName = "@Address";
                    CompanyAddressParameter.DataType = DbType.String;
                    CompanyAddressParameter.Value = employee.Address;
                    CompanyAddressParameter.Direction = ParameterDirection.Input;
                    parameters.Add(CompanyAddressParameter);

                    IBSparameter EmployeeCityParameter = new IBSparameter();
                    EmployeeCityParameter.ParameterName = "@City";
                    EmployeeCityParameter.DataType = DbType.String;
                    EmployeeCityParameter.Value = employee.City;
                    EmployeeCityParameter.Direction = ParameterDirection.Input;
                    parameters.Add(EmployeeCityParameter);

                  


                    IBSparameter TitleParameter = new IBSparameter();
                    TitleParameter.ParameterName = "@Title";
                    TitleParameter.DataType = DbType.String;
                    TitleParameter.Value = employee.City;
                    TitleParameter.Direction = ParameterDirection.Input;
                    parameters.Add(TitleParameter);

                    IBSparameter RegionParameter = new IBSparameter();
                    RegionParameter.ParameterName = "@Region";
                    RegionParameter.DataType = DbType.String;
                    RegionParameter.Value = employee.Region;
                    RegionParameter.Direction = ParameterDirection.Input;
                    parameters.Add(RegionParameter);

                        
                    IBSparameter PostalCode_Parameter = new IBSparameter();
                    PostalCode_Parameter.ParameterName = "@PostalCode";
                    PostalCode_Parameter.DataType = DbType.String;
                    PostalCode_Parameter.Value = employee.PostalCode;
                    PostalCode_Parameter.Direction = ParameterDirection.Input;
                    parameters.Add(PostalCode_Parameter);

                         
                    IBSparameter Country_Parameter = new IBSparameter();
                    Country_Parameter.ParameterName = "@Country";
                    Country_Parameter.DataType = DbType.String;
                    Country_Parameter.Value = employee.PostalCode;
                    Country_Parameter.Direction = ParameterDirection.Input;
                    parameters.Add(Country_Parameter);



                    //IBSparameter PostalCodeParameter = new IBSparameter();
                    //PostalCodeParameter.ParameterName = "@PostalCode";
                    //PostalCodeParameter.DataType = DbType.String;
                    //PostalCodeParameter.Value = employee.PostalCode;
                    //PostalCodeParameter.Direction = ParameterDirection.Input;
                    //PostalCodeParameter.Add(PostalCodeParameter);

                    //IBSparameter CountryParameter = new IBSparameter();
                    //CountryParameter.ParameterName = "@Country";
                    //CountryParameter.DataType = DbType.String;
                    //CountryParameter.Value = employee.Country;
                    //CountryParameter.Direction = ParameterDirection.Input;
                    //CountryParameter.Add(CountryParameter);


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

                return ExecuteSqlNonQuery("ERP_Save_Employee", parameters);


            }

            catch (Exception ex)
            {
                //Logger.Error("CompanyDAL.SaveCompany(" + LoggedInUser + "," + CompanyCode + "," + company.CompanyCode + ")", ex);
            }
            return returnResult;

        }

        public ReturnResult DeleteEmployee(int employeeID)
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
                    CompanyIdParameter.ParameterName = "@EmployeeID";
                    CompanyIdParameter.DataType = DbType.String;
                    CompanyIdParameter.Value = employeeID;
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

        public EmployeeMaster GetEmployeeById(int employeeID)
        {
            List<EmployeeMaster> EmployeeList = new List<EmployeeMaster>();
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

                    IBSparameter EmployeeIDParameter = new IBSparameter();
                    EmployeeIDParameter.ParameterName = "@EmployeeID";
                    EmployeeIDParameter.DataType = DbType.String;
                    EmployeeIDParameter.Value = employeeID;
                    EmployeeIDParameter.Direction = ParameterDirection.Input;
                    parameters.Add(EmployeeIDParameter);

                }

                DataSet dsEmployee = null;
                dsEmployee = GetDataSet("ERP_Get_CompanyByID", parameters);

                var CompanyCollection = from EmployeeMaster in dsEmployee.Tables[0].AsEnumerable()
                                        select new EmployeeMaster
                                        {
                                            EmployeeId = EmployeeMaster.Field<int>("EmployeeID"),
                                            LastName = EmployeeMaster.Field<String>("LastName"),
                                            FirstName = EmployeeMaster.Field<String>("FirstName"),
                                            Region = EmployeeMaster.Field<String>("Region"),
                                            City = EmployeeMaster.Field<String>("City"),
                                            Address = EmployeeMaster.Field<String>("Address"),
                                            PostalCode = EmployeeMaster.Field<String>("PostalCode"),
                                        };
                EmployeeList = CompanyCollection.ToList<EmployeeMaster>();
            }

            catch (Exception ex)
            {
                //Logger.Error("CategoriesDAL.GetCategoryById(" + LoggedInUser + "," + CompanyCode + "," + categoryId + ")", ex);
            }

            return EmployeeList[0];

        }
    }
}
