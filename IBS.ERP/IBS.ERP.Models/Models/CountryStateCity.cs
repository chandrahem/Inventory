using System;
using System.Text;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace IBS.ERP.Models
{
   public class CountryStateCity
    {
       public int CountryID { get; set; }

       public string CountryName { get; set; }

       public int StateID { get; set; }

       public string StateName { get; set; }

       public int CityID { get; set; }

       public string CityName { get; set; }
    }
}
