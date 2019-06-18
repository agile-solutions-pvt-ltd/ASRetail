using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using POS.Core;
using POS.DTO;

namespace POS.UI.Controllers
{
    [RolewiseAuthorized]
    public class ItemGroupController : Controller
    {
        private readonly EntityCore _context;

        public ItemGroupController(EntityCore context)
        {
            _context = context;
        }

        // GET: ItemGroup
        public async Task<IActionResult> Index()
        {
            return View(await _context.ItemGroup.ToListAsync());
        }

        // GET: ItemGroup/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var itemGroup = await _context.ItemGroup
                .FirstOrDefaultAsync(m => m.Id == id);
            if (itemGroup == null)
            {
                return NotFound();
            }

            return View(itemGroup);
        }

        // GET: ItemGroup/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: ItemGroup/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Code,Description,Item_Category_Code")] ItemGroup itemGroup)
        {
            if (ModelState.IsValid)
            {
                _context.Add(itemGroup);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(itemGroup);
        }

        // GET: ItemGroup/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var itemGroup = await _context.ItemGroup.FindAsync(id);
            if (itemGroup == null)
            {
                return NotFound();
            }
            return View(itemGroup);
        }

        // POST: ItemGroup/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Code,Description,Item_Category_Code")] ItemGroup itemGroup)
        {
            if (id != itemGroup.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(itemGroup);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ItemGroupExists(itemGroup.Id))
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
            return View(itemGroup);
        }

        // GET: ItemGroup/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var itemGroup = await _context.ItemGroup
                .FirstOrDefaultAsync(m => m.Id == id);
            if (itemGroup == null)
            {
                return NotFound();
            }

            return View(itemGroup);
        }

        // POST: ItemGroup/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var itemGroup = await _context.ItemGroup.FindAsync(id);
            _context.ItemGroup.Remove(itemGroup);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ItemGroupExists(int id)
        {
            return _context.ItemGroup.Any(e => e.Id == id);
        }
    }
}
