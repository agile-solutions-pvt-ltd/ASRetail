using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("SALES_INVOICE")]
    [JsonObject(IsReference = true)]
    public partial class SalesInvoice
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }
        public int Invoice_Id { get; set; }
        [Display(Name = "Invoice Number")]
        public string Invoice_Number { get; set; }
        [Display(Name = "Date")]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:MM/dd/yyyy}")]
        public DateTime? Trans_Date_Ad { get; set; }
        [Display(Name = "BS")]
        public string Trans_Date_Bs { get; set; }
        public TimeSpan? Trans_Time { get; set; }
        public string Trans_Type { get; set; }
        [Display(Name = "Shipment No.")]
        public string Chalan_Number { get; set; }
        public string Division { get; set; }
        public string Terminal { get; set; }
        //[NotMapped]
        //public string TerminalName { get; set; }
        [Display(Name = "Bill To")]
        public string Customer_Id { get; set; }
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
        public decimal? Flat_Discount_Amount { get; set; } = 0;
        [Display(Name = "Percentage")]
        public decimal? Flat_Discount_Percent { get; set; } = 0;
        [Display(Name = "Total Quantity")]
        public decimal? Total_Quantity { get; set; } = 0;
        [Display(Name = "Total Gross Amount")]
        public decimal? Total_Gross_Amount { get; set; } = 0;
        [Display(Name = "Total Discount")]
        public decimal? Total_Discount { get; set; } = 0;
        public decimal TOTAL_DISCOUNT_EXC_VAT { get; set; }
        public decimal MembershipDiscount { get; set; } = 0;
        public decimal PromoDiscount { get; set; } = 0;
        public decimal Total_Bill_Discount { get; set; } = 0;
        [Display(Name = "Total Vat")]
        public decimal? Total_Vat { get; set; } = 0;
        [Display(Name = "Total Net Amount")]
        public decimal TaxableAmount { get; set; }
        public decimal NonTaxableAmount { get; set; }
        public decimal? Total_Net_Amount { get; set; } = 0;
        public decimal Total_Net_Amount_Roundup { get; set; } = 0;
        public decimal Total_Payable_Amount { get; set; } = 0;
        [Display(Name = "Created By")]
        public string Created_By { get; set; }
        [Display(Name = "Created Date")]
        public DateTime? Created_Date { get; set; }
        public string Remarks { get; set; }
        public decimal Tender_Amount { get; set; } = 0;
        public decimal Change_Amount { get; set; } = 0;

        public bool IsNavSync { get; set; }
        public int SyncErrorCount { get; set; } = 0;
        public DateTime? NavSyncDate { get; set; }
        public bool IsNavPosted { get; set; }

        public ICollection<SalesInvoiceItems> SalesInvoiceItems { get; set; }
    }
}
