using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("Item_Category")]
    public partial class ItemCategory
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public string Id { get; set; }
        public string Code { get; set; }
        public string ParentCode { get; set; }
        public string Name { get; set; }
        [Display(Name = "Modified Date")]
        public int Indentation { get; set; }
        public int Order { get; set; }
        public bool HasChild { get; set; }
        public DateTime ModifiedDate { get; set; } = DateTime.Now;

    }
}
