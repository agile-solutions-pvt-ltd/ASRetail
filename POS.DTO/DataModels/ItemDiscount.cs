using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace POS.DTO
{
    [Table("ITEM_DISCOUNT")]
    public partial class ItemDiscount
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int Id { get; set; }
        public decimal DiscountPercent { get; set; }
        public string ItemType { get; set; }
        public string ItemCode { get; set; }  
        public DateTime? StartDate { get; set; }       
        public DateTime? EndDate { get; set; }
        public TimeSpan? StartTime { get; set; }
        public TimeSpan? EndTime { get; set; }
        public decimal MinimumQuantity { get; set; }
        public string VendorNumber { get; set; }
        public string SalesType { get; set; }
        public string SalesCode { get; set; }
    }
}
