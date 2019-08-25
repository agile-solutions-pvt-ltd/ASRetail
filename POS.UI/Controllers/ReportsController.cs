using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using POS.Core;
using POS.DTO;
using POS.UI.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace POS.UI.Controllers
{
    [SessionAuthorized]
    public class ReportsController : Controller
    {
        private readonly EntityCore _context;
        private readonly IMapper _mapper;
        private IMemoryCache _cache;
        private readonly IKendoGrid _kendoGrid;

        public ReportsController(EntityCore context, IMapper mapper, IMemoryCache memoryCache, IKendoGrid kendoGrid)
        {
            _context = context;
            _mapper = mapper;
            _cache = memoryCache;
            _kendoGrid = kendoGrid;
        }

        [RolewiseAuthorized]
        public IActionResult SalesInvoice()
        {

            //IQueryable<SalesInvoice> salesInvoiceList =_context.SalesInvoice.Where(x => x.Trans_Type == "Sales").OrderByDescending(x => x.Trans_Date_Ad);
            ViewData["Store"] = _context.Store.FirstOrDefault();
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> SalesInvoiceApi(int pageSize, int skip,DateTime? startdate = null, DateTime? enddate = null)


             

        {

            //ViewBag.StartDate = _startDate.ToShortDateString();
            //ViewBag.EndDate = _endDate.ToShortDateString();
            DateTime _startDate = startdate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            DateTime _endDate = enddate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            string _TransType = "Sales";
            var salesInvoiceContext = _context.SpSalesInvoiceSel.Where(x => x.Trans_Date_Ad >= _startDate && x.Trans_Date_Ad <= _endDate && x.Trans_Type == _TransType).Include(x => x.SalesInvoiceItems).AsQueryable();

            //var salesInvoiceContext = _context.SalesInvoice.Where(x => x.Trans_Date_Ad >= _startDate && x.Trans_Date_Ad <= _endDate && x.Trans_Type=="Sales").Include(x=>x.SalesInvoiceItems).OrderByDescending(x => x.Trans_Date_Ad).AsQueryable();
          

            

            // Calculate the total number of records (needed for paging)
        

            var role = ((ClaimsIdentity)User.Identity).Claims
               .Where(c => c.Type == ClaimTypes.Role)
               .Select(c => c.Value).FirstOrDefault();
            Decimal total = 0, grossAmountTotal = 0, discountTotal = 0, netTotal = 0;
            if (role != "CASHIER")
            {
                total = salesInvoiceContext.Count();



                grossAmountTotal = salesInvoiceContext.Sum(x => x.Total_Gross_Amount);



                discountTotal = salesInvoiceContext.Sum(x => x.Total_Discount);



                netTotal = salesInvoiceContext.Sum(x => x.Total_Net_Amount);
            }


            // Sort the data
             //queryable = _kendoGrid.Sort(queryable, sort);

            // Finally page the data
            var salesInvoiceList = await salesInvoiceContext.Skip(skip).Take(pageSize).ToListAsync();
          

            return Json(new { data = salesInvoiceList, total = total, grossAmountTotal= grossAmountTotal, discountTotal= discountTotal, netTotal= netTotal });
           // return Ok(salesInvoiceContext);
           
        }

        [RolewiseAuthorized]
        public IActionResult TaxInvoice()
        {
            //IQueryable<SalesInvoice> salesInvoiceList = _context.SalesInvoice.Where(x => x.Trans_Type == "Tax").OrderByDescending(x => x.Trans_Date_Ad);
            ViewData["Store"] = _context.Store.FirstOrDefault();
            return View();
        }

        public async Task<IActionResult> TaxInvoiceApi(int pageSize, int skip, Filter filter, DateTime? startdate = null, DateTime? enddate = null)
        {
            DateTime _startDate = startdate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            DateTime _endDate = enddate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
         
            string _TransType = "Tax";
            var salesInvoiceContext = _context.SpSalesInvoiceSel.Where(x => x.Trans_Date_Ad >= _startDate && x.Trans_Date_Ad <= _endDate && x.Trans_Type == _TransType).Include(x => x.SalesInvoiceItems).AsQueryable();

            //var salesInvoiceContext = _context.SalesInvoice.Where(x => x.Trans_Date_Ad >= _startDate && x.Trans_Date_Ad <= _endDate && x.Trans_Type=="Sales").Include(x=>x.SalesInvoiceItems).OrderByDescending(x => x.Trans_Date_Ad).AsQueryable();


            var queryable = _kendoGrid.Filter(salesInvoiceContext, filter);

            // Calculate the total number of records (needed for paging)
            var role = ((ClaimsIdentity)User.Identity).Claims
               .Where(c => c.Type == ClaimTypes.Role)
               .Select(c => c.Value).FirstOrDefault();
            Decimal total = 0, grossAmountTotal = 0, discountTotal = 0, netTotal = 0;
            if (role != "CASHIER")
            {
                total = queryable.Count();



                grossAmountTotal = queryable.Sum(x => x.Total_Gross_Amount);



                discountTotal = queryable.Sum(x => x.Total_Discount);



                netTotal = queryable.Sum(x => x.Total_Net_Amount);
            }





            // Sort the data
          

            // Finally page the data
            var salesInvoiceList = await queryable.Skip(skip).Take(pageSize).ToListAsync();


            return Json(new { data = salesInvoiceList, total = total, grossAmountTotal = grossAmountTotal, discountTotal = discountTotal, netTotal = netTotal });
        }
        [RolewiseAuthorized]
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

      [RolewiseAuthorized]
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
        
        [RolewiseAuthorized]
        public IActionResult InvoiceMaterial(DateTime? StartDate = null, DateTime? EndDate = null)
        {
            ViewData["Store"] = _context.Store.FirstOrDefault();
            DateTime _startDate = StartDate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            DateTime _endDate = EndDate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            IQueryable<InvoiceMaterializedView> salesInvoiceList = _context.InvoiceMaterializedView.Where(x => x.BillDate >= _startDate && x.BillDate <= _endDate).OrderByDescending(x => x.BillNo);
           
            return View(salesInvoiceList);
        }
        [RolewiseAuthorized]
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

            IQueryable<SalesInvoice> salesInvoiceList = _context.SalesInvoice
                .Where(x => x.Trans_Date_Ad >= _startDate && x.Trans_Date_Ad <= _endDate)
                .Include(x => x.SalesInvoiceItems)
                .OrderByDescending(x => x.Trans_Date_Ad);

            return Ok(salesInvoiceList);
        }
        [RolewiseAuthorized]
        public IActionResult SalesInvoiceUserwise()
        {
            //IQueryable<SalesInvoice> salesInvoiceList =_context.SalesInvoice.Where(x => x.Trans_Type == "Sales").OrderByDescending(x => x.Trans_Date_Ad);
            ViewData["Store"] = _context.Store.FirstOrDefault();
            return View();
        }

        [RolewiseAuthorized]
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

        [RolewiseAuthorized]
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

        [RolewiseAuthorized]
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
        //[RolewiseAuthorized]

        public IActionResult AbbreviatedSalesReport(DateTime? StartDate = null, DateTime? EndDate = null)

        {
            ViewData["Store"] = _context.Store.FirstOrDefault();
            //IQueryable<SalesInvoice> salesInvoiceList = _context.SalesInvoice.OrderByDescending(x => x.Trans_Date_Ad);
            //if (StartDate != null)
            //    salesInvoiceList = salesInvoiceList.Where(x => x.Trans_Date_Ad >= StartDate);
            //if (EndDate != null)
            //    salesInvoiceList = salesInvoiceList.Where(x => x.Trans_Date_Ad <= EndDate);
            //return View(salesInvoiceList);

            DateTime _startDate = StartDate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day).AddDays(-7);
            DateTime _endDate = EndDate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);

            TempData["FromDate"] = _startDate.ToString("yyyy-MM-dd");
            TempData["ToDate"] = _endDate.Date.ToString("yyyy-MM-dd");
            IQueryable<AbbreviatedSalesReport> salesInvoiceList = _context.AbbreviatedSalesReport.FromSql($"SpAbbreviatedSalesReport {_startDate},{_endDate}");
            return View(salesInvoiceList);

        }

        [HttpPost]
        public ActionResult Excel_Export_Save(string contentType, string base64, string fileName)
        {
            var fileContents = Convert.FromBase64String(base64);

            return File(fileContents, contentType, fileName);
        }
    }
}