using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace POS.DTO
{
   
   public class SettlementSummaryView
    {

        public Int64 Id { get; set; }
        public string Created_By { get; set; }
        public string Terminal { get; set; }
        public DateTime Date { get; set; }
        public string Trans_Mode { get; set; }
        public decimal Amount { get; set; }
      

    }
}
