using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

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
