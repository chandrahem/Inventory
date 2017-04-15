using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class CompanyDB {
        public virtual int DBId { get; set; }
        [Required]
        public virtual string CompanyCode { get; set; }
        public virtual string DBConnectionString { get; set; }
        public virtual string DBProviderName { get; set; }
        [Required]
        public virtual int LockStatus { get; set; }
        public virtual string CreatedBy { get; set; }
        public virtual DateTime? CreatedDate { get; set; }
        public virtual string ModifiedBy { get; set; }
        public virtual DateTime? ModifiedDate { get; set; }
        [Required]
        public virtual bool Deleted { get; set; }
    }
}
