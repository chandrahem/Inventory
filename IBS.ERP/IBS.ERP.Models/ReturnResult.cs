using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IBS.ERP.Models
{
   public class ReturnResult
    {
        public ReturnResult(){ }

        public int ID { get; set; }
        public bool IsSuccess { get; set; }
        public string Message { get; set; }
        public string Value { get; set; }
    }
}
