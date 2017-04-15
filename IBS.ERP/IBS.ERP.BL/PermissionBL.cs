using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IBS.ERP.DataAccess;
namespace IBS.ERP.BL
{
    public class PermissionBL
    {
        public bool IsUserHasPermission(string permissionName)
        {
            PermissionDAL permissionDAL = new PermissionDAL();

            return permissionDAL.isUserHasPermission(permissionName);
        }
    }
}
