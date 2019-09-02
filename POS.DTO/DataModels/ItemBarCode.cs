using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("ITEM_BARCODE")]
    public partial class ItemBarCode
    {
        //[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public string BarCode { get; set; }
        public string ItemCode { get; set; }
        public string Unit { get; set; }
        public bool IsActive { get; set; }
    }
}
