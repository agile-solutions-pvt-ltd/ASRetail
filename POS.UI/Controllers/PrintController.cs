using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Newtonsoft.Json;
using POS.Core;
using POS.DTO;
using POS.UI.Helper;
using POS.UI.Sync;

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

        public IActionResult CreditNote()
        {
            return View();
        }
        public IActionResult Denomination()
        {
            return View();
        }


    }
}
