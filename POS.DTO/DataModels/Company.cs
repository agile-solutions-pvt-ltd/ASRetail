using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace POS.DTO
{
    public partial class Company
    {     
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public string id { get; set; }
        public string name { get; set; }
        public string displayName { get; set; }
        public DateTime lastSyncDate { get; set; }

       
        public Company()
        {
            lastSyncDate = DateTime.Now;
        }
        
    }
}
