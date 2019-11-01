using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{


    [Table("Item_Group")]
    public partial class ItemGroup
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int Id { get; set; }
        public string Code { get; set; }
        [Display(Name = "Name")]
        public string Description { get; set; }
        [Display(Name = "Item Category Code")]
        public string ItemCategoryCode { get; set; }
        public DateTime LastSyncDate { get; set; } = DateTime.Now;

        //private DateTime _date = DateTime.Now;
        //public ItemGroup()
        //{
        //    LastSyncDate = _date;
        //}
    }
}
