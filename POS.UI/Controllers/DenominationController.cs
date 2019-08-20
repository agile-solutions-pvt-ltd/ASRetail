using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using POS.Core;
using POS.DTO;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace POS.UI.Controllers
{
    [RolewiseAuthorized]
    public class DenominationController : Controller
    {
        private readonly EntityCore _context;

        public DenominationController(EntityCore context)
        {
            _context = context;
        }

        // GET: Denomination
        public async Task<IActionResult> Index()
        {
            string userName = User.Identity.Name;
            var entityCore = _context.Denomination.Include(d => d.Terminal).Where(x => x.User_Id == userName).OrderByDescending(x => x.Date).Take(100);
            return View(await entityCore.ToListAsync());
        }

        // GET: Denomination/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var denomination = await _context.Denomination.FindAsync(id);
            TempData["Startingdate"] = denomination.Date.ToShortDateString();
            var terminal = HttpContext.Session.GetString("TerminalId");
            ViewData["Terminal_Id"] = new SelectList(_context.Terminal, "Id", "Name", terminal);
            if (denomination == null)
            {
                return NotFound();
            }
            // TempData["StatusMessage"] = TempData["StatusMessage"];
            // ViewData["Terminal_Id"] = new SelectList(_context.Terminal, "Id", "Name", denomination.Terminal_Id);
            return View(denomination);
        }

        // GET: Denomination/Create
        public IActionResult Create()
        {
            var terminal = HttpContext.Session.GetString("TerminalId");
            ViewData["Terminal_Id"] = new SelectList(_context.Terminal, "Id", "Name", terminal);

            return View();
        }

        // POST: Denomination/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Denomination denomination)
        {
            if (ModelState.IsValid)
            {

                if (denomination.Date.ToShortDateString() != System.DateTime.Now.ToShortDateString())
                {
                    return StatusCode(400, "Date not Up-to-Date !!");
                }
                //check if Session present
                denomination.User_Id = User.Identity.Name;
                IList<Settlement> settlementData = _context.Settlement.Where(x => x.UserId == denomination.User_Id).ToList();
                if (settlementData == null || settlementData.Count == 0)
                {
                    ModelState.AddModelError(string.Empty, "Sorry, No Transaction Found In Your Name !!");
                }
                else if (!settlementData.Any(x => x.Status == "Open"))
                {
                    if (settlementData.Any(x => x.Status == "Closed"))
                        ModelState.AddModelError(string.Empty, "Already Saved, Cannot Save Twice !!");
                    else
                        ModelState.AddModelError(string.Empty, "Sorry, No Transaction Found In Your Name !!");
                }
                else
                {
                    denomination.TotalCash = denomination.Total;//CalcTotalCash(denomination);
                    _context.Add(denomination);

                    await _context.SaveChangesAsync();
                    var newSettlementData = settlementData.Where(x => x.Status == "Open");
                    foreach (var item in newSettlementData)
                    {
                        item.Status = "Closed";
                        item.DenominationId = denomination.Id;
                        _context.Entry(item).State = EntityState.Modified;
                    }
                    await _context.SaveChangesAsync();
                    TempData["StatusMessage"] = "Saved Successfully";
                    return RedirectToAction(nameof(Edit), new { id = denomination.Id });
                }
            }
            ViewData["Terminal_Id"] = new SelectList(_context.Terminal, "Id", "Name", denomination.Terminal_Id);

            return View(denomination);
        }

        // GET: Denomination/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var denomination = await _context.Denomination.FindAsync(id);
            if (denomination == null)
            {
                return NotFound();
            }
            // TempData["StatusMessage"] = TempData["StatusMessage"];
            ViewData["Terminal_Id"] = new SelectList(_context.Terminal, "Id", "Name", denomination.Terminal_Id);
            ViewData["Store"] = JsonConvert.DeserializeObject<Store>(HttpContext.Session.GetString("Store"));
            return View(denomination);
        }

        // POST: Denomination/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, Denomination denomination)
        {
            if (id != denomination.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    denomination.User_Id = User.Identity.Name;
                    _context.Update(denomination);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!DenominationExists(denomination.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["Terminal_Id"] = new SelectList(_context.Terminal, "Id", "Name", denomination.Terminal_Id);
            return View(denomination);
        }

        // GET: Denomination/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var denomination = await _context.Denomination
                .Include(d => d.Terminal)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (denomination == null)
            {
                return NotFound();
            }

            return View(denomination);
        }

        // POST: Denomination/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var denomination = await _context.Denomination.FindAsync(id);
            _context.Denomination.Remove(denomination);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool DenominationExists(int id)
        {
            return _context.Denomination.Any(e => e.Id == id);
        }


        private decimal CalcTotalCash(Denomination denomination)
        {


            var result = (denomination.R05.HasValue ? denomination.R05.Value : 0) +
            (denomination.R1.HasValue ? denomination.R1.Value : 0) +
            (denomination.R10.HasValue ? denomination.R10.Value : 0) +
            (denomination.R100.HasValue ? denomination.R100.Value : 0) +
            (denomination.R1000.HasValue ? denomination.R1000.Value : 0) +
            (denomination.R2.HasValue ? denomination.R2.Value : 0) +
            (denomination.R20.HasValue ? denomination.R20.Value : 0) +
            (denomination.R25.HasValue ? denomination.R25.Value : 0) +
            (denomination.R250.HasValue ? denomination.R250.Value : 0) +
            (denomination.R5.HasValue ? denomination.R5.Value : 0) +
            (denomination.R50.HasValue ? denomination.R50.Value : 0) +
            (denomination.R500.HasValue ? denomination.R500.Value : 0) +
            (denomination.Ric.HasValue ? denomination.Ric.Value : 0);

            return result;
        }
    }
}
