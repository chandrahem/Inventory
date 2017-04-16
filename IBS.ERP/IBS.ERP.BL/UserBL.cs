using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IBS.ERP.DataAccess;
using IBS.ERP.Models;
namespace IBS.ERP.BL
{
    public class UserBL
    {
        public List<LoginViewModel> getUserLoginDetail(LoginViewModel userMaster)
        {
            //Usermaster userName = null;
            UserDAL userDAL = new UserDAL();
            return userDAL.getUserLoginDetail(userMaster);
             
        }
    }
}
