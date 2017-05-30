using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IBS.ERP.Models
{
   public class LoginViewModel
    {
       [Required]
       [Display(Name="User Account")]
        public virtual string UserAccount { get; set; }
        [Required]
        [Display(Name = "Password")]
        public virtual string Password { get; set; }
        public virtual string CompanyCode { get; set; }
        public virtual string DBConnectionString { get; set; }
        public virtual string DBProviderName { get; set; }
        public virtual int RoleId { get; set; }
        public virtual string SignInStatus { get; set; }
        //public virtual string ApplicationName { get; set; }
       
    }
}
