using System;
using System.ComponentModel.DataAnnotations;

namespace POS.DTO
{
    public partial class InvoiceMaterializedView
    {
        [Key]
        public int Id { get; set; }
        public string BillNo { get; set; }
        public string DocumentType { get; set; }
        public string FiscalYear { get; set; }
        public string LocationCode { get; set; }
        public DateTime BillDate { get; set; }
        public TimeSpan PostingTime { get; set; }
        public string CustomerCode { get; set; }
        public string CustomerName { get; set; }
        public string Vatno { get; set; }
        public decimal Amount { get; set; }
        public decimal Discount { get; set; }
        public decimal TaxableAmount { get; set; }
        public decimal NonTaxableAmount { get; set; }
        public decimal TaxAmount { get; set; }
        public decimal TotalAmount { get; set; }
        public bool IsBillActive { get; set; }
        public bool IsBillPrinted { get; set; }
        public DateTime? PrintedTime { get; set; }
        public string PrintedBy { get; set; }
        public string EnteredBy { get; set; }
        public string SyncStatus { get; set; }
        public DateTime SyncedDate { get; set; }
        public TimeSpan SyncedTime { get; set; }
        public bool SyncWithIrd { get; set; }
        public bool IsRealTime { get; set; }
    }
}
