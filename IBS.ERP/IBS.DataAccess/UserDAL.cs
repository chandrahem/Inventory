using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IBS.ERP;
using IBS.ERP.Models;
using System.Data;
namespace IBS.ERP.DataAccess
{
    public class UserDAL : baseDAL
    {
       public UserDAL() :base("UserDatabase")
        {

        }
        public List<LoginViewModel> getUserLoginDetail(LoginViewModel userMaster)
        {
            List<LoginViewModel> loginView= new List<LoginViewModel>();
            List<IBSparameter> parameters= new List<IBSparameter>();
            try
            {
                System.Web.HttpContext.Current.Session["UserAccount"] = userMaster.UserAccount;

                if (DBProvider == ProviderName.SqlClient)
                {

                    IBSparameter Userparameter = new IBSparameter();
                    Userparameter.ParameterName = "@UserAccount";
                    Userparameter.DataType = DbType.String;
                    Userparameter.Value = userMaster.UserAccount;
                    Userparameter.Direction = ParameterDirection.Input;
                    parameters.Add(Userparameter);

                    IBSparameter PasswordParameter = new IBSparameter();
                    PasswordParameter.ParameterName = "@Password";
                    PasswordParameter.DataType = DbType.String;
                    PasswordParameter.Value = userMaster.Password;
                    PasswordParameter.Direction = ParameterDirection.Input;
                    parameters.Add(PasswordParameter);
                 
                }

                DataSet dsLoginViewModel = null;
                dsLoginViewModel = GetDataSet("GetUserDetail", parameters);

                 var LoginViewCollection = from LoginViewModel in dsLoginViewModel.Tables[0].AsEnumerable()
                                              select new LoginViewModel
                                              {
                                                  UserAccount = LoginViewModel.Field<String>("UserAccount"),
                                                  SignInStatus = LoginViewModel.Field<String>("SignInStatus"),
                                                  RoleId = LoginViewModel.Field<int>("RoleId"),
                                                  CompanyCode = LoginViewModel.Field<String>("CompanyCode"),
                                                  DBConnectionString = LoginViewModel.Field<String>("DBConnectionString"),
                                                  DBProviderName = LoginViewModel.Field<String>("DBProviderName"),

                                              };
                 loginView = LoginViewCollection.ToList<LoginViewModel>();

            }
            catch(Exception ex)
            {

            }
            return loginView;
        }

       
    }
}
