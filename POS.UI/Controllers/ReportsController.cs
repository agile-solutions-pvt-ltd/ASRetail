using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using POS.Core;
using POS.DTO;
using System;
using System.Linq;

namespace POS.UI.Controllers
{
    [SessionAuthorized]
    public class ReportsController : Controller
    {
        private readonly EntityCore _context;

        public ReportsController(EntityCore context)
        {
            _context = context;
        }

        public IActionResult SalesInvoice()
        {

            //IQueryable<SalesInvoice> salesInvoiceList =_context.SalesInvoice.Where(x => x.Trans_Type == "Sales").OrderByDescending(x => x.Trans_Date_Ad);
            ViewData["Store"] = _context.Store.FirstOrDefault();
            return View();
        }
        public IActionResult SalesInvoiceApi(DateTime? startdate = null, DateTime? enddate = null)
        {

            //ViewBag.StartDate = _startDate.ToShortDateString();
            //ViewBag.EndDate = _endDate.ToShortDateString();
            DateTime _startDate = startdate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            DateTime _endDate = enddate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            IQueryable<SalesInvoice> salesInvoiceList = _context.SalesInvoice.Where(x => x.Trans_Date_Ad >= _startDate && x.Trans_Date_Ad <= _endDate && x.Trans_Type=="Sales").Include(x=>x.SalesInvoiceItems).OrderByDescending(x => x.Trans_Date_Ad);
           // IQueryable<SalesInvoice> salesInvoiceList = _context.SalesInvoice.Where(x => x.Trans_Type == "Sales").Include(x => x.SalesInvoiceItems).OrderByDescending(x => x.Trans_Date_Ad);
            return Ok(salesInvoiceList);
        }

        public IActionResult TaxInvoice()
        {
            //IQueryable<SalesInvoice> salesInvoiceList = _context.SalesInvoice.Where(x => x.Trans_Type == "Tax").OrderByDescending(x => x.Trans_Date_Ad);
            ViewData["Store"] = _context.Store.FirstOrDefault();
            return View();
        }

        public IActionResult TaxInvoiceApi(DateTime? startdate = null, DateTime? enddate = null)
        {
            DateTime _startDate = startdate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            DateTime _endDate = enddate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            IQueryable<SalesInvoice> salesInvoiceList = _context.SalesInvoice.Where(x => x.Trans_Type == "Tax" && x.Trans_Date_Ad >= _startDate && x.Trans_Date_Ad <= _endDate).Include(x => x.SalesInvoiceItems).OrderByDescending(x => x.Trans_Date_Ad);
            return Ok(salesInvoiceList);
        }

        public IActionResult CreditNote()
        {
            // IQueryable<CreditNote> creditNoteList = _context.CreditNote.OrderByDescending(x => x.Trans_Date_Ad);
            ViewData["Store"] = _context.Store.FirstOrDefault();
            return View();
        }

        public IActionResult CreditNoteApi(DateTime? startdate = null, DateTime? enddate = null)
        {
            DateTime _startDate = startdate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            DateTime _endDate = enddate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            IQueryable<CreditNote> creditNoteList = _context.CreditNote.Where(x => x.Trans_Date_Ad >= _startDate && x.Trans_Date_Ad <= _endDate).Include(x => x.CreditNoteItems).OrderByDescending(x => x.Trans_Date_Ad);
            return Ok(creditNoteList);
        }


        public IActionResult SalesVatBook(DateTime? StartDate = null, DateTime? EndDate = null,string TransType=null)
        {
            ViewData["Store"] = _context.Store.FirstOrDefault();
            //IQueryable<SalesInvoice> salesInvoiceList = _context.SalesInvoice.OrderByDescending(x => x.Trans_Date_Ad);
            //if (StartDate != null)
            //    salesInvoiceList = salesInvoiceList.Where(x => x.Trans_Date_Ad >= StartDate);
            //if (EndDate != null)
            //    salesInvoiceList = salesInvoiceList.Where(x => x.Trans_Date_Ad <= EndDate);
            //return View(salesInvoiceList);

            DateTime _startDate = StartDate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            DateTime _endDate = EndDate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            string _TransType = TransType ?? "All";
            TempData["TransType"] = _TransType;
            IQueryable<SalesVatBookReport> salesInvoiceList = _context.SalesVatBookReport.FromSql($"SpSalesVatBookRpt {_startDate},{_endDate},{_TransType}");
            return View(salesInvoiceList);

        }

        public IActionResult InvoiceMaterial(DateTime? StartDate = null, DateTime? EndDate = null)
        {
            ViewData["Store"] = _context.Store.FirstOrDefault();
            IQueryable<InvoiceMaterializedView> salesInvoiceList = _context.InvoiceMaterializedView.OrderByDescending(x => x.BillNo);
            if (StartDate != null)
                salesInvoiceList = salesInvoiceList.Where(x => x.BillDate >= StartDate);
            if (EndDate != null)
                salesInvoiceList = salesInvoiceList.Where(x => x.BillDate <= EndDate);
            return View(salesInvoiceList);
        }

        // Niroj Start
        public IActionResult InvoiceSales()
        {
            //IQueryable<SalesInvoice> salesInvoiceList =_context.SalesInvoice.Where(x => x.Trans_Type == "Sales").OrderByDescending(x => x.Trans_Date_Ad);
            ViewData["Store"] = _context.Store.FirstOrDefault();
            return View();
        }

        public IActionResult InvoiceSalesApi(DateTime? startdate = null, DateTime? enddate = null)
        {
            DateTime _startDate = startdate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            DateTime _endDate = enddate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            //ViewBag.StartDate = _startDate.ToShortDateString();
            //ViewBag.EndDate = _endDate.ToShortDateString();

            IQueryable<SalesInvoice> salesInvoiceList = _context.SalesInvoice.Where(x => x.Trans_Date_Ad >= _startDate && x.Trans_Date_Ad <= _endDate).OrderByDescending(x => x.Trans_Date_Ad).Include(x => x.SalesInvoiceItems);
            return Ok(salesInvoiceList);
        }
        public IActionResult SalesInvoiceUserwise()
        {
            //IQueryable<SalesInvoice> salesInvoiceList =_context.SalesInvoice.Where(x => x.Trans_Type == "Sales").OrderByDescending(x => x.Trans_Date_Ad);
            ViewData["Store"] = _context.Store.FirstOrDefault();
            return View();
        }


        public IActionResult SalesInvoiceAggregate()
        {
            //IQueryable<SalesInvoice> salesInvoiceList =_context.SalesInvoice.Where(x => x.Trans_Type == "Sales").OrderByDescending(x => x.Trans_Date_Ad);
            ViewData["Store"] = _context.Store.FirstOrDefault();
            return View();
        }

        public IActionResult SalesInvoiceAggregateApi(DateTime? startdate = null, DateTime? enddate = null)
        {
            DateTime _startDate = startdate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            DateTime _endDate = enddate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            IQueryable<SpSalesInvoiceAggregateGet> salesInvoiceAggregateList = _context.SpSalesInvoiceAggregateGet.FromSql($"SpSalesInvoiceAggregateGet {_startDate},{_endDate}");

            //IQueryable<SpSalesInvoiceAggregateGet> salesInvoiceAggregateList = _context.SpSalesInvoiceAggregateGet.FromSql($"SpSalesInvoiceAggregateGet").Where(x => x.Trans_Date_AD >= _startDate && x.Trans_Date_AD <= _endDate);
            return Ok(salesInvoiceAggregateList);
        }
        //Niroj End


        public IActionResult SalesInvoiceSummary()
        {
            //IQueryable<SalesInvoice> salesInvoiceList =_context.SalesInvoice.Where(x => x.Trans_Type == "Sales").OrderByDescending(x => x.Trans_Date_Ad);
            // ViewData["Store"] = _context.Store.FirstOrDefault();
            return View();
        }
        public IActionResult SalesInvoiceSummaryApi(DateTime? StartDate = null, DateTime? EndDate = null)
        {

            IQueryable<SettlementSummaryView> salesInvoiceList = _context.SettlementSummaryView.OrderByDescending(x => x.Date);
            if (StartDate != null)
                salesInvoiceList = salesInvoiceList.Where(x => x.Date >= StartDate);
            if (EndDate != null)
                salesInvoiceList = salesInvoiceList.Where(x => x.Date <= EndDate);
            return Ok(salesInvoiceList);
        }


        //Author - Santosh Sapkota
        public IActionResult WholeSaleTaxInvoice()
        {
            ViewData["Store"] = _context.Store.FirstOrDefault();
            return View();
        }
        public IActionResult WholeSaleTaxInvoiceApi(DateTime? startdate, DateTime? enddate)
        {
            DateTime _startDate = startdate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            DateTime _endDate = enddate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            IQueryable<SalesInvoice> salesInvoiceList = _context.SalesInvoice.Where(x => x.Trans_Type == "Tax" && x.Trans_Date_Ad >= _startDate && x.Trans_Date_Ad <= _endDate).Include(x => x.SalesInvoiceItems).OrderByDescending(x => x.Trans_Date_Ad);
            return Ok(salesInvoiceList);
        }

        [HttpPost]
        public ActionResult Excel_Export_Save(string contentType, string base64, string fileName)
        {
            var fileContents = Convert.FromBase64String(base64);

            return File(fileContents, contentType, fileName);
        }
    }
}