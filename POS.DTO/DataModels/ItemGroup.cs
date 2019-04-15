using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace POS.DTO
{
    [Table("Item_Group")]
    public partial class ItemGroup
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int Id { get; set; }                    
        public string Code { get; set; }
        [Display(Name ="Name")]
        public string Description { get; set; }        
        [Display(Name ="Item Category Code")]
        public string Item_Category_Code { get; set; }        
    }
}
