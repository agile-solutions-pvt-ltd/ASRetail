using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using POS.Core;

namespace POS.UI.Controllers
{

    [RolewiseAuthorized]
    public class CreditInvoiceController : Controller
    {
        private readonly EntityCore _context;

        public CreditInvoiceController(EntityCore context)
        {
            _context = context;
        }

        // GET: Store/Details/5
        public IActionResult Index()
        {
            //

            return View("~/Views/SalesInvoice/CrLanding");
        }

    }
}
