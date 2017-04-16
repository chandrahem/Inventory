using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class Suppliers {
        public Suppliers() { }
        public int SupplierId { get; set; }
        [Required]
        [Display(Name = "Supplier Code")]
        public string SupplierCode { get; set; }
        [Required]
        [Display(Name="Supplier Name")]
        public string SupplierName { get; set; }
        [Required]
        [Display(Name = "Contact Name")]
        public string ContactName { get; set; }

        [Display(Name = "Contact Title")]
        public string ContactTitle { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Region { get; set; }
        [Display(Name = "Postal Code")]
        public string PostalCode { get; set; }
        public string Country { get; set; }
        [Required]
        [Display(Name = "Primary Phone")]
        public string Phone1 { get; set; }
        [Display(Name = "Secondary Phone")]
        public string Phone2 { get; set; }
        public string Fax { get; set; }
        public string Website { get; set; }
         [Display(Name = "Contact Email")]
        public string ContactEmail { get; set; }
        public bool? Autoapprovepo { get; set; }
        public decimal? AutoApprovePOAmount { get; set; }
        public bool? AutoSendPO { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public short? LockStatus { get; set; }
    }
}
