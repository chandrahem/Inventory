using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class Menus {
        public Menus() { }
        public int ModuleId { get; set; }
        public string ModuleName { get; set; }
        public int? ParentId { get; set; }
        public string Description { get; set; }
        public string ActionName { get; set; }
        public string ControllerName { get; set; }
        public int? Isenabled { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
    }
}
