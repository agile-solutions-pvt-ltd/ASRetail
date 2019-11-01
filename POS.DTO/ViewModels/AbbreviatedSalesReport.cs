using System.ComponentModel.DataAnnotations;

namespace POS.DTO
{
    public class AbbreviatedSalesReport
    {
        [Key]
        public string Trans_Date_AD { get; set; }
        public string Trans_Date_BS { get; set; }
        public string Invoice_Number { get; set; }
        public string FROM_Invoice_Number { get; set; }
        public string To_Invoice_Number { get; set; }
        public decimal Total_Payable_Amount { get; set; }
        public decimal Total_Vat { get; set; }
        public decimal Total_Gross_Amount { get; set; }
        public decimal Total_Net_Amount { get; set; }
        public decimal Total_Quantity { get; set; }
        public decimal Total_Discount { get; set; }
        public decimal TaxableAmount { get; set; }
        public decimal NonTaxableAmount { get; set; }
    }
}
