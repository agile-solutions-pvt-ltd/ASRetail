using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("SALES_INVOICE_TMP")]
    public partial class SalesInvoiceTmp
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }
        public int Invoice_Id { get; set; }
        [Display(Name = "Invoice Number")]
        public string Invoice_Number { get; set; }
        [Display(Name = "Date")]
        public DateTime? Trans_Date_Ad { get; set; }
        [Display(Name = "BS")]
        public string Trans_Date_Bs { get; set; }
        public TimeSpan? Trans_Time { get; set; }
        public string Trans_Type { get; set; }
        [Display(Name = "Shipment No.")]
        public string Chalan_Number { get; set; }
        public string Division { get; set; }
        public string Terminal { get; set; }
        [Display(Name = "Bill To")]
        public string Customer_Id { get; set; }
        [Display(Name = "Member")]
        public string MemberId { get; set; }
        [Display(Name = "Name")]
        public string Customer_Name { get; set; }
        [Display(Name = "Vat")]
        public string Customer_Vat { get; set; }
        [Display(Name = "Mobile")]
        public string Customer_Mobile { get; set; }
        [Display(Name = "Address")]
        public string Customer_Address { get; set; }
        [Display(Name = "Amount")]
        public decimal? Flat_Discount_Amount { get; set; }
        [Display(Name = "Percentage")]
        public decimal? Flat_Discount_Percent { get; set; }



        public decimal? Total_Quantity { get; set; }
        public decimal? Total_Gross_Amount { get; set; }
        public decimal? Total_Discount { get; set; }
        public decimal TOTAL_DISCOUNT_EXC_VAT { get; set; } = 0;
        public decimal MembershipDiscount { get; set; } = 0;
        public decimal PromoDiscount { get; set; } = 0;
        public decimal? Total_Vat { get; set; }
        public decimal TaxableAmount { get; set; }
        public decimal NonTaxableAmount { get; set; }
        public decimal? Total_Net_Amount { get; set; }
        public string Created_By { get; set; }
        public DateTime? Created_Date { get; set; }
        public string Remarks { get; set; }

        // [ForeignKey("Id")]
        public ICollection<SalesInvoiceItemsTmp> SalesInvoiceItems { get; set; }
    }
}
