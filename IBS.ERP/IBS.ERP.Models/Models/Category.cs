using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;

namespace IBS.ERP.Models {
    [DataContract]
    public class Category {
        public Category() { }
         [DataMember]
        public virtual int categoryid { get; set; }
         [DataMember]
        [Required(ErrorMessage="Enter Category Code")]
        [StringLength(25)]
        [Display(Name="Category Code")]
        //[Unique(ErrorMessage = "This already exist !!")]
        public virtual string CategoryCode { get; set; }
         [DataMember]
        [Required(ErrorMessage = "Enter Category Name")]
        [StringLength(50)]
        [Display(Name = "Category Name")]
        public virtual string CategoryName { get; set; }
         [DataMember]
        [StringLength(100)]
        public virtual string Description { get; set; }
         [DataMember]
        public virtual byte[] Picture { get; set; }
    }
    [DataContract]
    public class BaseResponse
    {
        [DataMember]
        public bool HasError { get; set; }

        [DataMember]
        public dynamic ReturnValue { get; set; }
    }
}
