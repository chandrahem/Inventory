using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class PoDetail {
        public int PoDetailId { get; set; }
        [Required]
        public int PoId { get; set; }
        [Required]
        public string ProductCode { get; set; }
        [Required]
        public string ProductId { get; set; }
        public string BarCode { get; set; }
        [Required]
        public int Quantity { get; set; }
        public DateTime? ExpireDate { get; set; }
        public string Uom { get; set; }
        [Required]
        public decimal CompanyPrice { get; set; }
        [Required]
        public decimal SubtotalAmount { get; set; }
        [Required]
        public decimal TaxAmount { get; set; }
        [Required]
        public decimal TotalAmount { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public short? LockStatus { get; set; }
        public bool? Deleted { get; set; }
    }
}
