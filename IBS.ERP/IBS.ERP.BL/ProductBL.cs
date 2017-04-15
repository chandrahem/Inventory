using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IBS.ERP.Models;
using IBS.ERP.DataAccess;
namespace IBS.ERP.BL
{
   public  class ProductBL
    {
       public List<ProductMaster> GetProductList()
        {
            ProductDAL productDAL = new ProductDAL();
            return productDAL.GetProductList();

        }

       public ReturnResult SaveProduct(ProductMaster productMaster)
        {
            ProductDAL productDAL = new ProductDAL();
            return productDAL.SaveProduct(productMaster);

        }
       
    }
}
