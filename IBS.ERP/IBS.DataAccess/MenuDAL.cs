using IBS.ERP.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;

namespace IBS.ERP.DataAccess
{
    public class MenuDAL : baseDAL
    {
        public List<Menus> GetMenu()
        {
            List<Menus> menuList = new List<Menus>();
            List<IBSparameter> parameters = new List<IBSparameter>();

            try
            {
                if (LoggedInUser == null && System.Web.HttpContext.Current.Session["UserAccount"] != null)
                {
                    LoggedInUser = Convert.ToString(System.Web.HttpContext.Current.Session["UserAccount"]);
                }

                if (DBProvider == ProviderName.SqlClient)
                {

                    IBSparameter userParameter = new IBSparameter();
                    userParameter.ParameterName = "@UserAccount";
                    userParameter.DataType = DbType.String;
                    userParameter.Value = LoggedInUser;
                    userParameter.Direction = ParameterDirection.Input;
                    parameters.Add(userParameter);

                    IBSparameter userRoleParameter = new IBSparameter();
                    userRoleParameter.ParameterName = "@RoleID";
                    userRoleParameter.DataType = DbType.Int32;
                    userRoleParameter.Value = UserRoleId;
                    userRoleParameter.Direction = ParameterDirection.Input;
                    parameters.Add(userRoleParameter);
                  

                }
                else if (DBProvider == ProviderName.MySqlClient)
                {
                    IBSparameter userParameter = new IBSparameter();
                    userParameter.ParameterName = "p_UserAccount";
                    userParameter.DataType = DbType.String;
                    userParameter.Value = LoggedInUser;
                    userParameter.Direction = ParameterDirection.Input;
                    parameters.Add(userParameter);

                    IBSparameter passwordParameter = new IBSparameter();
                    passwordParameter.ParameterName = "p_RoleID";
                    passwordParameter.DataType = DbType.Int32;
                    passwordParameter.Value = UserRoleId;
                    passwordParameter.Direction = ParameterDirection.Input;
                    parameters.Add(passwordParameter);

                    
                }
                DataSet dsMenu= null;
                dsMenu = GetDataSet("ERP_Get_Menu", parameters);

                var menuCollection = from Menus in dsMenu.Tables[0].AsEnumerable()
                                     select new Menus
                                          {
                                              ModuleId = Menus.Field<int>("ModuleId"),
                                              ModuleName = Menus.Field<String>("ModuleName"),
                                              ParentId = Menus.Field<int?>("ParentId"),
                                              ActionName = Menus.Field<String>("ActionName"),
                                              ControllerName = Menus.Field<String>("ControllerName"),

                                          };
                menuList = menuCollection.ToList<Menus>();

                System.Web.HttpContext.Current.Session["CompanyName"] = "NIBIB NEW"; // take this from output parameter

            }

            catch (Exception ex)
            {
                //Logger.Error("NIBIB.EA.DataAccessLayer.AssignmentDal.GetAssignmentList(" + assignmentID + "," + currentUser + "," + isAssignmentOwner + ")", ex);
            }

            return menuList;

        }
    }
}