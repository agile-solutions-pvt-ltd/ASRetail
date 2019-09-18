using System.Collections.Generic;

namespace POS.DTO
{
    public class FonePay
    {
        public string amount { get; set; }
        public string remarks1 { get; set; }
        public string remarks2 { get; set; }
        public string merchantCode { get; set; }
        public string prn { get; set; }
        public string secret_key { get; set; }
        public string dataValidation { get; set; }
        public string username { get; set; }
        public string password { get; set; }
    }
}
