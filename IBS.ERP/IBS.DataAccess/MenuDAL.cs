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


                if (DBProvider == ProviderName.SqlClient)
                {

                    IBSparameter Userparameter = new IBSparameter();
                    Userparameter.ParameterName = "@UserAccount";
                    Userparameter.DataType = DbType.String;
                    Userparameter.Value = LoggedInUser;
                    Userparameter.Direction = ParameterDirection.Input;
                    parameters.Add(Userparameter);

                    IBSparameter UserRoleparameter = new IBSparameter();
                    UserRoleparameter.ParameterName = "@RoleID";
                    UserRoleparameter.DataType = DbType.Int32;
                    UserRoleparameter.Value = UserRoleId;
                    UserRoleparameter.Direction = ParameterDirection.Input;
                    parameters.Add(UserRoleparameter);
                  

                }

                DataSet dsMenu= null;
                dsMenu = GetDataSet("ERP_Get_Menu", parameters);

                var MenuCollection = from Menus in dsMenu.Tables[0].AsEnumerable()
                                     select new Menus
                                          {
                                              ModuleId = Menus.Field<int>("ModuleId"),
                                              ModuleName = Menus.Field<String>("ModuleName"),
                                              ParentId = Menus.Field<int?>("ParentId"),
                                              ActionName = Menus.Field<String>("ActionName"),
                                              ControllerName = Menus.Field<String>("ControllerName"),

                                          };
                menuList = MenuCollection.ToList<Menus>();

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