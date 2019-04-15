using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using POS.Core;
using POS.DTO;

namespace POS.UI.Controllers
{
    [Authorize]
    public class ReportsController : Controller
    {
        private readonly EntityCore _context;

        public ReportsController(EntityCore context)
        {
            _context = context;
        }

        public IActionResult SalesInvoice()
        {
           IQueryable<SalesInvoice> salesInvoiceList =_context.SalesInvoice.Where(x => x.Trans_Type == "Sales").OrderByDescending(x => x.Trans_Date_Ad);
            return View(salesInvoiceList);
        }

        public IActionResult TaxInvoice()
        {
            IQueryable<SalesInvoice> salesInvoiceList = _context.SalesInvoice.Where(x => x.Trans_Type == "Tax").OrderByDescending(x => x.Trans_Date_Ad);
            return View(salesInvoiceList);
        }

        public IActionResult CreditNote()
        {
            IQueryable<CreditNote> creditNoteList = _context.CreditNote.OrderByDescending(x => x.Trans_Date_Ad);
            return View(creditNoteList);
        }
    }
}