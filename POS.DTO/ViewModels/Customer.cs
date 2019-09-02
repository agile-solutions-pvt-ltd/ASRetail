using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    public partial class CustomerViewModel
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public string Code { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Mobile1 { get; set; }
        public string Vat { get; set; }
        public string Type { get; set; }
        public bool? Is_Sale_Refused { get; set; }
        public bool? Is_Member { get; set; }
        public int? Member_Id { get; set; }
        [Key]
        public string Membership_Number { get; set; }
        public string Membership_Number_Old { get; set; }
        public string Barcode { get; set; }
        public string CustomerPriceGroup { get; set; }
        public string CustomerDiscGroup { get; set; }
        public string MembershipDiscGroup { get; set; }
    }
}
