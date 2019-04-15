using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using POS.Core;
using POS.DTO;

namespace POS.UI.Controllers
{
    [Authorize]
    public class CreditNoteController : Controller
    {
        private readonly EntityCore _context;

        public CreditNoteController(EntityCore context)
        {
            _context = context;
        }

        public IActionResult Index()
        {           
            ViewData["Customer"] = _context.Customer;
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Index([FromBody] CreditNote creditNote)
        {
            if (ModelState.IsValid)
            {
                creditNote.Id = Guid.NewGuid();
                creditNote.Credit_Note_Id = _context.CreditNote.Select(x => x.Credit_Note_Id).DefaultIfEmpty(0).Max() + 1;
                creditNote.Credit_Note_Number = "CN-" + creditNote.Credit_Note_Id.ToString("0000") + "-075/75";
                creditNote.Trans_Time = DateTime.Now.TimeOfDay;
                creditNote.Division = "Divisioin";
                creditNote.Terminal = "Terminal";
                creditNote.Created_Date = DateTime.Now;
                creditNote.Created_By = "";
                _context.Add(creditNote);

                foreach (var item in creditNote.CreditNoteItems)
                {
                    item.Credit_Note_Id = creditNote.Id;
                    item.Credit_Note_Number = creditNote.Credit_Note_Number;
                    _context.CreditNoteItem.Add(item);
                }
                await _context.SaveChangesAsync();

                //for api return
                TempData["StatusMessage"] = "Credit Note Added Successfully";
                return Ok(new { redirectUrl = "/CreditNote" });
            }
            return View(creditNote);
        }


    }
}