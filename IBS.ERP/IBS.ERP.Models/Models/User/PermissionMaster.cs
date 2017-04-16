using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class PermissionMaster {
        public virtual int PermissionId { get; set; }
        public virtual Menus Menus { get; set; }
        [Required]
        public virtual string PermissionName { get; set; }
        public virtual string Description { get; set; }
    }
}
