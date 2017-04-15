using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using log4net.Appender;
using System.Configuration;

namespace IBS.ERP.Models
{
    public class CustomAdoNetAppender : AdoNetAppender
    {
        public string ConnectionStringName
        {
            set
            {
                ConnectionString = ConfigurationManager.ConnectionStrings[value].ToString();
            }
        }
    }
}
