using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("ITEM_DISCOUNT")]
    public partial class ItemDiscount
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]

        public string Id { get; set; }
        public decimal DiscountPercent { get; set; }
        public string ItemType { get; set; }
        public string ItemCode { get; set; }
        public string Location { get; set; }
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
