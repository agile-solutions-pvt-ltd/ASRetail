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
    public class ItemCategoryController : Controller
    {
        private readonly EntityCore _context;

        public ItemCategoryController(EntityCore context)
        {
            _context = context;
        }

        // GET: ItemCategory
        public async Task<IActionResult> Index()
        {
            return View(await _context.ItemCategory.ToListAsync());
        }

        [HttpGet]
        public IActionResult Get()
        {
            return Ok(_context.ItemCategory);
        }

        // GET: ItemCategory/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var itemCategory = await _context.ItemCategory
                .FirstOrDefaultAsync(m => m.Id == id);
            if (itemCategory == null)
            {
                return NotFound();
            }

            return View(itemCategory);
        }

        // GET: ItemCategory/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: ItemCategory/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Code,Parent_Code,Description,Indentation,Order,Has_Child,Modified_Date")] ItemCategory itemCategory)
        {
            if (ModelState.IsValid)
            {
                itemCategory.Id = Guid.NewGuid().ToString();
                itemCategory.ModifiedDate = DateTime.Now;
                _context.Add(itemCategory);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(itemCategory);
        }

        // GET: ItemCategory/Edit/5
        public async Task<IActionResult> Edit(Guid? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var itemCategory = await _context.ItemCategory.FindAsync(id);
            if (itemCategory == null)
            {
                return NotFound();
            }
            return View(itemCategory);
        }

        // POST: ItemCategory/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, [Bind("Id,Code,Parent_Code,Description,Indentation,Order,Has_Child,Modified_Date")] ItemCategory itemCategory)
        {
            if (id != itemCategory.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    itemCategory.ModifiedDate = DateTime.Now;
                    _context.Update(itemCategory);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ItemCategoryExists(itemCategory.Id))
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
            return View(itemCategory);
        }

        // GET: ItemCategory/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var itemCategory = await _context.ItemCategory
                .FirstOrDefaultAsync(m => m.Id == id);
            if (itemCategory == null)
            {
                return NotFound();
            }

            return View(itemCategory);
        }

        // POST: ItemCategory/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(Guid id)
        {
            var itemCategory = await _context.ItemCategory.FindAsync(id);
            _context.ItemCategory.Remove(itemCategory);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ItemCategoryExists(string id)
        {
            return _context.ItemCategory.Any(e => e.Id == id);
        }
    }
}
