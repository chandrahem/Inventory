using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class PurchaseReturn {
        public PurchaseReturn() { }
        public int PurchaseReturnId { get; set; }
        [Required]
        public int StockId { get; set; }
        public int? StoreId { get; set; }
        public string Lot { get; set; }
        [Required]
        public string DebitInvoiceNumber { get; set; }
        public decimal? SubTotalAmount { get; set; }
        public decimal? TaxAmount { get; set; }
        [Required]
        public decimal TotalAmount { get; set; }
        public DateTime? PaymentReceiveDueDate { get; set; }
        public DateTime? PaymentDueDate { get; set; }
        public decimal? BalanceAmount { get; set; }
        public string Note { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public short? LockStatus { get; set; }
        public bool? Deleted { get; set; }
    }
}
