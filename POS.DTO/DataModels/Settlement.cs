using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    public partial class Settlement
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string SessionId { get; set; }
        public int? TerminalId { get; set; }
        public string UserId { get; set; }
        public int DenominationId { get; set; }

        public string TransactionNumber { get; set; }
        public DateTime TransactionDate { get; set; }
        public string PaymentMode { get; set; }
        public decimal Amount { get; set; } = 0;
        public string Status { get; set; }
        public string VerifiedBy { get; set; }
        public DateTime VerifiedDate { get; set; }
        public decimal AdjustmentAmount { get; set; }
        public decimal ShortExcessAmount { get; set; }
        public string Remarks { get; set; }

        [ForeignKey("UserId")]
        public User User { get; set; }
        [ForeignKey("TerminalId")]
        public Terminal Terminal { get; set; }
    }
}
