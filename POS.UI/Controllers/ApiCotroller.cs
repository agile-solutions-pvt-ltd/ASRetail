using AutoMapper;
using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using POS.Core;
using POS.DTO;
using POS.UI.Helper;
using POS.UI.Sync;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace POS.UI.Controllers
{
    [Authorize]
    public class ApiController : Controller
    {
        private readonly EntityCore _context;
        private readonly IMapper _mapper;
        private IMemoryCache _cache;
        public ApiController(EntityCore context, IMapper mapper, IMemoryCache memoryCache)
        {
            _context = context;
            _mapper = mapper;
            _cache = memoryCache;
        }


        // GET: Customer
        public IActionResult UpdateCacheCustomer()
        {
            try
            {
                BackgroundJob.Enqueue(() => UpdateCacheCustomerBackground());
               
                var data =new  {
                    Status=  200,
                    Message= "Success"
                };
                return Ok(data);
            }
            catch (Exception ex)
            {
                var data = new
                {
                    Status = 500,
                    Message = "Error :" + ex.Message
                };
                return StatusCode(500, data);
            }
        }
        public void UpdateCacheCustomerBackground()
        {
            _cache.Remove("Customers");
            //update cache
            IList<Customer> itemsTotal = new List<Customer>();
            IList<Customer> itemsTemp = new List<Customer>();
            int count = 100000, skip = 0;
            for (; ; )
            {
                try
                {
                    itemsTemp = _context.Customer.AsNoTracking().Skip(skip).Take(count).ToList();
                    if (itemsTemp.Count() == 0 && itemsTotal.Count() > 0)
                    {
                        _cache.Set("Customers", itemsTotal);
                        break;
                    }

                    itemsTotal = itemsTotal.Concat(itemsTemp).ToList();
                    skip = skip + count;
                }
                catch
                {
                    break;
                }
            }
        }

        // GET: Items
        public IActionResult UpdateCacheItems()
        {
            try
            {
                BackgroundJob.Enqueue(() => UpdateCacheItemViewModel());

                var data = new
                {
                    Status = 200,
                    Message = "Success"
                };
                return Ok(data);
            }
            catch (Exception ex)
            {
                var data = new
                {
                    Status = 500,
                    Message = "Error :" + ex.Message
                };
                return StatusCode(500, data);
            }
        }
        public void UpdateCacheItemViewModel()
        {
            bool IsItemCacheInProcess = false;

            _cache.TryGetValue("IsItemCacheInProcess", out IsItemCacheInProcess);

            if (!IsItemCacheInProcess)
            {
                _cache.Set("IsItemCacheInProcess", true);
                //update cache
                Config config = ConfigJSON.Read();
                //split data to 1lakh and save to cache
                int count = 1000, skip = 0, errorCount = 0;
                DateTime startDate = DateTime.Now;
                //_context.ChangeTracker.AutoDetectChangesEnabled = false;
                for(; ; )
                {
                    try
                    {
                        IList<ItemViewModel> itemsTotal = new List<ItemViewModel>();
                        _cache.TryGetValue("ItemViewModel", out itemsTotal);
                        if (itemsTotal == null)
                        {
                            _cache.Set("IsItemCacheInProcess", false);
                            break;
                        }
                      
                        _context.Database.SetCommandTimeout(TimeSpan.FromHours(1));
                        var listOfItemsChanged = _context.ItemUpdateTrigger.Skip(skip).Take(count).ToList();
                        var listOfItemsCodeToLoad = listOfItemsChanged.Where(x => x.ACTIONS != "Delete")
                            .Select(x => x.ITEMCODE).Distinct().ToList();

                        var listOfItemsChangedCode = listOfItemsChanged.Select(x => x.ITEMCODE).Distinct().ToList();
                        foreach (var i in listOfItemsChangedCode)
                        {
                            var listOfItemsToDelete = itemsTotal.Where(x => x.Code == i).ToList();
                            foreach (var j in listOfItemsToDelete)
                            {
                                itemsTotal.Remove(j);
                            }

                        }

                        string listOfItemsCodeString = string.Join(",", listOfItemsCodeToLoad);
                        IList<ItemViewModel> itemsTemp = _context.ItemViewModel.FromSql("SPItemViewModel {0}", listOfItemsCodeString).ToList();
                        if (itemsTemp.Count() > 0)
                        {

                            itemsTotal = itemsTotal.Concat(itemsTemp).ToList();
                            _cache.Set("ItemViewModel", itemsTotal);

                            //now remove trigger from database
                            _context.RemoveRange(listOfItemsChanged);
                            _context.SaveChanges();

                            double totalTimeTake = (DateTime.Now - startDate).TotalMinutes;
                            config.Environment = "Total Time take " + totalTimeTake + " Mins";
                            ConfigJSON.Write(config);
                            _cache.Set("IsItemCacheInProcess", false);
                            break;

                        }
                        else
                        {
                            _cache.Set("IsItemCacheInProcess", false);
                            break;
                        }


                    }
                    catch (Exception ex)
                    {
                        if (errorCount > 5)
                        {
                            _cache.Set("IsItemCacheInProcess", false);
                             break;
                        }
                        errorCount += 1;


                    }
                }
               

            }


        }


    }
}
