﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace POS.DTO
{
    [Table("SettlementView")]
    public  class SettlementViewModel
    {
        [Key]
        public Int64 Id { get; set; }
        public string SessionId { get; set; }
        public int TerminalId { get; set; }
        public int DenominationId { get; set; }
        public decimal DenominationAmount { get; set; }
        public string TerminalName { get; set; }
        public string UserId { get; set; }
        public string UserName { get; set; }
        
        public DateTime StartTransaction { get; set; }
        public DateTime EndTransaction { get; set; }
        public string PaymentMode { get; set; }
        public decimal TotalAmount { get; set; } = 0;
        public string Status { get; set; }
        public string Remarks { get; set; }
        public decimal SettlementCash { get; set; }

    }
}
