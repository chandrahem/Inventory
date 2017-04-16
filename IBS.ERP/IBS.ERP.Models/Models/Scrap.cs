using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class Scrap {
        public int ScrapId { get; set; }
        [Required]
        public int StoreId { get; set; }
        [Required]
        public string Lot { get; set; }
        [Required]
        public string ProductCode { get; set; }
        [Required]
        public string ProductName { get; set; }
        public string BarCode { get; set; }
        public int? SupplierId { get; set; }
        public int? CategoryId { get; set; }
        [Required]
        public int Quantity { get; set; }
        public DateTime? ExpireDate { get; set; }
        public string UOM { get; set; }
        [Required]
        public decimal CompanyPrice { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
    }
}
