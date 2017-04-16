using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class Sales {
        public Sales() { }
        public int Saleid { get; set; }
        [Required]
        public string Billnumber { get; set; }
        [Required]
        public DateTime Dateofsale { get; set; }
        public string Customercode { get; set; }
        public string Customerbarcode { get; set; }
        public decimal? Subtotal { get; set; }
        public decimal? Taxamount { get; set; }
        [Required]
        public decimal Totalamount { get; set; }
        public decimal? Balanceamount { get; set; }
        public DateTime? Paymentdueon { get; set; }
        public string Comment { get; set; }
        public string Createdby { get; set; }
        public DateTime? Createddate { get; set; }
        public string Modifiedby { get; set; }
        public DateTime? Modifieddate { get; set; }
        public short? Lockstatus { get; set; }
        public bool? Deleted { get; set; }
    }
}
