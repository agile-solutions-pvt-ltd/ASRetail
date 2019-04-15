using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace POS.DTO
{
    [Table("Item_Category")]
    public partial class ItemCategory
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public Guid Id { get; set; }                    
        public string Code { get; set; }
        [Display(Name ="Parent Code")]
        public string Parent_Code { get; set; }        
        public string Description { get; set; }
        public int Indentation { get; set; }
        public int Order { get; set; }
        public bool Has_Child { get; set; }
        [Display(Name = "Modified Date")]
        public DateTime Modified_Date { get; set; }
       
    }
}
