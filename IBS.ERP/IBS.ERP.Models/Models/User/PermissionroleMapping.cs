using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class PermissionRoleMapping {
        public virtual int MappingId { get; set; }
        [Required]
        public virtual int RoleId { get; set; }
        [Required]
        public virtual int PermissionId { get; set; }
        public virtual string Description { get; set; }
    }
}
