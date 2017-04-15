using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IBS.ERP.Models;
using System.Data;
namespace IBS.ERP.DataAccess
{
    public class ProductDAL :baseDAL
    {
        public List<ProductMaster> GetProductList()
        {
            List<ProductMaster> objProductList = new List<ProductMaster>();

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

                DataSet dsProduct = null;
                dsProduct = GetDataSet("ERP_Get_ProductList", parameters);

                var ProductCollection = from ProductMaster in dsProduct.Tables[0].AsEnumerable()
                                     select new ProductMaster
                                     {
                                         ProductId = ProductMaster.Field<int>("ProductId"),
                                         ProductCode = ProductMaster.Field<String>("ProductCode"),
                                         ProductName = ProductMaster.Field<String>("ProductName"),
                                         BarCode = ProductMaster.Field<String>("BarCode"),
                                         SupplierName = ProductMaster.Field<String>("SupplierName"),
                                         CategoryName = ProductMaster.Field<String>("CategoryName"),
                                         CompanyPrice = ProductMaster.Field<decimal>("CompanyPrice"),
                                         RePOorderLevel = ProductMaster.Field<int>("RePOorderLevel"),
                                         RePOorderQuantity = ProductMaster.Field<int>("RePOorderQuantity"),
                                         UOM = ProductMaster.Field<String>("UOM"),
                                         ReSOorderLevel = ProductMaster.Field<int>("ReSOorderLevel"),
                                         ReSOorderQuantity = ProductMaster.Field<int>("ReSOorderQuantity")
                                     };
                objProductList = ProductCollection.ToList<ProductMaster>();



            }

            catch (Exception ex)
            {
                Logger.Error("ProductDAL.GetProductList(" + LoggedInUser + "," + CompanyCode + ")", ex);
            }

            return objProductList;

        }

        public ReturnResult SaveProduct(ProductMaster product)
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

                    IBSparameter ProductIdParameter = new IBSparameter();
                    ProductIdParameter.ParameterName = "@ProductId";
                    ProductIdParameter.DataType = DbType.String;
                    ProductIdParameter.Value = product.ProductId;
                    ProductIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(ProductIdParameter);

                    IBSparameter ProductCodeParameter = new IBSparameter();
                    ProductCodeParameter.ParameterName = "@ProductCode";
                    ProductCodeParameter.DataType = DbType.String;
                    ProductCodeParameter.Value = product.ProductCode;
                    ProductCodeParameter.Direction = ParameterDirection.Input;
                    parameters.Add(ProductCodeParameter);


                    IBSparameter CatergoryNameParameter = new IBSparameter();
                    CatergoryNameParameter.ParameterName = "@ProductName";
                    CatergoryNameParameter.DataType = DbType.String;
                    CatergoryNameParameter.Value = product.CategoryName;
                    CatergoryNameParameter.Direction = ParameterDirection.Input;
                    parameters.Add(CatergoryNameParameter);

                    IBSparameter UOMParameter = new IBSparameter();
                    UOMParameter.ParameterName = "@UOM";
                    UOMParameter.DataType = DbType.String;
                    UOMParameter.Value = product.UOM;
                    UOMParameter.Direction = ParameterDirection.Input;
                    parameters.Add(UOMParameter);

                    IBSparameter BarcodeParameter = new IBSparameter();
                    BarcodeParameter.ParameterName = "@Barcode";
                    BarcodeParameter.DataType = DbType.String;
                    BarcodeParameter.Value = product.BarCode;
                    BarcodeParameter.Direction = ParameterDirection.Input;
                    parameters.Add(BarcodeParameter);

                    IBSparameter CategoryIdParameter = new IBSparameter();
                    CategoryIdParameter.ParameterName = "@CategoryId";
                    CategoryIdParameter.DataType = DbType.Int32;
                    CategoryIdParameter.Value = product.CategoryId;
                    CategoryIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(CategoryIdParameter);

                    IBSparameter SupplierIdParameter = new IBSparameter();
                    SupplierIdParameter.ParameterName = "@SupplierId";
                    SupplierIdParameter.DataType = DbType.Int32;
                    SupplierIdParameter.Value = product.SupplierId;
                    SupplierIdParameter.Direction = ParameterDirection.Input;
                    parameters.Add(SupplierIdParameter);

                    IBSparameter CompanyPriceParameter = new IBSparameter();
                    CompanyPriceParameter.ParameterName = "@CompanyPrice";
                    CompanyPriceParameter.DataType = DbType.Decimal;
                    CompanyPriceParameter.Value = product.CompanyPrice;
                    CompanyPriceParameter.Direction = ParameterDirection.Input;
                    parameters.Add(CompanyPriceParameter);

                    IBSparameter RePOorderLevelParameter = new IBSparameter();
                    RePOorderLevelParameter.ParameterName = "@RePOorderLevel";
                    RePOorderLevelParameter.DataType = DbType.Int32;
                    RePOorderLevelParameter.Value = product.RePOorderLevel;
                    RePOorderLevelParameter.Direction = ParameterDirection.Input;
                    parameters.Add(RePOorderLevelParameter);

                    IBSparameter RePOorderQuantityParameter = new IBSparameter();
                    RePOorderQuantityParameter.ParameterName = "@RePOorderQuantity";
                    RePOorderQuantityParameter.DataType = DbType.Int32;
                    RePOorderQuantityParameter.Value = product.RePOorderQuantity;
                    RePOorderQuantityParameter.Direction = ParameterDirection.Input;
                    parameters.Add(RePOorderQuantityParameter);

                    //IBSparameter ReSOorderLevelParameter = new IBSparameter();
                    //ReSOorderLevelParameter.ParameterName = "@ReSOorderLevel";
                    //ReSOorderLevelParameter.DataType = DbType.Int32;
                    //ReSOorderLevelParameter.Value = product.ReSOorderLevel;
                    //ReSOorderLevelParameter.Direction = ParameterDirection.Input;
                    //parameters.Add(ReSOorderLevelParameter);

                    //IBSparameter ReSOorderQuantityParameter = new IBSparameter();
                    //ReSOorderQuantityParameter.ParameterName = "@ReSOorderQuantity";
                    //ReSOorderQuantityParameter.DataType = DbType.Int32;
                    //ReSOorderQuantityParameter.Value = product.ReSOorderQuantity;
                    //ReSOorderQuantityParameter.Direction = ParameterDirection.Input;
                    //parameters.Add(ReSOorderQuantityParameter);

                    IBSparameter ReturnParameter = new IBSparameter();
                    ReturnParameter.ParameterName = "@ReturnValue";
                    ReturnParameter.DataType = DbType.Int32;
                    ReturnParameter.Value = "";
                    ReturnParameter.Direction = ParameterDirection.Output;
                    parameters.Add(ReturnParameter);
                }
                //ReturnResult returnValue = new ReturnResult();
                return ExecuteSqlNonQuery("ERP_Save_Product", parameters);
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
                Logger.Error("ProductDAL.SaveProduct(" + LoggedInUser + "," + CompanyCode + "," + product.ProductCode + ")", ex);
            }
            return returnResult;

        }
    }
}
