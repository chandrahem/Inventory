using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class Salesdetail {
        public int Salesdetailid { get; set; }
        public int? Saleid { get; set; }
        [Required]
        public string Productcode { get; set; }
        [Required]
        public string Barcode { get; set; }
        [Required]
        public decimal SellingPrice { get; set; }
        [Required]
        public int Quantity { get; set; }
        [Required]
        public decimal Amount { get; set; }
        public string Createdby { get; set; }
        public DateTime? Createddate { get; set; }
        public string Modifiedby { get; set; }
        public DateTime? Modifieddate { get; set; }
        public short? Lockstatus { get; set; }
        public bool? Deleted { get; set; }
    }
}
