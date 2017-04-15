using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class Productsforsale {
        public int Productavid { get; set; }
        [Required]
        public string Productcode { get; set; }
        public string Barcode { get; set; }
        [Required]
        public int Storeid { get; set; }
        public int? Unitsinstock { get; set; }
        public decimal? SellingPrice { get; set; }
        public int? Unitsonso { get; set; }
        public string Createdby { get; set; }
        public DateTime? Createddate { get; set; }
        public string Modifiedby { get; set; }
        public DateTime? Modifieddate { get; set; }
        public short? Lockstatus { get; set; }
        [Required]
        public bool Deleted { get; set; }
    }
}
