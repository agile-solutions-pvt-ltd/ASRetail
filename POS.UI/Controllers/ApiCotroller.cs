using AutoMapper;
using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using POS.Core;
using POS.DTO;
using POS.UI.Sync;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

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
                BackgroundJob.Enqueue(() => UpdateCacheItemBackground());

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
        public void UpdateCacheItemBackground()
        {
            _cache.Remove("ItemViewModel");
            //update cache
            IList<ItemViewModel> itemsTotal = new List<ItemViewModel>();
            IList<ItemViewModel> itemsTemp = new List<ItemViewModel>();
            int count = 100000, skip = 0;
            for (; ; )
            {
                try
                {
                    _context.Database.SetCommandTimeout(180);
                    // itemsTemp = _context.ItemViewModel.FromSql("SPItemViewModel @p0, @p1", count, skip).ToList();
                    itemsTemp = _context.ItemViewModel.Skip(skip).Take(count).ToList();
                    if (itemsTemp.Count() == 0 && itemsTotal.Count() > 0)
                    {
                        _cache.Set("ItemViewModel", itemsTotal);
                        break;
                    }
                   
                    itemsTotal = itemsTotal.Concat(itemsTemp).ToList();
                    skip = skip + count;
                   

                }
                catch (Exception ex)
                {
                    break;

                }
            }
        }


    }
}
