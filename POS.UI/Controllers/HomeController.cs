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
    [Authorize]
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
