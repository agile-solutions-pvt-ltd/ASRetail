using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace POS.DTO
{
    public partial class Setting
    {     
        
        public int Id { get; set; }
        public string CompanyId { get; set; }
        public string Environment { get; set; }
       
    }
}
