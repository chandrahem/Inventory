using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IBS.ERP.Models;
using IBS.ERP.DataAccess;
namespace IBS.ERP.BL
{
    public class SuppliersBL
    {
       public List<Suppliers> GetSuppliersList()
       {
           SuppliersDAL objSuppliersDAL = new SuppliersDAL();
           return objSuppliersDAL.GetSuppliersList();
       }
         public ReturnResult SaveSupplier(Suppliers objSupplier)
       {
           SuppliersDAL objSuppliersDAL = new SuppliersDAL();
           return objSuppliersDAL.SaveSupplier(objSupplier);
       }

         public ReturnResult DeleteSupplier(int supplierId)
       {
           SuppliersDAL objSuppliersDAL = new SuppliersDAL();
           return objSuppliersDAL.DeleteSupplier(supplierId);
       }
         public Suppliers GetSupplierById(int id)
         {
             SuppliersDAL objSuppliersDAL = new SuppliersDAL();
             return objSuppliersDAL.GetSupplierById(id);

         }
        
    }
}
