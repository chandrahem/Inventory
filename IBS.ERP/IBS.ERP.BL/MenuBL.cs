using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IBS.ERP.Models;
using IBS.ERP.DataAccess;
namespace IBS.ERP.BL
{
    public class MenuBL
    {
        public List<Menus> getMenuDetail()
        {

            MenuDAL menuDAL = new MenuDAL();
            return menuDAL.GetMenu();

        }
    }
}
