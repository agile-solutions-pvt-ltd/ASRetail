using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace POS.DTO
{
    [Table("ITEM_PRICE")]
    public partial class ItemPrice
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public string Id { get; set; }
        public decimal UnitPrice { get; set; }                    
        public string ItemCode { get; set; }  
        public DateTime? StartDate { get; set; }       
        public DateTime? EndDate { get; set; }
        public decimal MinimumQuantity { get; set; }
        public bool AllowLineDiscount { get; set; }
        public string SalesType { get; set; }
        public string SalesCode { get; set; }

    }
}
