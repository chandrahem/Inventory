using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IBS.ERP.DataAccess
{
    public class IBSparameter
    {
        public string ParameterName { get; set; }
        public DbType DataType { get; set; }
        public ParameterDirection Direction { get; set; }
        public object Value { get; set; }
    }
}
