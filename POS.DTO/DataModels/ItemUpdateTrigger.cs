using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("ITEM_UPDATE_TRIGGER")]
    public partial class ItemUpdateTrigger
    {
        [Key]
        //[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        public string ITEMCODE { get; set; }
        public DateTime? DATE { get; set; }
        public string ACTIONS { get; set; }

    }
}
