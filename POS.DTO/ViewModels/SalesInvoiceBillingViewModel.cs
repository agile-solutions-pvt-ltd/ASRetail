using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace POS.DTO
{
    public class SalesInvoiceBillingViewModel
    {
        [Key]
        public Guid salesInvoiceId { get; set; }
        public decimal billDiscount { get; set; }
        public decimal totalNetAmountRoundUp { get; set; }
        public decimal totalPayable { get; set; }
        public decimal tenderAmount { get; set; }
        public decimal changeAmount { get; set; }


        public List<SalesInvoiceBill> bill { get; set; }

    }
}
