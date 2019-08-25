using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace POS.DTO
{ 
   public class SalesVatBookReport
    {
        public DateTime Trans_Date_AD { get; set; }

        [Key]
        public string Invoice_Number { get; set; }
        public string Customer_Name { get; set; }
        public string Customer_Vat { get; set; }
        public decimal TaxableAmount { get; set; }
        public decimal NonTaxableAmount { get; set; }
        public decimal TotalSale { get; set; }
        public decimal Total_Vat { get; set; }
        public decimal Total_Net_Amount { get; set; }
    }
}
