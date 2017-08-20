using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IBS.ERP.Models
{
    public class Lookup
    {
        public int LookupId { get; set; }
        public string Code { get; set; }
        public string Text { get; set; }
        public string LookupType { get; set; }
    }
}
