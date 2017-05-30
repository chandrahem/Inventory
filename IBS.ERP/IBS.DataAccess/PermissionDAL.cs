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

                    IBSparameter userParameter = new IBSparameter();
                    userParameter.ParameterName = "@UserAccount";
                    userParameter.DataType = DbType.String;
                    userParameter.Value = LoggedInUser;
                    userParameter.Direction = ParameterDirection.Input;
                    parameters.Add(userParameter);

                    IBSparameter userRoleParameter = new IBSparameter();
                    userRoleParameter.ParameterName = "@RoleId";
                    userRoleParameter.DataType = DbType.String;
                    userRoleParameter.Value = UserRoleId;
                    userRoleParameter.Direction = ParameterDirection.Input;
                    parameters.Add(userRoleParameter);

                    IBSparameter permissionNameParameter = new IBSparameter();
                    permissionNameParameter.ParameterName = "@PermissionName";
                    permissionNameParameter.DataType = DbType.String;
                    permissionNameParameter.Value = permissionName;
                    permissionNameParameter.Direction = ParameterDirection.Input;
                    parameters.Add(permissionNameParameter);

                }
                else if (DBProvider == ProviderName.MySqlClient)
                {

                    IBSparameter userParameter = new IBSparameter();
                    userParameter.ParameterName = "p_UserAccount";
                    userParameter.DataType = DbType.String;
                    userParameter.Value = LoggedInUser;
                    userParameter.Direction = ParameterDirection.Input;
                    parameters.Add(userParameter);

                    IBSparameter userRoleParameter = new IBSparameter();
                    userRoleParameter.ParameterName = "p_RoleId";
                    userRoleParameter.DataType = DbType.String;
                    userRoleParameter.Value = UserRoleId;
                    userRoleParameter.Direction = ParameterDirection.Input;
                    parameters.Add(userRoleParameter);

                    IBSparameter permissionNameParameter = new IBSparameter();
                    permissionNameParameter.ParameterName = "p_PermissionName";
                    permissionNameParameter.DataType = DbType.String;
                    permissionNameParameter.Value = permissionName;
                    permissionNameParameter.Direction = ParameterDirection.Input;
                    parameters.Add(permissionNameParameter);
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
