using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class CustomerMaster {
        public int CustomerId { get; set; }
        [Required]
        public string CustomerCode { get; set; }
        public string CustomerBarCode { get; set; }
        public string CustomerName { get; set; }
        public string ContactName { get; set; }
        public string ContactTitle { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Region { get; set; }
        public string PostalCode { get; set; }
        public string Country { get; set; }
        public string Phone { get; set; }
        public string Fax { get; set; }
        public string ContactEmail { get; set; }
        public bool? AutoApproveSO { get; set; }
        public decimal? AutoApproveSOAmount { get; set; }
        public bool? AutoSendSO { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifieBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public short? LockStatus { get; set; }
        public bool? Deleted { get; set; }
        public string WebSite { get; set; }
        public string State { get; set; }
    }
}
