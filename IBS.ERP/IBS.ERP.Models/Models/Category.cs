using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace IBS.ERP.Models {
    
    public class Category {
        public Category() { }
        public virtual int categoryid { get; set; }
        [Required(ErrorMessage="Enter Category Code")]
        [StringLength(25)]
        [Display(Name="Category Code")]
        //[Unique(ErrorMessage = "This already exist !!")]
        public virtual string CategoryCode { get; set; }
        [Required(ErrorMessage = "Enter Category Name")]
        [StringLength(50)]
        [Display(Name = "Category Name")]
        public virtual string CategoryName { get; set; }
        [StringLength(100)]
        public virtual string Description { get; set; }
        public virtual byte[] Picture { get; set; }
    }
}
