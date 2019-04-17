using System;
using System.Collections.Generic;
using System.Text;

namespace POS.DTO
{
    public  class SalesInvoiceAndCustomerViewModel
    {
        public Customer Customer { get; set; }
        public SalesInvoiceTmp SalesInvoice { get; set; }
       
    }
}
