using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("ROLEWISE_MENU_PERMISSION")]
    public partial class RoleWiseMenuPermission
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [Display(Name = "Role")]
        public string RoleId { get; set; }
        [Display(Name = "Menu")]
        public int MenuId { get; set; } = 0;

        [ForeignKey("MenuId")]
        public Menu Menu { get; set; }
    }
}
