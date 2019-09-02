namespace POS.DTO
{

    public class SettlementPostViewModel
    {
        public Settlement Settlement { get; set; }
        public decimal AdjustmentCardAmount { get; set; } = 0;
        public decimal AdjustmentCreditAmount { get; set; } = 0;
        public decimal AdjustmentCreditNoteAmount { get; set; } = 0;
        public decimal AdjustmentCashAmount { get; set; } = 0;

        public decimal ShortExcessCardAmount { get; set; } = 0;
        public decimal ShortExcessCreditAmount { get; set; } = 0;
        public decimal ShortExcessCreditNoteAmount { get; set; } = 0;
        public decimal ShortExcessCashAmount { get; set; } = 0;
    }
}
