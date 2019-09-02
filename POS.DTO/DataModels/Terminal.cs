using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    public partial class Terminal
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string Initial { get; set; }
        public string Name { get; set; }
        [Display(Name = "IsActive")]
        public bool? Is_Active { get; set; }
        public string Remarks { get; set; }
        [Display(Name = "Cash Drop Limit")]
        public decimal? Cash_Drop_Limit { get; set; }
        public decimal Cash_Opening_Balance { get; set; }
    }
}
