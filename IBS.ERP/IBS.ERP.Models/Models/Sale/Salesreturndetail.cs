using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class Salesreturndetail {
        public int Salesreturndetailid { get; set; }
        public int? Salesreturnid { get; set; }
        [Required]
        public string Productcode { get; set; }
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
