using System;
using System.ComponentModel.DataAnnotations;

namespace POS.DTO
{
    public class SpSalesInvoiceAggregateGet
    {
        [Key]

        public int SN { get; set; }
        public DateTime Trans_Date_AD { get; set; }


        public string Created_By { get; set; }

        public decimal Card { get; set; }

        public decimal Cash { get; set; }

        public decimal Credit_Note { get; set; }

        public decimal Credit { get; set; }

        public decimal Total { get; set; }
    }
}
