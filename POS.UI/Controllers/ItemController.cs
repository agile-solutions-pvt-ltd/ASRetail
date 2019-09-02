using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Caching.Memory;
using MoreLinq;
using POS.Core;
using POS.DTO;
using POS.UI.Helper;
using POS.UI.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace POS.UI.Controllers
{

    //[Authorize]
    public class ItemController : Controller
    {
        private readonly EntityCore _context;
        private IMemoryCache _cache;
        private readonly IKendoGrid _kendoGrid;
        public ItemController(EntityCore context, IMemoryCache memoryCache, IKendoGrid kendoGrid)
        {
            _context = context;
            _cache = memoryCache;
            _kendoGrid = kendoGrid;
        }

        // GET: Item
        //[RolewiseAuthorized]
        //public async Task<IActionResult> Index()
        //{
        //    return View(await _context.Item.ToListAsync());
        //}

        [RolewiseAuthorized]
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Index(int pageSize, int skip, Filter filter, IEnumerable<Sort> sort)
        {
            var items = _context.Item.AsQueryable();

            // Filter the data first
            var queryable = _kendoGrid.Filter(items, filter);

            // Calculate the total number of records (needed for paging)
            var total = queryable.Count();

            // Sort the data
            queryable = _kendoGrid.Sort(queryable, sort);

            // Finally page the data
            var itemList = await queryable.Skip(skip).Take(pageSize).ToListAsync();
            return Json(new { data = itemList, total = total });
        }

        //[HttpPost]
        //public async Task<IActionResult> Index(int pageSize, int skip, Filter filter, IEnumerable<Sort> sort)
        //{
        //    var newSort = sort.ToList();
        //    if (!newSort.Any())
        //    {
        //        newSort.Add(new Sort { Field = "name", Dir = "asc" });
        //    }

        //    var items = _context.Item;
        //    var itemsList = new List<Item>();

        //    //Sorting by column names.
        //    var sortValue = newSort.FirstOrDefault();
        //    if (sortValue.Field == "name")
        //    {
        //        if (sortValue.Dir == "asc")
        //        {
        //            itemsList = await _context.Item
        //                .OrderBy(x => x.Name)
        //                .Skip(skip)
        //                .Take(pageSize)
        //                .ToListAsync();
        //        }
        //        else
        //        {
        //            itemsList = await _context.Item
        //                .OrderByDescending(x => x.Name)
        //                .Skip(skip)
        //                .Take(pageSize)
        //                .ToListAsync();
        //        }
        //    }
        //    else if (sortValue.Field == "code")
        //    {
        //        if (sortValue.Dir == "asc")
        //        {
        //            itemsList = await _context.Item
        //                .OrderBy(x => x.Code)
        //                .Skip(skip)
        //                .Take(pageSize)
        //                .ToListAsync();
        //        }
        //        else
        //        {
        //            itemsList = await _context.Item
        //                .OrderByDescending(x => x.Code)
        //                .Skip(skip)
        //                .Take(pageSize)
        //                .ToListAsync();
        //        }
        //    }
        //    else if (sortValue.Field == "Unit")
        //    {
        //        if (sortValue.Dir == "asc")
        //        {
        //            itemsList = await _context.Item
        //                .OrderBy(x => x.Unit)
        //                .Skip(skip)
        //                .Take(pageSize)
        //                .ToListAsync();
        //        }
        //        else
        //        {
        //            itemsList = await _context.Item
        //                .OrderByDescending(x => x.Unit)
        //                .Skip(skip)
        //                .Take(pageSize)
        //                .ToListAsync();
        //        }
        //    }
        //    else if (sortValue.Field == "rate")
        //    {
        //        if (sortValue.Dir == "asc")
        //        {
        //            itemsList = await _context.Item
        //                .OrderBy(x => x.Rate)
        //                .Skip(skip)
        //                .Take(pageSize)
        //                .ToListAsync();
        //        }
        //        else
        //        {
        //            itemsList = await _context.Item
        //                .OrderByDescending(x => x.Rate)
        //                .Skip(skip)
        //                .Take(pageSize)
        //                .ToListAsync();
        //        }
        //    }
        //    else
        //    {
        //        itemsList = await _context.Item
        //            .Skip(skip)
        //            .Take(pageSize)
        //            .ToListAsync();
        //    }

        //    int total = items.Count();

        //    return Json(new { total = total, data = itemsList });
        //}

        // GET: Item/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var item = await _context.Item
                .FirstOrDefaultAsync(m => m.Id == id);
            if (item == null)
            {
                return NotFound();
            }

            return View(item);
        }

        // GET: Item/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Item/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Code,Bar_Code,Name,Parent_Code,Type,Unit,Rate,Is_Vatable,Remarks")] Item item)
        {
            if (ModelState.IsValid)
            {
                _context.Add(item);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(item);
        }

        // GET: Item/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var item = await _context.Item.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return View(item);
        }

        // POST: Item/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, [Bind("Id,Code,Bar_Code,Name,Parent_Code,Type,Unit,Rate,Is_Vatable,Remarks")] Item item)
        {
            if (id != item.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(item);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ItemExists(item.Id))
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
            return View(item);
        }

        // GET: Item/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var item = await _context.Item
                .FirstOrDefaultAsync(m => m.Id == id);
            if (item == null)
            {
                return NotFound();
            }

            return View(item);
        }

        // POST: Item/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var item = await _context.Item.FindAsync(id);
            _context.Item.Remove(item);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ItemExists(string id)
        {
            return _context.Item.Any(e => e.Id == id);
        }

        public IEnumerable<ItemViewModel> GetItems(string code, string customerMembershipNo, string storeId = "001")
        {
            var query = "exec Sp_GetItems @ItemCode, @customerMembershipNo, @StoreId";
            IEnumerable<ItemViewModel> data = _context.ItemViewModel.FromSql(query, 
                new SqlParameter("@ItemCode", code),
                new SqlParameter("@customerMembershipNo", customerMembershipNo),
                new SqlParameter("@StoreId", storeId)
                ).ToList();
            return data;
        }

        public IEnumerable<ItemViewModel> GetItemsRawData(string code)
        {

            string query = @"SELECT 
        ROW_NUMBER() OVER(PARTITION BY Bar_Code order by Rate) AS SN ,
       i.Code,i.Id as ItemId,i.Name,i.KeyInWeight,
       ISNULL(b.BarCode,0) as Bar_Code,b.Unit,
	   ISNULL(d.DiscountPercent,0) as Discount,d.MinimumQuantity as DiscountMinimumQuantity, d.StartDate as DiscountStartDate, d.EndDate as DiscountEndDate, d.StartTime as DiscountStartTime, d.EndTime as DiscountEndTime,d.SalesType as DiscountType,d.SalesCode as DiscountSalesGroupCode,d.ItemType as DiscountItemType, d.Location as DiscountLocation,ISNULL(p.AllowLineDiscount,1) as Is_Discountable,i.No_Discount,
	   ISNULL(p.UnitPrice,0) as Rate,p.MinimumQuantity as RateMinimumQuantity, p.StartDate as RateStartDate, p.EndDate as RateEndDate, p.SalesType, p.SalesCode,
	   i.Is_Vatable
FROM ITEM i
left join ITEM_BARCODE b on i.Code = b.ItemCode and b.IsActive = 1
inner join ITEM_PRICE p on i.Code = p.ItemCode
left join ITEM_DISCOUNT d on i.Code = d.ItemCode Or (d.ItemType = 'Item Disc. Group' and  d.ItemCode =  i.DiscountGroup)
where (b.BarCode = {0} or i.Code = {0})";

            IEnumerable<ItemViewModel> data = _context.ItemViewModel.FromSql(query, code);
            var dataAsList = data.ToList();
            return data;

        }


        public void UpdateCacheItemViewModel()
        {
            _cache.Set("IsItemCacheInProcess", true);
            //update cache
            Config config = ConfigJSON.Read();
            //split data to 1lakh and save to cache
            int count = 100000, skip = 0, errorCount = 0;
            DateTime startDate = DateTime.Now;
            //_context.ChangeTracker.AutoDetectChangesEnabled = false;
            for (; ; )
            {
                try
                {
                    IList<ItemViewModel> itemsTotal = new List<ItemViewModel>();
                    _context.Database.SetCommandTimeout(TimeSpan.FromHours(1));
                    //IList<ItemViewModel> itemsTemp = _context.ItemViewModel.FromSql("SPItemViewModel @p0, @p1", count, skip).ToList();
                    IList<ItemViewModel> itemsTemp = _context.ItemViewModel.Skip(skip).Take(count).ToList();
                    if (itemsTemp.Count() > 0)
                    {
                        _cache.TryGetValue("ItemViewModel", out itemsTotal);
                        if (itemsTotal == null)
                        {
                            itemsTotal = new List<ItemViewModel>();
                        }
                        itemsTotal = itemsTotal.Concat(itemsTemp).DistinctBy(x=> new {
                            x.Bar_Code,x.Code,x.Discount,x.DiscountEndDate,x.DiscountEndTime,x.DiscountItemType,x.DiscountLocation,x.DiscountMinimumQuantity,
                            x.DiscountSalesGroupCode,x.DiscountStartDate,x.DiscountStartTime,x.DiscountType,x.Name,x.Rate,x.RateEndDate,x.RateMinimumQuantity,
                            x.RateStartDate,x.SalesCode,x.SalesType}).ToList();
                        _cache.Set("ItemViewModel", itemsTotal);

                    }
                    else
                    {
                        double totalTimeTake = (DateTime.Now - startDate).TotalMinutes;
                        config.Environment = "Total Time take " + totalTimeTake + " Mins";
                        ConfigJSON.Write(config);
                        _cache.Set("IsItemCacheInProcess", false);
                        break;
                    }
                    config.Environment = itemsTotal.Count() + " item cached";
                    // itemsTotal = itemsTotal.Concat(itemsTemp).ToList();
                    skip = skip + count;
                    // config.Environment = itemsTotal.Count() + " item cached";
                    ConfigJSON.Write(config);

                }
                catch (Exception ex)
                {
                    if(ex.Message == "Invalid object name 'ItemViewModel'.")
                    {
                        _cache.Set("IsItemCacheInProcess", true);
                        break;
                    }
                    if (errorCount > 5)
                        break;
                    errorCount += 1;


                }
            }


        }
    }
}
