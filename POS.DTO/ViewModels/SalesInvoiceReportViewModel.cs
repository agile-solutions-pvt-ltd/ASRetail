using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("SalesInvoiceReportView")]
    public class SalesInvoiceReportViewModel
    {
        [Key]
        public string Invoice_Number { get; set; }
        public DateTime Trans_Date_AD { get; set; }
        public string Trans_Date_BS { get; set; }
        public decimal Total_Gross_Amount { get; set; }
        public decimal Total_Discount { get; set; }
        public decimal Total_Vat { get; set; }
        public decimal Total_Net_Amount { get; set; }
        public string Trans_Mode { get; set; }
        public string Trans_Type { get; set; }
        public string Created_By { get; set; }
        public string Terminal { get; set; }
    }
}
