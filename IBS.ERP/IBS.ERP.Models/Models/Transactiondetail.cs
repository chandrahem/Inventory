using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class Transactiondetail {
        public int Id { get; set; }
        public string InvoiceNo { get; set; }
        public string InvoiceType { get; set; }
        public decimal? TransactionAmount { get; set; }
        public string ModeofPayment { get; set; }
        public DateTime? TransactionDate { get; set; }
        public string TransactionId { get; set; }
        public string BankName { get; set; }
        public string ChequeNo { get; set; }
        public DateTime? ChequeDate { get; set; }
        public decimal? ChequeAmount { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public short? LockStatus { get; set; }
    }
}
