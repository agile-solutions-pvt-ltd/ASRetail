using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace POS.DTO
{
    [Table("SalesInvoiceSelView")]
    public class SalesInvoiceViewModel
    {
        public int Invoice_Id { get; set; }
        [Key]
        public string Invoice_Number { get; set; }
        public DateTime Trans_Date_Ad { get; set; }
        public string Trans_Date_Bs { get; set; }
        public string Trans_Time { get; set; }
        public string Trans_Type { get; set; }
        public string Chalan_Number { get; set; }
        public string Division { get; set; }
        public string Terminal { get; set; }
        public string Customer_Id { get; set; }
        public string Customer_Name { get; set; }
        public string Customer_Vat { get; set; }
        public string Customer_Mobile { get; set; }
        public string Customer_Address { get; set; }
        public decimal Flat_Discount_Amount { get; set; }
        public decimal Flat_Discount_Percent { get; set; }
        public decimal Total_Quantity { get; set; }
        public decimal Total_Gross_Amount { get; set; }
        public decimal Total_Discount { get; set; }
        public decimal Total_Vat { get; set; }
        public decimal Total_Net_Amount { get; set; }
        public string Created_By { get; set; }
        public DateTime Created_Date { get; set; }
        public string Remarks { get; set; }
        public decimal TaxableAmount { get; set; }
        public decimal NonTaxableAmount { get; set; }
        public string MemberId { get; set; }
        public decimal Total_Bill_Discount { get; set; }
        public decimal Total_Net_Amount_Roundup { get; set; }
        public decimal Total_Payable_Amount { get; set; }
        public decimal Tender_Amount { get; set; }
        public decimal Change_Amount { get; set; }
        public decimal MembershipDiscount { get; set; }
        public decimal PromoDiscount { get; set; }
        public decimal TOTAL_DISCOUNT_EXC_VAT { get; set; }

        public decimal Card { get; set; }
        public decimal Credit_Note { get; set; }
        public decimal Credit { get; set; }
        public decimal Cash { get; set; }

        public ICollection<SalesInvoiceItems> SalesInvoiceItems { get; set; }
    }
}
