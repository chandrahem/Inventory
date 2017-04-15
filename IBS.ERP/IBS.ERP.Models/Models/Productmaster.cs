using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class ProductMaster {
        public int ProductId { get; set; }
        [Required]
        [Display(Name = "Product Code")]
        public string ProductCode { get; set; }
        [Required]
        [Display(Name = "Product Name")]
        public string ProductName { get; set; }
        public string BarCode { get; set; }

        List<Category> Categories { get; set; }
        List<Suppliers> SuppliersList { get; set; }

        public int? CategoryId { get; set; }
        [Display(Name = "Category Name")]
        public string CategoryName { get; set; }
        public int? SupplierId { get; set; }
        [Display(Name = "Supplier Name")]
        public string SupplierName { get; set; }
        public DateTime? ExpireDate { get; set; }
        public string UOM { get; set; }

        [Display(Name = "Company Price")]
        public decimal CompanyPrice { get; set; }
        public bool? AutoPO { get; set; }
        [Display(Name = "Reorder Level(PO)")]
        public int? RePOorderLevel { get; set; }
         [Display(Name = "Reorder Quantity(PO)")]
        public int? RePOorderQuantity { get; set; }
         [Display(Name = "Reorder Level(SO)")]
        public int? ReSOorderLevel { get; set; }
         [Display(Name = "Reorder Quantity(SO)")]
        public int? ReSOorderQuantity { get; set; }
        public bool? AutoSO { get; set; }
        public int? LockStatus { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
      
        public bool Discontinued { get; set; }
    }
}
