using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IBS.ERP.Models
{
    public class Search
    {
        public Search() { }
        public string SearchField1 { get; set; }
        public string SearchField1Value { get; set; }
        public string SearchField2 { get; set; }
        public string SearchField2Value { get; set; }
        public string Condition { get; set; }
        public string SearchOn { get; set; } // means customer, Supplier etc

    }
}
