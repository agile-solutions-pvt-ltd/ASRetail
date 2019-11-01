using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [NotMapped]
    public partial class Store
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public string ID { get; set; }
        [Required]
        [Display(Name = "Initial")]
        public string INITIAL { get; set; }
        [Display(Name = "Store Name")]
        public string NAME { get; set; }
        [Display(Name = "Company Name")]
        public string COMPANY_NAME { get; set; }
        [Display(Name = "Address")]
        public string ADDRESS { get; set; }
        [Display(Name = "Phone No.")]
        public string PHONE { get; set; }
        [Display(Name = "Alt. Phone No.")]
        public string PHONE_ALT { get; set; }
        [Display(Name = "Fax")]
        public string FAX { get; set; }
        [Display(Name = "Vat")]
        public string VAT { get; set; }
        [Display(Name = "Email")]
        public string EMAIL { get; set; }
        [Display(Name = "Website")]
        public string WEBSITE { get; set; }
        [Display(Name = "Fiscal Year")]
        public string FISCAL_YEAR { get; set; }
        [Display(Name = "Customer Price Group")]
        public string CustomerPriceGroup { get; set; }
        [Display(Name = "Print Message")]
        public string PrintMessage { get; set; }
    }
}
