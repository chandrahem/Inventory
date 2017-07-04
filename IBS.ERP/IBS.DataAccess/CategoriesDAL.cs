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
    public class CategoriesDAL: baseDAL
    {
        public CategoriesDAL() { }

        public CategoriesDAL(string connectionStringCompanyDatabase, string userAccount, string roleId, string companyDBProvider, string companyCode)
            : base(connectionStringCompanyDatabase, userAccount, roleId, companyDBProvider, companyCode)
        {

        }
       
        public List<Category> GetCategories()
        {
            List<Category> objCategories = new List<Category>();

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
                else if (DBProvider == ProviderName.MySqlClient)
                {
                    IBSparameter userParameter = new IBSparameter();
                    userParameter.ParameterName = "p_UserAccount";
                    userParameter.DataType = DbType.String;
                    userParameter.Value = LoggedInUser;
                    userParameter.Direction = ParameterDirection.Input;
                    parameters.Add(userParameter);
                }

                DataSet dsCategory = null;
                dsCategory = GetDataSet("ERP_Get_Categories", parameters);

                var menuCollection = from Category in dsCategory.Tables[0].AsEnumerable()
                                     select new Category
                                     {
                                         categoryid = Category.Field<int>("categoryid"),
                                         CategoryCode = Category.Field<String>("CategoryCode"),
                                         CategoryName = Category.Field<String>("CategoryName"),
                                         Description = Category.Field<String>("Description"),
                                     };
                objCategories = menuCollection.ToList<Category>();



            }

            catch (Exception ex)
            {
                Logger.Error("CategoriesDAL.objCategories(" + LoggedInUser + "," + CompanyCode + ")", ex);
            }

            return objCategories;

        }

        public Category GetCategoryById(int categoryId)
        {
            List<Category> categoryList = new List<Category>();
           // List<IBSparameter> parameters = new List<IBSparameter>();

            try
            {

                if (DBProvider == ProviderName.SqlClient)
                {

                    IBSparameter userParameter = new IBSparameter();
                    userParameter.ParameterName = "@UserAccount";
                    userParameter.DataType = DbType.String;
                    userParameter.Value = LoggedInUser;
                    userParameter.Direction = ParameterDirection.Input;
                    parameters.Add(userParameter);



                    IBSparameter catergoryIdParameter = new IBSparameter();
                    catergoryIdParameter.ParameterName = "@CategoryId";
                    catergoryIdParameter.DataType = DbType.String;
                    catergoryIdParameter.Value = categoryId;
                    catergoryIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(catergoryIdParameter);

                }
                else if (DBProvider == ProviderName.MySqlClient)
                {
                    IBSparameter userParameter = new IBSparameter();
                    userParameter.ParameterName = "p_UserAccount";
                    userParameter.DataType = DbType.String;
                    userParameter.Value = LoggedInUser;
                    userParameter.Direction = ParameterDirection.Input;
                    parameters.Add(userParameter);

                    IBSparameter catergoryIdParameter = new IBSparameter();
                    catergoryIdParameter.ParameterName = "p_CategoryId";
                    catergoryIdParameter.DataType = DbType.String;
                    catergoryIdParameter.Value = categoryId;
                    catergoryIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(catergoryIdParameter);
                }

                DataSet dsCategory = null;
                dsCategory = GetDataSet("ERP_Get_CategoryById", parameters);

                var CategoryCollection = from Category in dsCategory.Tables[0].AsEnumerable()
                                     select new Category
                                     {
                                         categoryid = Category.Field<int>("categoryid"),
                                         CategoryCode = Category.Field<String>("CategoryCode"),
                                         CategoryName = Category.Field<String>("CategoryName"),
                                         Description = Category.Field<String>("Description"),
                                     };
                categoryList = CategoryCollection.ToList<Category>();
            }

            catch (Exception ex)
            {
                Logger.Error("CategoriesDAL.GetCategoryById(" + LoggedInUser + "," + CompanyCode + "," + categoryId + ")", ex);
            }

            return categoryList[0];

        }
        public ReturnResult SaveCategory(Category category)
        {
            Category objCategory = new Category();
            ReturnResult returnResult = new ReturnResult();

            try
            {

                if (DBProvider == ProviderName.SqlClient)
                {

                    IBSparameter userParameter = new IBSparameter();
                    userParameter.ParameterName = "@UserAccount";
                    userParameter.DataType = DbType.String;
                    userParameter.Value = LoggedInUser;
                    userParameter.Direction = ParameterDirection.Input;
                    parameters.Add(userParameter);

                    IBSparameter catergoryIdParameter = new IBSparameter();
                    catergoryIdParameter.ParameterName = "@CategoryId";
                    catergoryIdParameter.DataType = DbType.String;
                    catergoryIdParameter.Value = category.categoryid;
                    catergoryIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(catergoryIdParameter);

                    IBSparameter catergoryCodeParameter = new IBSparameter();
                    catergoryCodeParameter.ParameterName = "@CategoryCode";
                    catergoryCodeParameter.DataType = DbType.String;
                    catergoryCodeParameter.Value = category.CategoryCode;
                    catergoryCodeParameter.Direction = ParameterDirection.Input;
                    parameters.Add(catergoryCodeParameter);


                    IBSparameter catergoryNameParameter = new IBSparameter();
                    catergoryNameParameter.ParameterName = "@CategoryName";
                    catergoryNameParameter.DataType = DbType.String;
                    catergoryNameParameter.Value = category.CategoryName;
                    catergoryNameParameter.Direction = ParameterDirection.Input;
                    parameters.Add(catergoryNameParameter);

                    IBSparameter catergoryDescParameter = new IBSparameter();
                    catergoryDescParameter.ParameterName = "@Description";
                    catergoryDescParameter.DataType = DbType.String;
                    catergoryDescParameter.Value = category.Description;
                    catergoryDescParameter.Direction = ParameterDirection.Input;
                    parameters.Add(catergoryDescParameter);

                    IBSparameter returnParameter = new IBSparameter();
                    returnParameter.ParameterName = "@ReturnValue";
                    returnParameter.DataType = DbType.Int32;
                    returnParameter.Value = "";
                    returnParameter.Direction = ParameterDirection.Output;
                    parameters.Add(returnParameter);
                }
                else if (DBProvider == ProviderName.MySqlClient)
                {
                    IBSparameter userParameter = new IBSparameter();
                    userParameter.ParameterName = "p_UserAccount";
                    userParameter.DataType = DbType.String;
                    userParameter.Value = LoggedInUser;
                    userParameter.Direction = ParameterDirection.Input;
                    parameters.Add(userParameter);

                    IBSparameter catergoryIdParameter = new IBSparameter();
                    catergoryIdParameter.ParameterName = "p_CategoryId";
                    catergoryIdParameter.DataType = DbType.Int32;
                    catergoryIdParameter.Value = category.categoryid;
                    catergoryIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(catergoryIdParameter);

                    IBSparameter catergoryCodeParameter = new IBSparameter();
                    catergoryCodeParameter.ParameterName = "p_CategoryCode";
                    catergoryCodeParameter.DataType = DbType.String;
                    catergoryCodeParameter.Value = category.CategoryCode;
                    catergoryCodeParameter.Direction = ParameterDirection.Input;
                    parameters.Add(catergoryCodeParameter);


                    IBSparameter catergoryNameParameter = new IBSparameter();
                    catergoryNameParameter.ParameterName = "p_CategoryName";
                    catergoryNameParameter.DataType = DbType.String;
                    catergoryNameParameter.Value = category.CategoryName;
                    catergoryNameParameter.Direction = ParameterDirection.Input;
                    parameters.Add(catergoryNameParameter);

                    IBSparameter catergoryDescParameter = new IBSparameter();
                    catergoryDescParameter.ParameterName = "p_Description";
                    catergoryDescParameter.DataType = DbType.String;
                    catergoryDescParameter.Value = category.Description;
                    catergoryDescParameter.Direction = ParameterDirection.Input;
                    parameters.Add(catergoryDescParameter);

                    IBSparameter returnParameter = new IBSparameter();
                    returnParameter.ParameterName = "p_ReturnValue";
                    returnParameter.DataType = DbType.Int32;
                    returnParameter.Value = "";
                    returnParameter.Direction = ParameterDirection.Output;
                    parameters.Add(returnParameter);
                }
                //ReturnResult returnValue = new ReturnResult();
                return ExecuteSqlNonQuery("ERP_Save_Category", parameters);
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
                Logger.Error("CategoriesDAL.SaveCategory(" + LoggedInUser + "," + CompanyCode + "," + category.CategoryCode + ")", ex);
            }
            return returnResult;

        }


        public ReturnResult DeleteCategory(int categoryid)
        {
            //Category objCategory = new Category();
            ReturnResult returnResult = new ReturnResult();

            try
            {
                //int b=1, a=0;
                //int c = b / a;
                if (DBProvider == ProviderName.SqlClient)
                {

                    IBSparameter userparameter = new IBSparameter();
                    userparameter.ParameterName = "@UserAccount";
                    userparameter.DataType = DbType.String;
                    userparameter.Value = LoggedInUser;
                    userparameter.Direction = ParameterDirection.Input;
                    parameters.Add(userparameter);



                    IBSparameter catergoryIdParameter = new IBSparameter();
                    catergoryIdParameter.ParameterName = "@CategoryId";
                    catergoryIdParameter.DataType = DbType.Int32;
                    catergoryIdParameter.Value = categoryid;
                    catergoryIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(catergoryIdParameter);

                    IBSparameter returnParameter = new IBSparameter();
                    returnParameter.ParameterName = "@ReturnValue";
                    returnParameter.DataType = DbType.Int32;
                    returnParameter.Value = "";
                    returnParameter.Direction = ParameterDirection.Output;
                    parameters.Add(returnParameter);

                }
                else if (DBProvider == ProviderName.MySqlClient)
                {
                    IBSparameter userParameter = new IBSparameter();
                    userParameter.ParameterName = "p_UserAccount";
                    userParameter.DataType = DbType.String;
                    userParameter.Value = LoggedInUser;
                    userParameter.Direction = ParameterDirection.Input;
                    parameters.Add(userParameter);

                    IBSparameter catergoryIdParameter = new IBSparameter();
                    catergoryIdParameter.ParameterName = "p_CategoryId";
                    catergoryIdParameter.DataType = DbType.Int32;
                    catergoryIdParameter.Value = categoryid;
                    catergoryIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(catergoryIdParameter);

                    IBSparameter returnParameter = new IBSparameter();
                    returnParameter.ParameterName = "p_ReturnValue";
                    returnParameter.DataType = DbType.Int32;
                    returnParameter.Value = "";
                    returnParameter.Direction = ParameterDirection.Output;
                    parameters.Add(returnParameter);
                }
                return ExecuteSqlNonQuery("ERP_Delete_Category", parameters);
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
                Logger.Error("CategoriesDAL.DeleteCategory(" + LoggedInUser + "," + CompanyCode + "," + categoryid + ")", ex);
            }
            return returnResult;
            

        }
    }
}