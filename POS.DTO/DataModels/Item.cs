using System.ComponentModel.DataAnnotations;

namespace POS.DTO
{
    public partial class Item
    {
        // [Key]
        //[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public string Id { get; set; }
        [Key]
        public string Code { get; set; }
        public string Bar_Code { get; set; }
        public string Name { get; set; }
        public string Parent_Code { get; set; }
        public string Type { get; set; }
        public string Unit { get; set; }
        public decimal? Rate { get; set; } = 0;
        public decimal Discount { get; set; }
        public bool Is_Discountable { get; set; }
        public bool No_Discount { get; set; }
        public bool? Is_Vatable { get; set; } = false;
        public bool KeyInWeight { get; set; } = false;
        public bool? Is_Active { get; set; } = true;
        public string Remarks { get; set; }
        public string VendorNumber { get; set; }
        public string DiscountGroup { get; set; }

        public Item UpdateItem(Item item)
        {
            var itemToReturn = new Item();
            item.Code = itemToReturn.Code;
            return itemToReturn;
        }
    }
}
