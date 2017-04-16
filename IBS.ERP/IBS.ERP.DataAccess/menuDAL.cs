using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;

namespace IBS.ERP.DataAccess
{
    public class menuDAL : BaseDAL
    {
        public static List<menu> GetMenu(string currentUser)
        {
            List<menu> objMenu = new List<menu>();


            try
            {

                DbCommand command = database.GetStoredProcCommand("ERP_Get_Menu"); // SP name

                //database.AddInParameter(command, "@AssignmentID", DbType.Int32, assignmentID);
                // database.AddInParameter(command, "@LoginUserName", DbType.String, currentUser);
                database.AddInParameter(command, "@currentUser", DbType.String, currentUser);

                DataSet dsMenu = database.ExecuteDataSet(command);

                var menuCollection = from menu in dsMenu.Tables[0].AsEnumerable()
                                     select new menu
                                           {
                                               ID = menu.Field<int?>("ID"),
                                               ParentID = menu.Field<int?>("ParentID"),
                                               Title = menu.Field<String>("Title"),
                                               ActionName = menu.Field<String>("ActionName"),
                                               ControllerName = menu.Field<String>("ControllerName"),
                                               Description = menu.Field<String>("Description")

                                           };

                objMenu = menuCollection.ToList<menu>();



            }

            catch (Exception ex)
            {
                //Logger.Error("NIBIB.EA.DataAccessLayer.AssignmentDal.GetAssignmentList(" + assignmentID + "," + currentUser + "," + isAssignmentOwner + ")", ex);
            }

            return objMenu;

        }
    }
}