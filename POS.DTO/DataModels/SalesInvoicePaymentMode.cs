using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("SALES_INVOICE_PAYMENTMODE")]
    public partial class SalesInvoicePaymentMode
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public Guid Invoice_Id { get; set; }
        public string Invoice_Type { get; set; }
        public string Invoice_Number { get; set; }
        public string Division { get; set; }
        public string Terminal { get; set; }
        public string Trans_Mode { get; set; }
        public string Account { get; set; }
        public decimal Amount { get; set; }
        public string Remarks { get; set; }
    }
}
