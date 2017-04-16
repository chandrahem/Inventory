using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class CompanyMaster {
        public CompanyMaster() { }
        public int CompanyId { get; set; }
        public string CompanyCode { get; set; }
        [Required]
        public string CompanyName { get; set; }
        public string RegistrationNo { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Tin { get; set; }
        public string Phone1 { get; set; }
        public string Phone2 { get; set; }
        public string Website { get; set; }
        public string ContactEmail { get; set; }
        public string OwnedBy { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
    }
}
