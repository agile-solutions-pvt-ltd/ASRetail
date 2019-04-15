using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace POS.DTO
{
    public partial class Item
    {     
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string Code { get; set; }
        public string Bar_Code { get; set; }
        public string Name { get; set; }
        public string Parent_Code { get; set; }
        public string Type { get; set; }
        public string Unit { get; set; }
        public decimal? Rate { get; set; } = 0;
        public decimal Discount { get; set; }
        public bool Is_Discountable { get; set; }
        public bool? Is_Vatable { get; set; } = false;
        public string Remarks { get; set; }
    }
}
