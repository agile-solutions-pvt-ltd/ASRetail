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
        [Display(Name = "Role")]
        public string RoleId { get; set; }
        [Display(Name = "Sales Discount Flat")]
        public bool Sales_Discount_Flat_Item { get; set; } = false;
        [Display(Name = "Discount Limit")]
        public decimal Sales_Discount_Flat_Item_Limit { get; set; } = 0;
        [Display(Name = "Sales Discount Itemwise")]
        public bool Sales_Discount_Line_Item { get; set; } = false;
        [Display(Name = "Discount Limit")]
        public decimal Sales_Discount_Line_Item_Limit { get; set; } = 0;
        [Display(Name = "Sales Rate Edit Right")]
        public bool Sales_Rate_Edit { get; set; } = false;
        [Display(Name = "Credit Bill Pay Right")]
        public bool Credit_Bill_Pay { get; set; } = false;
        [Display(Name = "Credit Note Bill Pay Right")]
        public bool Credit_Note_Bill_Pay { get; set; } = false;
        [Display(Name = "Require Terminal To Login")]
        public bool Require_Terminal_To_Login { get; set; }
        [Display(Name = "Sales Rate Commission Right")]
        public bool Sales_Rate_Commission_Right { get; set; } = false;
    }
}
