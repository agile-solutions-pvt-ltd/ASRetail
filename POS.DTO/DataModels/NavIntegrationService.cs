using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace POS.DTO
{
    [Table("NAV_INTEGRATION_SERVICE")]
    public partial class NavIntegrationService
    {     
        [Key]      
        public int Id { get; set; }        
        public string IntegrationType { get; set; }
        public string ServiceName { get; set; }
        public int LastUpdateNumber { get; set; }
        public DateTime LastSyncDate { get; set; }
       
    }
}
