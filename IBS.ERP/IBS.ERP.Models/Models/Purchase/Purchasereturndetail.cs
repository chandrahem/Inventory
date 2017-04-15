using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class PurchaseReturnDetail {
        public int Id { get; set; }
        [Required]
        public int PurchaseReturnId { get; set; }
        [Required]
        public string ProductCode { get; set; }
        public string BarCode { get; set; }
        [Required]
        public int Quantity { get; set; }
        public decimal? SubTotalAmount { get; set; }
        public decimal? TaxAmount { get; set; }
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
