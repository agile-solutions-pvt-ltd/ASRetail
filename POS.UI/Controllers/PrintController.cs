using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using POS.Core;
using System;
using System.Collections.Generic;
using System.Linq;

namespace POS.UI.Controllers
{
    [Authorize]
    public class PrintController : Controller
    {
        private readonly EntityCore _context;


        public PrintController(EntityCore context, IMapper mapper)
        {
            _context = context;

        }

        public IActionResult SalesInvoice()
        {
            return View();
        }

        public IActionResult TaxInvoice()
        {
            return View();
        }

        public IActionResult NewTaxInvoice()
        {
            return View();
        }

        public IActionResult CreditNote()
        {
            return View();
        }

        public IActionResult WholeSaleCreditNote()
        {
            return View();
        }

        public IActionResult Denomination()
        {
            return View();
        }

        public IActionResult Settlement()
        {
            return View();
        }




        [HttpPost]
        public IActionResult GetPrintCount(string invoiceNumber)
        {
            var printCount = _context.InvoicePrint.FirstOrDefault(x => x.InvoiceNumber == invoiceNumber);
            var billData = _context.SalesInvoiceBill.Where(x => x.Invoice_Number == invoiceNumber);
            string paymentMode = string.Join(", ", billData.Select(x => x.Trans_Mode).Distinct());
            return Ok(new { printCount = printCount, paymentMode = paymentMode, billData = billData });
        }
        [HttpPost]
        public IActionResult UpdatePrintCount(string invoiceNumber)
        {
            var printCount = _context.InvoicePrint.FirstOrDefault(x => x.InvoiceNumber == invoiceNumber);
            if (printCount != null)
            {
                printCount.PrintCount += 1;
                printCount.PrintedBy = User.Identity.Name;
                printCount.PrintedDate = DateTime.Now;

                _context.Entry(printCount).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                _context.SaveChanges();
            }
            return Ok();
        }


    }
}
