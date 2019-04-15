using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using POS.Core;

namespace POS.UI.Controllers
{
    public class SettingsController : Controller
    {
        private readonly EntityCore _context;

        public SettingsController(EntityCore context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult GetMenu()
        {
            return Ok(_context.Menu.ToList());
        }


        [HttpGet]
        public IActionResult Shortcuts()
        {
            return View();
        }

    }
}
