using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IBS.ERP.DataAccess;
using IBS.ERP.Models;

namespace IBS.ERP.BL
{
    public class StoresBL
    {
        public List<Stores> GetStores()
        {
            StoresDAL StoresDAL = new StoresDAL();
            return StoresDAL.GetStores();

        }

        public ReturnResult SaveStores(Stores store)
        {
            StoresDAL storeDAL = new StoresDAL();
            return storeDAL.SaveStore(store);

        }

        public ReturnResult DeleteStore(int storeID)
        {
            StoresDAL storeDAL = new StoresDAL();
            return storeDAL.DeleteStore(storeID);

        }

        public Stores GetCompanyById(int storeID)
        {
            StoresDAL storeDAL = new StoresDAL();
            return storeDAL.GetStoreById(storeID);

        }
    }
}
