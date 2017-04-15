using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class Purchase {
        public Purchase() { }
        public int StockId { get; set; }
        [Required]
        public int StoreId { get; set; }
        [Required]
        public string PoInvoiceNo { get; set; }
        public DateTime? InvoiceDate { get; set; }
        public string Lot { get; set; }
        [Required]
        public string PoNumber { get; set; }
        public int? SupplierId { get; set; }
        public DateTime? ReceivedDate { get; set; }
        public string StockAcceptedBy { get; set; }
        public decimal? SubTotalAmount { get; set; }
        public decimal? TotalAmount { get; set; }
        public DateTime? PaymentDueDate { get; set; }
        public decimal? BalanceAmount { get; set; }
        public string Note { get; set; }
        public string PoStatus { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public short? LockStatus { get; set; }
        public bool? Deleted { get; set; }
        public decimal? TaxAmount { get; set; }
    }
}
