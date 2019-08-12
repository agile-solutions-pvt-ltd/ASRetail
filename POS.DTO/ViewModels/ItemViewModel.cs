using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace POS.DTO
{
   public class ItemViewModel
    {
       [Key]
        public long SN { get; set; }
        public string Code { get; set; }
        public string ItemId { get; set; }
        public string Bar_Code { get; set; }
        public string Name { get; set; }
        public string Unit { get; set; }
        //public decimal Quantity { get; set; }
        public decimal Discount { get; set; }
        public decimal? DiscountMinimumQuantity { get; set; }
        public DateTime? DiscountStartDate { get; set; }
        public DateTime? DiscountEndDate { get; set; }
        public TimeSpan? DiscountStartTime { get; set; }
        public TimeSpan? DiscountEndTime { get; set; }
        public string DiscountType { get; set; }
        public string DiscountLocation { get; set; }
        public string DiscountSalesGroupCode { get; set; }
        public string DiscountItemType { get; set; }
        public decimal Rate { get; set; }
        public decimal? RateMinimumQuantity { get; set; }
        public DateTime? RateStartDate { get; set; }
        public DateTime? RateEndDate { get; set; }
        public string SalesType { get; set; }
        public string SalesCode { get; set; }
        public bool Is_Discountable { get; set; }
        public bool No_Discount { get; set; }
        public bool Is_Vatable { get; set; }
        public bool KeyInWeight { get; set; }
        //public string Location { get; set; }
        //public string LocationwisePriceGroup { get; set; }

    }
}
