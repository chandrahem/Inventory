using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class PoHead {
        public PoHead() { }
        public int PoId { get; set; }
        [Required]
        public int StoreId { get; set; }
        [Required]
        public string PoNumber { get; set; }
        public int? SupplierId { get; set; }
        public DateTime? ExpectedDeliveryDate { get; set; }
        public decimal? SubtotalAmount { get; set; }
        public decimal? TaxAmount { get; set; }
        public decimal? TotalAmount { get; set; }
        public string Note { get; set; }
        public string PoStatus { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public short? LockStatus { get; set; }
        public bool? Deleted { get; set; }
    }
}
