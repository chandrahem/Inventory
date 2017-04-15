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
        public  List<Category> GetCategories()
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

                DataSet dsCategory = null;
                dsCategory = GetDataSet("ERP_Get_Categories", parameters);

                var MenuCollection = from Category in dsCategory.Tables[0].AsEnumerable()
                                     select new Category
                                     {
                                         categoryid = Category.Field<int>("categoryid"),
                                         CategoryCode = Category.Field<String>("CategoryCode"),
                                         CategoryName = Category.Field<String>("CategoryName"),
                                         Description = Category.Field<String>("Description"),
                                     };
                objCategories = MenuCollection.ToList<Category>();



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

                    IBSparameter Userparameter = new IBSparameter();
                    Userparameter.ParameterName = "@UserAccount";
                    Userparameter.DataType = DbType.String;
                    Userparameter.Value = LoggedInUser;
                    Userparameter.Direction = ParameterDirection.Input;
                    parameters.Add(Userparameter);



                    IBSparameter CatergoryIdParameter = new IBSparameter();
                    CatergoryIdParameter.ParameterName = "@CategoryId";
                    CatergoryIdParameter.DataType = DbType.String;
                    CatergoryIdParameter.Value = categoryId;
                    CatergoryIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(CatergoryIdParameter);

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

                    IBSparameter Userparameter = new IBSparameter();
                    Userparameter.ParameterName = "@UserAccount";
                    Userparameter.DataType = DbType.String;
                    Userparameter.Value = LoggedInUser;
                    Userparameter.Direction = ParameterDirection.Input;
                    parameters.Add(Userparameter);

                    IBSparameter CatergoryIdParameter = new IBSparameter();
                    CatergoryIdParameter.ParameterName = "@CategoryId";
                    CatergoryIdParameter.DataType = DbType.String;
                    CatergoryIdParameter.Value = category.categoryid;
                    CatergoryIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(CatergoryIdParameter);

                    IBSparameter CatergoryCodeParameter = new IBSparameter();
                    CatergoryCodeParameter.ParameterName = "@CategoryCode";
                    CatergoryCodeParameter.DataType = DbType.String;
                    CatergoryCodeParameter.Value = category.CategoryCode;
                    CatergoryCodeParameter.Direction = ParameterDirection.Input;
                    parameters.Add(CatergoryCodeParameter);


                    IBSparameter CatergoryNameParameter = new IBSparameter();
                    CatergoryNameParameter.ParameterName = "@CategoryName";
                    CatergoryNameParameter.DataType = DbType.String;
                    CatergoryNameParameter.Value = category.CategoryName;
                    CatergoryNameParameter.Direction = ParameterDirection.Input;
                    parameters.Add(CatergoryNameParameter);

                    IBSparameter CatergoryDescParameter = new IBSparameter();
                    CatergoryDescParameter.ParameterName = "@Description";
                    CatergoryDescParameter.DataType = DbType.String;
                    CatergoryDescParameter.Value = category.Description;
                    CatergoryDescParameter.Direction = ParameterDirection.Input;
                    parameters.Add(CatergoryDescParameter);

                    IBSparameter ReturnParameter = new IBSparameter();
                    ReturnParameter.ParameterName = "@ReturnValue";
                    ReturnParameter.DataType = DbType.Int32;
                    ReturnParameter.Value = "";
                    ReturnParameter.Direction = ParameterDirection.Output;
                    parameters.Add(ReturnParameter);
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

                    IBSparameter Userparameter = new IBSparameter();
                    Userparameter.ParameterName = "@UserAccount";
                    Userparameter.DataType = DbType.String;
                    Userparameter.Value = LoggedInUser;
                    Userparameter.Direction = ParameterDirection.Input;
                    parameters.Add(Userparameter);



                    IBSparameter CatergoryIdParameter = new IBSparameter();
                    CatergoryIdParameter.ParameterName = "@CategoryId";
                    CatergoryIdParameter.DataType = DbType.String;
                    CatergoryIdParameter.Value = categoryid;
                    CatergoryIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(CatergoryIdParameter);

                    IBSparameter ReturnParameter = new IBSparameter();
                    ReturnParameter.ParameterName = "@ReturnValue";
                    ReturnParameter.DataType = DbType.Int32;
                    ReturnParameter.Value = "";
                    ReturnParameter.Direction = ParameterDirection.Output;
                    parameters.Add(ReturnParameter);

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