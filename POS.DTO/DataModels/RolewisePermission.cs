using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("ROLEWISE_PERMISSION")]
    public partial class RoleWisePermission 
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [Display(Name ="Role")]
        public string RoleId { get; set; }
        [Display(Name = "Sales Discount Flat")]
        public bool Sales_Discount_Flat_Item { get; set; }
        [Display(Name = "Discount Limit")]
        public decimal? Sales_Discount_Flat_Item_Limit { get; set; }
        [Display(Name = "Sales Discount Itemwise")]
        public bool Sales_Discount_Line_Item { get; set; }
        [Display(Name = "Discount Limit")]
        public decimal? Sales_Discount_Line_Item_Limit { get; set; }
        [Display(Name = "Sales Rate Edit Right")]
        public bool Sales_Rate_Edit { get; set; }
        
    }
}
