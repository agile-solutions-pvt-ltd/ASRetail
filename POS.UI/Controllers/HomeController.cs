using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using POS.Core;
using POS.UI.Models;
using System;
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
            ViewData["TotalTransaction"] = _context.SalesInvoice.Where(x => x.Trans_Date_Ad.Value.Date == DateTime.Now.Date).Count();
            ViewData["TotalQuantity"] = _context.SalesInvoice.Where(x => x.Trans_Date_Ad.Value.Date == DateTime.Now.Date).Sum(x => x.Total_Quantity);
            ViewData["NewMember"] = _context.Customer.Where(x => x.Created_Date.HasValue && x.Created_Date.Value.Date == DateTime.Now.Date).Count();
            ViewData["TotalCash"] = _context.TodaySalesInvoicePaymentViewModels.Where(x => x.Trans_Mode == "Cash").Sum(x => x.TotalAmount);
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
