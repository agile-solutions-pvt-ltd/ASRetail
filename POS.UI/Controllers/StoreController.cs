using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using POS.Core;
using POS.DTO;
using System.Linq;
using System.Threading.Tasks;

namespace POS.UI.Controllers
{

    [RolewiseAuthorized]
    public class StoreController : Controller
    {
        private readonly EntityCore _context;

        public StoreController(EntityCore context)
        {
            _context = context;
        }

        // GET: Store/Details/5
        public async Task<IActionResult> Index()
        {
            //POS.UI.Sync.NavSync sync = new Sync.NavSync(_context);
            //sync.CompanySync();


            var store = await _context.Store
                .FirstOrDefaultAsync();
            if (store == null)
            {
                return NotFound();
            }

            return View(store);
        }


        // GET: Store/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var store = await _context.Store.FindAsync(id);
            if (store == null)
            {
                return NotFound();
            }
            return View(store);
        }

        // POST: Store/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, [Bind("ID,INITIAL,NAME,COMPANY_NAME,ADDRESS,PHONE,PHONE_ALT,FAX,VAT,EMAIL,WEBSITE,FISCAL_YEAR")] Store store)
        {
            if (id != store.ID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(store);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!StoreExists(store.ID))
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
            return View(store);
        }


        private bool StoreExists(string id)
        {
            return _context.Store.Any(e => e.ID == id);
        }












        //// GET: Store/Create
        //public IActionResult Create()
        //{
        //    return View();
        //}

        //// POST: Store/Create
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> Create([Bind("ID,INITIAL,NAME,COMPANY_NAME,ADDRESS,PHONE,PHONE_ALT,FAX,VAT,EMAIL,WEBSITE,FISCAL_YEAR")] Store store)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        _context.Add(store);
        //        await _context.SaveChangesAsync();
        //        return RedirectToAction(nameof(Index));
        //    }
        //    return View(store);
        //}


        //// GET: Store/Delete/5
        //public async Task<IActionResult> Delete(int? id)
        //{
        //    if (id == null)
        //    {
        //        return NotFound();
        //    }

        //    var store = await _context.Store
        //        .FirstOrDefaultAsync(m => m.ID == id);
        //    if (store == null)
        //    {
        //        return NotFound();
        //    }

        //    return View(store);
        //}

        //// POST: Store/Delete/5
        //[HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> DeleteConfirmed(int id)
        //{
        //    var store = await _context.Store.FindAsync(id);
        //    _context.Store.Remove(store);
        //    await _context.SaveChangesAsync();
        //    return RedirectToAction(nameof(Index));
        //}


    }
}
