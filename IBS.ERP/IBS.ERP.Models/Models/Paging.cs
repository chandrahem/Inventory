using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;

namespace IBS.ERP.Models
{
    public class Paging
    {
       
      
      
        public Int32 StartRowIndex { get; set; }
        /// <summary>
        /// Maximum rows per page
        /// </summary>
       
        public Int32 MaxRows { get; set; }
        /// <summary>
        /// Ordery by column name
        /// </summary>
       
        public String OrderBy { get; set; }
        /// <summary>
        /// Ascending:ASC or Descending:DESC order type
        /// </summary>
        
        public String Order { get; set; }

    }


}
