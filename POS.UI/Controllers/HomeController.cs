using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using POS.Core;
using POS.DTO;
using POS.UI.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

namespace POS.UI.Controllers
{
    [SessionAuthorized]
    public class HomeController : Controller
    {
        private readonly EntityCore _context;

        public HomeController(EntityCore context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            ViewData["TotalTransaction"] = _context.SalesInvoice.Count();
            ViewData["TotalQuantity"] = _context.SalesInvoiceItems.Sum(x => x.Quantity);
            ViewData["TotalAmount"] = _context.SalesInvoice.Sum(x => x.Total_Payable_Amount);
            ViewData["TotalCash"] = _context.TodaySalesInvoicePaymentViewModels.Where(x => x.Trans_Mode=="Cash").Sum(x=>x.TotalAmount);
            ViewData["TotalCard"] = _context.TodaySalesInvoicePaymentViewModels.Where(x => x.Trans_Mode == "Card").Sum(x => x.TotalAmount);
            ViewData["TotalCreditNote"] = _context.TodaySalesInvoicePaymentViewModels.Where(x => x.Trans_Mode == "Credit Note").Sum(x => x.TotalAmount);

            return View();
        }

        public IActionResult About()
        {

            ViewData["Message"] = Environment.MachineName;





            return View();
        }


        public IActionResult RedirectAfterLogin()
        {
            return RedirectToAction("Landing", "SalesInvoice", new { mode = "tax" });
        }

        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }


        public IActionResult GetFromConsole(string message)
        {
            return Ok();
        }



        public IActionResult SamplePage()
        {
            return View("_SamplePage.cshtml");
        }
    }
}
