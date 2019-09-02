using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("SALES_INVOICE_BILL")]
    public partial class SalesInvoiceBill
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

        public bool IsNavSync { get; set; }
        public int SyncErrorCount { get; set; } = 0;
        public DateTime? NavSyncDate { get; set; }
    }
}
