using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("INVOICE_PRINT")]
    public partial class InvoicePrint
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string Type { get; set; }
        public string InvoiceNumber { get; set; }
        public DateTime FirstPrintedDate { get; set; }
        public string FirstPrintedBy { get; set; }
        public int PrintCount { get; set; }
        public DateTime? PrintedDate { get; set; }
        public string PrintedBy { get; set; }
    }
}
