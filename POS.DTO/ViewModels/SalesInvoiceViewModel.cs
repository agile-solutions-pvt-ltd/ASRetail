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
        public string Terminal { get; set; }
        public string Created_By { get; set; }
        public DateTime Trans_Date_AD { get; set; }
        public string Trans_Time { get; set; }
        public string Trans_Type { get; set; }
        public string Trans_Date_BS { get; set; }
        public decimal Total_Gross_Amount { get; set; }
        public decimal Total_Payable_Amount { get; set; }
        public decimal Total_Vat { get; set; }
        public decimal Total_Net_Amount { get; set; }
        public decimal Total_Discount { get; set; }
        public decimal Card { get; set; }
        public decimal Credit_Note { get; set; }
        public decimal Credit { get; set; }
        public decimal Cash { get; set; }

        public ICollection<SalesInvoiceItems> SalesInvoiceItems { get; set; }
    }
}