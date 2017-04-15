using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IBS.ERP.DataAccess
{
    public class PermissionDAL : baseDAL
    {
        public bool isUserHasPermission(string permissionName)
        {
            bool returnValue = false;
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

                    IBSparameter UserRoleParameter = new IBSparameter();
                    UserRoleParameter.ParameterName = "@RoleId";
                    UserRoleParameter.DataType = DbType.String;
                    UserRoleParameter.Value = UserRoleId;
                    UserRoleParameter.Direction = ParameterDirection.Input;
                    parameters.Add(UserRoleParameter);

                    IBSparameter PermissionNameParameter = new IBSparameter();
                    PermissionNameParameter.ParameterName = "@PermissionName";
                    PermissionNameParameter.DataType = DbType.String;
                    PermissionNameParameter.Value = permissionName;
                    PermissionNameParameter.Direction = ParameterDirection.Input;
                    parameters.Add(PermissionNameParameter);

                }

                DataSet dsPermission = null;
                dsPermission = GetDataSet("ERP_Is_Role_HasPermission", parameters);

                if (dsPermission != null && Convert.ToBoolean(dsPermission.Tables[0].Rows[0][0]))
                {
                    returnValue = true;
                }


            }
            catch (Exception ex)
            {

            }
            return returnValue;

        }
    }
}
