using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using POS.Core;
using POS.DTO;

namespace POS.UI.Controllers
{
    [Authorize]
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
            var entityCore = _context.Denomination.Include(d => d.Terminal);
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
            ViewData["Terminal_Id"] = new SelectList(_context.Terminal, "Id", "Name");
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
                //check if Session present
                denomination.User_Id = this.User.FindFirstValue(ClaimTypes.NameIdentifier);
                IList<Settlement> settlementData = _context.Settlement.Where(x => x.TerminalId == denomination.Terminal_Id && x.UserId == denomination.User_Id).ToList();
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
                    _context.Add(denomination);

                    await _context.SaveChangesAsync();
                    var newSettlementData = settlementData.Where(x => x.Status == "Open");
                    foreach (var item in newSettlementData)
                    {
                        item.Status = "Closed";
                        item.DenominationId = denomination.Id;
                        item.DenominationAmount = denomination.Total.Value;
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
                    denomination.User_Id = this.User.FindFirstValue(ClaimTypes.NameIdentifier);
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
    }
}
