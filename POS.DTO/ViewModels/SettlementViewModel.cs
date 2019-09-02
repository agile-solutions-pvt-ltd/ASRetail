using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace POS.DTO
{
    [Table("SettlementView")]
    public class SettlementViewModel
    {
        [Key]
        public Int64 Id { get; set; }
        public string SessionId { get; set; }
        public int TerminalId { get; set; }
        public int DenominationId { get; set; }

        public string TerminalName { get; set; }
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string VerifiedBy { get; set; }
        public DateTime VerifiedDate { get; set; }

        public DateTime StartTransaction { get; set; }
        public DateTime EndTransaction { get; set; }
        public string PaymentMode { get; set; }
        public decimal TotalAmount { get; set; } = 0;
        public string Status { get; set; }
        public string Remarks { get; set; }
        public decimal AdjustmentAmount { get; set; }
        public decimal ShortExcessAmount { get; set; }

        public decimal Card { get; set; }
        public decimal Credit { get; set; }
        public decimal CreditNote { get; set; }
        public decimal DenominationCash { get; set; }



    }
}
