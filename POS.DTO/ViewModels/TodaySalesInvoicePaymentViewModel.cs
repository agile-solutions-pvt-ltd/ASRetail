using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("TodaySalesInvoicePaymentView")]

    public class TodaySalesInvoicePaymentViewModel
    {
        [Key]
        public string Trans_Mode { get; set; }

        public DateTime Trans_Date_AD { get; set; }

        public decimal TotalAmount { get; set; }
    }
}
