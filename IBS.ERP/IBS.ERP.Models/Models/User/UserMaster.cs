using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class UserMaster {
        public virtual int UserId { get; set; }
        [Required]
        public virtual string UserAccount { get; set; }
        [Required]
        public virtual string Password { get; set; }
        //[Required]
        public virtual string FirstName { get; set; }
        public virtual string LastName { get; set; }
        public virtual string CompanyCode { get; set; }
        public virtual string PrimaryEmail { get; set; }
        public virtual string AlternateEmail { get; set; }
        public virtual string PrimaryPhoneNo { get; set; }
        public virtual string AlternatePhoneNo { get; set; }
        public virtual bool? IsAccountActive { get; set; }
        public virtual bool? IsAccountLocked { get; set; }
        public virtual int? RoleId { get; set; }
        public virtual string HintQuestion { get; set; }
        public virtual string HintAnswer { get; set; }
       // [Required]
        public virtual int LockStatus { get; set; }
        public virtual string CreatedBy { get; set; }
        public virtual DateTime? CreatedDate { get; set; }
        public virtual string ModifiedBy { get; set; }
        public virtual DateTime? ModifiedDate { get; set; }
        //[Required]
        public virtual bool Deleted { get; set; }
    }
}
